
function Expand-KitFile {
	param (
		[Parameter(Mandatory = $true)]
		[string]$KitFile,
		[Parameter(Mandatory = $true)]
		[string]$DestinationFolder
	)

	$Obj = New-Object -ComObject CapaInstaller.Scripting.Extract
	$Obj.ExtractZip($KitFile, $DestinationFolder)
}


<#
	.SYNOPSIS
		Get the directory of the current script.

	.DESCRIPTION
		Get the directory of the current script. It is better than $PSScriptRoot because it works also when running the script line by line in the console.
#>
Function Get-ScriptDirectory {
	#neccessary so different powershell editors can be used
	Switch ($Host.name) {
		'Visual Studio Code Host' { Split-Path $psEditor.GetEditorContext().CurrentFile.Path }
		'Windows PowerShell ISE Host' { Split-Path -Path $psISE.CurrentFile.FullPath }
		'ConsoleHost' { $PSScriptRoot }
	}
}


<#
	.SYNOPSIS
		Downloads a file from CI server using the BaseAgent.

	.DESCRIPTION
		Downloads a file from server using the BaseAgent.

	.PARAMETER RemotePath
		The path of the file to download.

	.PARAMETER LocalPath
		The folder or specific path where the file will be downloaded to.

	.EXAMPLE
		Invoke-BaseAgentDownloadFile -RemotePath "\Resources/AgentInstaller/CapaInstaller agent.xml" -LocalPath "c:\temp"

	.EXAMPLE
		Invoke-BaseAgentDownloadFile -RemotePath "\Resources/AgentInstaller/CapaInstaller agent.xml" -LocalPath "c:\temp\CapaInstaller agent.xml"

	.NOTES
		This function requires the Capa BaseAgent to be installed on the machine.
#>
function Invoke-BaseAgentDownloadFile {
	param (
		[Parameter(Mandatory = $true)]
		[string]$RemotePath,
		[Parameter(Mandatory = $true)]
		[string]$LocalPath
	)
	$LocalPort = Get-ItemProperty -Path 'HKLM:\SOFTWARE\CapaSystems\BaseAgent' -Name 'LocalPort' | Select-Object -ExpandProperty LocalPort
	$BaseURL = "http://localhost:$LocalPort/file"

	$FileName = Split-Path -Path $RemotePath -Leaf
	if (Test-Path $LocalPath -PathType Container) {
		$LocalPath = Join-Path -Path $LocalPath -ChildPath $FileName
	}

	$LocalPath = $LocalPath.Replace('/', '\')
	$LocalPath = $LocalPath.Replace('\', '\\')
	$RemotePath = $RemotePath.Replace('\', "/")

	$Json = "{
	`"remote-location`": `"$RemotePath`",
	`"local-location`": `"$LocalPath`",
	`"local-progress`": 0,
	`"tag`": `"Mark5900`"
}"

	$Response = Invoke-WebRequest -Uri $BaseURL -Method Post -Body $Json -ContentType 'application/json'
	if ($Response.Headers.Keys -contains 'Location') {
		$FileID = $Response.Headers.Location.Split('/')[-1]
	} else {
		throw 'Failed to download package'
	}

	Start-Sleep -Seconds 5

	$FileIdURL = "$BaseURL/$FileID"
	$Run = $true
	while ($Run) {
		$Result = Invoke-WebRequest -Uri $FileIdURL -Method Get
		if ($Result.Content -like '*"status": "completed"*') {
			$Run = $false
		} elseif ($Result.Content -like '*"status": "failed"*') {
			throw 'Failed to download package'
		}
		Start-Sleep -Seconds 1
	}
}


<#
	.SYNOPSIS
		Downloads a Capa package from CI server using the BaseAgent.

	.DESCRIPTION
		Downloads a Capa package from server using the BaseAgent.

	.PARAMETER PackageName
		The name of the package to download.

	.PARAMETER PackageVersion
		The version of the package to download.

	.PARAMETER DestinationFolder
		The folder where the package will be downloaded and extracted to.

	.EXAMPLE
		Invoke-DownloadCapaPackage -PackageName 'CP CapaDrivers Latitude 5440' -PackageVersion 'W10 Custom' -DestinationFolder 'c:\temp\Test'

	.NOTES
		This function requires the Capa BaseAgent to be installed on the machine.
#>
function Invoke-DownloadCapaPackage {
	param (
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[string]$DestinationFolder
	)
	$LocalPort = Get-ItemProperty -Path 'HKLM:\SOFTWARE\CapaSystems\BaseAgent' -Name 'LocalPort' | Select-Object -ExpandProperty LocalPort
	$BaseURL = "http://localhost:$LocalPort/file"
	$RemotePath = "/ComputerJobs/$PackageName/$PackageVersion/Zip/CapaInstaller.kit"

	$KitLocalPath = Join-Path $DestinationFolder 'CapaInstaller.kit'
	$KitLocalPath = $KitLocalPath.Replace('\', '\\')

	$Json = "{
	`"remote-location`": `"$RemotePath`",
	`"local-location`": `"$KitLocalPath`",
	`"local-progress`": 0,
	`"tag`": `"Mark5900`"
}"

	$Response = Invoke-WebRequest -Uri $BaseURL -Method Post -Body $Json -ContentType 'application/json'
	if ($Response.Headers.Keys -contains 'Location') {
		$FileID = $Response.Headers.Location.Split('/')[-1]
	} else {
		throw 'Failed to download package'
	}

	Start-Sleep -Seconds 5

	$FileIdURL = "$BaseURL/$FileID"
	$Run = $true
	while ($Run) {
		$Result = Invoke-WebRequest -Uri $FileIdURL -Method Get
		if ($Result.Content -like '*"status": "completed"*') {
			$Run = $false
		} elseif ($Result.Content -like '*"status": "failed"*') {
			throw 'Failed to download package'
		}
		Start-Sleep -Seconds 1
	}

	$Obj = New-Object -ComObject CapaInstaller.Scripting.Extract
	$Obj.ExtractZip($KitLocalPath, $DestinationFolder)

	Remove-Item -Path $KitLocalPath -Force
}


<#
.SYNOPSIS
    New-Popup will display a message box. If a timeout is requested it uses Wscript.Shell PopUp method. If a default button is requested it uses the ::Show method from 'Windows.Forms.MessageBox'
.DESCRIPTION
    The New-Popup command uses the Wscript.Shell PopUp method to display a graphical message
    box. You can customize its appearance of icons and buttons. By default the user
    must click a button to dismiss but you can set a timeout value in seconds to
    automatically dismiss the popup.

    The command will write the return value of the clicked button to the pipeline:
    Timeout = -1
    OK = 1
    Cancel = 2
    Abort = 3
    Retry = 4
    Ignore = 5
    Yes = 6
    No = 7

    If no button is clicked, the return value is -1.
.PARAMETER Message
    The message you want displayed
.PARAMETER Title
    The text to appear in title bar of dialog box
.PARAMETER Time
    The time to display the message. Defaults to 0 (zero) which will keep dialog open until a button is clicked
.PARAMETER Buttons
    Valid values for -Buttons include:
    "OK"
    "OKCancel"
    "AbortRetryIgnore"
    "YesNo"
    "YesNoCancel"
    "RetryCancel"
.PARAMETER Icon
    Valid values for -Icon include:
    "Stop"
    "Question"
    "Exclamation"
    "Information"
    "None"
.PARAMETER ShowOnTop
    Switch which will force the popup window to appear on top of all other windows.
.PARAMETER AsString
    Will return a human readable representation of which button was pressed as opposed to an integer value.
.EXAMPLE
    new-popup -message "The update script has completed" -title "Finished" -time 5

    This will display a popup message using the default OK button and default
    Information icon. The popup will automatically dismiss after 5 seconds.
.EXAMPLE
    $answer = new-popup -Message "Please pick" -Title "form" -buttons "OKCancel" -icon "information"

    If the user clicks "OK" the $answer variable will be equal to 1. If the user clicks "Cancel" the
    $answer variable will be equal to 2.
.EXAMPLE
    $answer = new-popup -Message "Please pick" -Title "form" -buttons "OKCancel" -icon "information" -AsString

    If the user clicks "OK" the $answer variable will be equal to 'OK'. If the user clicks "Cancel" the
    $answer variable will be 'Cancel'
.OUTPUTS
    An integer with the following value depending upon the button pushed.

    Timeout = -1 # Value when timer finishes countdown.
    OK = 1
    Cancel = 2
    Abort = 3
    Retry = 4
    Ignore = 5
    Yes = 6
    No = 7
.LINK
    Wscript.Shell
#>
function New-MessageBox {
	#region Parameters
	[CmdletBinding(DefaultParameterSetName = 'Timeout')]
	[OutputType('int')]
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '')]
	Param (
		[Parameter(Mandatory, HelpMessage = 'Enter a message for the message box', ParameterSetName = 'DefaultButton')]
		[Parameter(Mandatory, HelpMessage = 'Enter a message for the message box', ParameterSetName = 'Timeout')]
		[ValidateNotNullorEmpty()]
		[string] $Message,

		[Parameter(Mandatory, HelpMessage = 'Enter a title for the message box', ParameterSetName = 'DefaultButton')]
		[Parameter(Mandatory, HelpMessage = 'Enter a title for the message box', ParameterSetName = 'Timeout')]
		[ValidateNotNullorEmpty()]
		[string] $Title,

		[Parameter(ParameterSetName = 'Timeout')]
		[ValidateScript({ $_ -ge 0 })]
		[int] $Time = 0,

		[Parameter(ParameterSetName = 'DefaultButton')]
		[Parameter(ParameterSetName = 'Timeout')]
		[ValidateNotNullorEmpty()]
		[ValidateSet('OK', 'OKCancel', 'AbortRetryIgnore', 'YesNo', 'YesNoCancel', 'RetryCancel')]
		[string] $Buttons = 'OK',

		[Parameter(ParameterSetName = 'DefaultButton')]
		[Parameter(ParameterSetName = 'Timeout')]
		[ValidateNotNullorEmpty()]
		[ValidateSet('None', 'Stop', 'Hand', 'Error', 'Question', 'Exclamation', 'Warning', 'Asterisk', 'Information')]
		[string] $Icon = 'None',

		[Parameter(ParameterSetName = 'Timeout')]
		[switch] $ShowOnTop,

		[Parameter(ParameterSetName = 'DefaultButton')]
		[ValidateSet('Button1', 'Button2', 'Button2')]
		[string] $DefaultButton = 'Button1',

		[Parameter(ParameterSetName = 'DefaultButton')]
		[Parameter(ParameterSetName = 'Timeout')]
		[switch] $AsString

	)
	#endregion Parameters

	begin {
		Write-Verbose -Message "Starting [$($MyInvocation.Mycommand)]"
		Write-Verbose -Message "ParameterSetName [$($PsCmdlet.ParameterSetName)]"

		# set $ShowOnTopValue based on switch
		if ($ShowOnTop) {
			$ShowOnTopValue = 4096
		} else {
			$ShowOnTopValue = 0
		}

		#lookup key to convert buttons to their integer equivalents
		$ButtonsKey = ([ordered] @{
				'OK'               = 0
				'OKCancel'         = 1
				'AbortRetryIgnore' = 2
				'YesNo'            = 4
				'YesNoCancel'      = 3
				'RetryCancel'      = 5
			})

		#lookup key to convert icon to their integer equivalents
		$IconKey = ([ordered] @{
				'None'        = 0
				'Stop'        = 16
				'Hand'        = 16
				'Error'       = 16
				'Question'    = 32
				'Exclamation' = 48
				'Warning'     = 48
				'Asterisk'    = 64
				'Information' = 64
			})

		#lookup key to convert return value to human readable button press
		$ReturnKey = ([ordered] @{
				-1 = 'Timeout'
				1  = 'OK'
				2  = 'Cancel'
				3  = 'Abort'
				4  = 'Retry'
				5  = 'Ignore'
				6  = 'Yes'
				7  = 'No'
			})
	}

	process {
		switch ($PsCmdlet.ParameterSetName) {
			'Timeout' {
				try {
					$wshell = New-Object -ComObject Wscript.Shell -ErrorAction Stop
					#Button and icon type values are added together to create an integer value
					$return = $wshell.Popup($Message, $Time, $Title, $ButtonsKey[$Buttons] + $Iconkey[$Icon] + $ShowOnTopValue)
					if ($return -eq -1) {
						Write-Verbose -Message "User timedout [$($returnkey[$return])] after [$time] seconds"
					} else {
						Write-Verbose -Message "User pressed [$($returnkey[$return])]"
					}
					if ($AsString) {
						$ReturnKey[$return]
					} else {
						$return
					}
				} catch {
					#You should never really run into an exception in normal usage
					Write-Error -Message 'Failed to create Wscript.Shell COM object'
					Write-Error -Message ($_.exception.message)
				}
			}

			'DefaultButton' {
				try {
					$MessageBox = [Windows.Forms.MessageBox]
					$Return = ($MessageBox::Show($Message, $Title, $ButtonsKey[$Buttons], $Iconkey[$Icon], $DefaultButton)).Value__
					Write-Verbose -Message "User pressed [$($returnkey[$return])]"
					if ($AsString) {
						$ReturnKey[$return]
					} else {
						$return
					}
				} catch {
					#You should never really run into an exception in normal usage
					Write-Error -Message 'Failed to create MessageBox'
					Write-Error -Message ($_.exception.message)
				}
			}
		}
	}

	end {
		Write-Verbose -Message "Ending [$($MyInvocation.Mycommand)]"
	}

}


<#
	.SYNOPSIS
		This fuction is used to start logging of a SDK script.

	.DESCRIPTION
		This fuction is used to start logging of a SDK script.
		The log file will be stored in a folder named Logs_<LogName> in the path specified.
		You can get the path to the log file by using the global variable $Global:SDKScriptLogfile.

	.PARAMETER Path
		Defines the path to the folder where the log file should be stored.
		In most cases this should be $PSScriptRoot.

	.PARAMETER UseDateInFileName
		Default is true. If set to false the date will not be used in the log file name.

	.PARAMETER UseTimeInFileName
		Default is true. If set to false the time will not be used in the log file name.

	.PARAMETER UseStopwatch
		Default is true. If set to false the stopwatch will not be used in the log file.

	.PARAMETER DeleteDaysOldLogs
		Sets the number of days old logs should be deleted.
		Default is 90 days.

	.PARAMETER LogName
		Sets the name of the log file.

	.PARAMETER DeleteAllLogs
		Default is false. If set to true all logs will be deleted.

    .PARAMETER AppendToLog
        Default is true. If set to false a new log file will be created.

	.EXAMPLE
		PS C:\> Start-ScriptLogging -Path $PSScriptRoot -LogName 'Test-Module'

	.EXAMPLE
		PS C:\> Start-ScriptLogging -Path $PSScriptRoot -LogName 'Test-Module' -UseDateInFileName False

	.EXAMPLE
		PS C:\> Start-ScriptLogging -Path $PSScriptRoot -LogName 'Test-Module' -UseTimeInFileName False

	.EXAMPLE
		PS C:\> Start-ScriptLogging -Path $PSScriptRoot -LogName 'Test-Module' -UseStopwatch False

	.EXAMPLE
		PS C:\> Start-ScriptLogging -Path $PSScriptRoot -LogName 'Test-Module' -DeleteDaysOldLogs 1

	.NOTES
		This is a custom function created to have a standard way of starting logging in SDK scripts.
#>
function Start-ScriptLogging {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		[string]$Path,
		[Parameter(Mandatory = $false)]
		[bool]$UseDateInFileName = $true,
		[Parameter(Mandatory = $false)]
		[bool]$UseTimeInFileName = $true,
		[Parameter(Mandatory = $false)]
		[bool]$UseStopwatch = $true,
		[Parameter(Mandatory = $false)]
		[int]$DeleteDaysOldLogs = 90,
		[Parameter(Mandatory = $false)]
		[string]$LogName,
		[Parameter(Mandatory = $false)]
		[bool]$DeleteAllLogs = $false,
		[Parameter(Mandatory = $false)]
		[bool]$AppendToLog = $true
	)
	$FunctionName = 'Start-ScriptLogging'

	function Get-LogFilePath ($LogPath, $LogName, $AppendToLog) {
		$Run = $true
		$i = 1

		$Path = "$LogPath\$LogName.log"

		if ($AppendToLog) {
			return $Path
		}

		While ($Run -eq $true) {
			if ((Test-Path -Path $Path) -eq $true) {
				$Path = "$LogPath\$($LogName)_$($i).log"
				$i++
			} else {
				$Run = $false
			}
		}

		return $Path
	}

	# Start transcript.
	try {
		$LogFolderPath = "$Path\\Logs_$LogName"
		New-Item -Path $LogFolderPath -ItemType Directory -Force | Out-Null

		if ($UseTimeInFileName -and $UseDateInFileName) {
			$LogFilePath = Get-LogFilePath -LogPath $LogFolderPath -LogName "$LogName-$(Get-Date -Format 'yyyy-MM-dd_HH-mm-s')" -AppendToLog $AppendToLog
		} elseif ($UseDateInFileName) {
			$LogFilePath = Get-LogFilePath -LogPath $LogFolderPath -LogName "$LogName-$(Get-Date -Format 'yyyy-MM-dd')" -AppendToLog $AppendToLog
		} else {
			$LogFilePath = Get-LogFilePath -LogPath $LogFolderPath -LogName $LogName -AppendToLog $AppendToLog
		}

		Write-Host "Starting transcript: $LogFilePath"
		if ($AppendToLog) {
			Start-Transcript -Path $LogFilePath -Append
		} else {
			Start-Transcript -Path $LogFilePath
		}

		Write-Output (''); # Insert line break just after starting the transcript (for readability).

		# Used to stop all transcripts that are started
		$Global:TranscriptSesions++
		# Used to store path to current logfile
		$Global:SDKScriptLogfile = $LogFilePath
	} catch {
		Write-Host "Error starting transcript: $_" -ForegroundColor Red
		return $false
	}

	if ($UseStopwatch -eq $true) {
		# Start a new stopwatch for measuring elapsed time for the script.
		$Global:SDKScriptStopwatch = [Diagnostics.Stopwatch]::StartNew()
	}

	if ($DeleteDaysOldLogs -or $DeleteAllLogs -eq $true) {
		$LogFiles = Get-ChildItem -Path $LogFolderPath

		foreach ($LogFile in $LogFiles) {
			If ($LogFile.CreationTime.Date -le ((Get-Date).AddDays(-$DeleteDaysOldLogs).ToString('yyyy-MM-dd'))) {
				Remove-Item $LogFile -Force -ErrorAction SilentlyContinue
				Write-LogLine -ScriptPart $FunctionName -Text "Deleting $LogFile"
			}
		}
	}
	return $true
}


<#
	.SYNOPSIS
		Stops logging of a script.

	.DESCRIPTION
		Stops all started logging sesion started by running ITCE-StartScriptLoggin.

	.EXAMPLE
		PS C:\> Stop-ScriptLogging

	.NOTES
		This is a custom function created to have a standard way of starting logging in SDK scripts.
#>
function Stop-ScriptLogging {
	[CmdletBinding()]
	param ()
	$FunctionName = 'Stop-ScriptLogging'

	if ($Global:SDKScriptStopwatch) {
		# Display elapsed time from stopwatch.
		$Global:SDKScriptStopwatch.Stop()
		$linje = "`nElapsed time: $( $Global:SDKScriptStopwatch.Elapsed.Days) day(s) $( $Global:SDKScriptStopwatch.Elapsed.Hours) hour(s) $( $Global:SDKScriptStopwatch.Elapsed.Minutes) minute(s) $( $Global:SDKScriptStopwatch.Elapsed.Seconds) seconds $( $Global:SDKScriptStopwatch.Elapsed.Milliseconds) millisecond(s)"
		Write-Host $linje
		$Global:SDKScriptStopwatch = $null
	}

	Write-Output (''); # Insert line break just before stopping the transcript (for readability).

	try {
		While ($i -lt $Global:TranscriptSesions) {
			Write-Host "Stopping sesion $($Global:TranscriptSesions - $i) of $Global:TranscriptSesions"
			Stop-Transcript | Out-Null
			$i++
		}
		$Global:TranscriptSesions = $null
	} catch {
		Write-Host "Error stopping transcript: $($_.Exception.Message)" -ForegroundColor Red
		return $false
	}
	return $true
}


<#
	.SYNOPSIS
		Use to write a line to the log file.

	.DESCRIPTION
		Used to write a  pretty line to the log file indstead of using Write-Host or Write-Output.

	.PARAMETER Text
		The text to write to the log file.

	.PARAMETER ScriptPart
		The part of the script that is writing to the log file.
		Default value is 'Main'.

	.PARAMETER ForegroundColor
		The color of the text.
		Only usable to see in the console.

	.EXAMPLE
		PS C:\> Write-LogLine -Text 'value1'

	.EXAMPLE
		PS C:\> Write-LogLine -Text 'value1' -ScriptPart 'Function1'

	.EXAMPLE
		PS C:\> Write-LogLine -Text 'value1' -ScriptPart 'Function1' -ForegroundColor 'Red'

	.NOTES
		This is a custom function created to have a standard way of starting logging in SDK scripts.
#>
function Write-LogLine {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		[string]$Text,
		[string]$ScriptPart = 'Main',
		[ValidateSet('Black', 'DarkBlue', 'DarkGreen', 'DarkCyan', 'DarkRed', 'DarkMagenta', 'DarkYellow', 'Gray', 'DarkGray', 'Blue', 'Green', 'Cyan', 'Red', 'Magenta', 'Yellow', 'White')]
		$ForegroundColor = (Get-Host).ui.rawui.ForegroundColor
	)

	Write-Host "$(Get-Date -Format HH:mm:ss) : $($ScriptPart) : $Text" -ForegroundColor $ForegroundColor
}


