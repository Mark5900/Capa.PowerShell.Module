
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


