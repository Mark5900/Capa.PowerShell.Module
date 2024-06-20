
# TODO: #240 Update and add tests

<#
	.SYNOPSIS
		Create an CapaInstaller AD group.

	.DESCRIPTION
		Create an CapaInstaller AD group.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER GroupName
		The name of the group.

	.PARAMETER UnitType
		The type of the elements in the group. This can be either "Computer" or "User"

	.PARAMETER LDAPPath
		The LDAP path of the elements in the group.

	.PARAMETER recursive
		Indicates whether the group should be processed recursively.

	.EXAMPLE
		PS C:\> Create-CapaADGroup -CapaSDK $CapaSDK -GroupName 'TestGroup' -UnitType 'Computer' -LDAPPath 'LDAP://OU=TestOU,DC=capa,DC=local' -recursive 'true'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246216/Create+AD+group
#>
function Create-CapaADGroup {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType,
		[Parameter(Mandatory = $true)]
		[String]$LDAPPath,
		[Parameter(Mandatory = $true)]
		[String]$recursive
	)

	$value = $CapaSDK.CreateADGroup($GroupName, $UnitType, $LDAPPath, $recursive)
	return $value
}


# TODO: #241 Update and add tests

<#
	.SYNOPSIS
		Returns the log for a unit package relation.

	.DESCRIPTION
		Returns the log for a unit package relation.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER UnitName
		The name of the unit.

	.PARAMETER UnitType
		The type of the unit. This can be either "Computer" or "User"

	.PARAMETER PackageName
		The name of the package.

	.PARAMETER PackageVersion
		The version of the package.

	.PARAMETER PackageType
		The type of the package, this can be either "Computer" or "User"

	.EXAMPLE
		PS C:\> Get-CapaLog -CapaSDK $CapaSDK -UnitName 'TestComputer' -UnitType 'Computer' -PackageName 'WinRaR' -PackageVersion '5.50' -PackageType 'Computer'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246920/Get+log
#>
function Get-CapaLog {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[String]$UnitType,
		[Parameter(Mandatory = $true)]
		[String]$PackageName,
		[Parameter(Mandatory = $true)]
		[String]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('1', '2', 'Computer', 'User')]
		[String]$PackageType
	)

	if ($PackageType -eq 'Computer') {
		$PackageType = '1'
	}
	if ($PackageType -eq 'User') {
		$PackageType = '2'
	}

	$value = $CapaSDK.GetLog($UnitName, $UnitType, $PackageName, $PackageVersion, $PackageType)
	return $value
}


# TODO: #242 Update and add tests

<#
	.SYNOPSIS
		Gets the reinstall status for a unit.

	.DESCRIPTION
		Gets the reinstall status for a unit.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER UnitName
		The name of the unit.

	.PARAMETER UnitType
		The type of the unit. This can be either "Computer" or "User"

	.EXAMPLE
		Test-CapaReinstallStatus -CapaSDK $CapaSDK -UnitName 'TestComputer' -UnitType 'Computer'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247466/Get+reinstall+status
#>
function Get-CapaReinstallStatus {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		$UnitType
	)

	$value = $CapaSDK.GetReinstallStatus($UnitName, $UnitType)
	return $value
}


# TODO: #243 Update and add tests

<#
	.SYNOPSIS
		Moves a device from its current Management Point to the specified Management Point.

	.DESCRIPTION
		Moves a device from its current Management Point to the specified Management Point. If a Management Server is specified, the device will be linked to it.

All relations to the device in the old Management Point will be removed, including but not limited to packages, profiles, applications, groups, folders, primary user, user relations, management server.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER DeviceUUID
		The UUID of the device.

	.PARAMETER PointName
		The name of the Management Point the device should be moved to.

	.PARAMETER ManagementServerFQDN
		The name of the Management Server the device should be linked to. If an empty string is specified, the device will not be linked to a Management Server after the move.

	.EXAMPLE
		Move-CapaDeviceToPoint -CapaSDK $CapaSDK -DeviceUUID '12345678-1234-1234-1234-123456789012' -PointName 'TestManagementPoint' -ManagementServerFQDN 'TestManagementServer'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247640/Move+Device+To+Management+Point
#>
function Move-CapaDeviceToPoint {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		$DeviceUUID,
		[Parameter(Mandatory = $true)]
		$PointName,
		[Parameter(Mandatory = $true)]
		$ManagementServerFQDN
	)

	$value = $CapaSDK.MoveDeviceToPoint($DeviceUUID, $PointName, $ManagementServerFQDN)
	return $value
}


# TODO: #244 Update and add tests

<#
	.SYNOPSIS
		Sets an action to restart an agent.

	.DESCRIPTION
		Sets an action to restart an agent.
		If a user is specified, the agent on the computers linked to the user will be restarted.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER UnitName
		The name of the unit.

	.PARAMETER UnitType
		The type of the unit. This can be either "Computer" or "User"

	.EXAMPLE
		Restart-CapaAgent -CapaSDK $CapaSDK -UnitName 'TestComputer' -UnitType 'Computer'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247696/Restart+Agent+using+SDK
#>
function Restart-CapaAgent {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('1', '2', 'Computer', 'User')]
		[String]$UnitType
	)

	if ($PackageType -eq 'Computer') {
		$PackageType = '1'
	}
	if ($PackageType -eq 'User') {
		$PackageType = '2'
	}

	$value = $CapaSDK.RestartAgent($UnitName, $UnitType)
	return $value
}


# TODO: #245 Update and add tests

<#
	.SYNOPSIS
		Set a action to perform a Wake On LAN Request for the unit.

	.DESCRIPTION
		Set a action to perform a Wake On LAN Request for the unit.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER UnitName
		The name of the unit.

	.EXAMPLE
		Set-CapaWakeOnLAN -CapaSDK $CapaSDK -UnitName 'TestComputer'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247774/Set+Wake+On+LAN
#>
function Set-CapaWakeOnLAN {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$UnitName
	)

	$value = $CapaSDK.SetWakeOnLAN($UnitName, '1')
	return $value
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
				ITCE-WriteLogLine -ScriptPart $FunctionName -Text "Deleting $LogFile"
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


