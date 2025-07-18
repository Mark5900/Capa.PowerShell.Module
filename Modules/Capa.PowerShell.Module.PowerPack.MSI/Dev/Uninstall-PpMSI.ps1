<#
	.SYNOPSIS
		Uninstalls an MSI package by its DisplayName and optionally by its version.

	.DESCRIPTION
		This function uninstalls an MSI package from the system. It searches for the package in the registry and executes the uninstall command.

	.PARAMETER DisplayName
		The display name of the MSI package to uninstall. This parameter is mandatory.
		Wildcard characters are allowed in the DisplayName parameter.

	.PARAMETER Version
		The version of the MSI package to uninstall. This parameter is optional. If not provided, all versions of the package with the specified display name will be uninstalled.

	.EXAMPLE
		Uninstall-PpMSI -DisplayName "MyApp" -Version "1.0.0"
		This command uninstalls the MSI package with the display name "MyApp" and version "1.0.0".

	.EXAMPLE
		Uninstall-PpMSI -DisplayName "MyApp*"
		This command uninstalls all MSI packages with display names that start with "MyApp".
#>
function Uninstall-PpMSI {
	param (
		[Parameter(Mandatory = $true)]
		[string]$DisplayName,
		[Parameter(Mandatory = $false)]
		[string]$Version = $null
	)
	$LogPrefix = "Uninstall-PpMSI:"
	Job_WriteLog -Text "$LogPrefix DisplayName: $DisplayName, Version: $Version"

	If ($DisplayName.Trim() -eq '*') {
		Exit-PpScript -ExitCode 1 -ExitMessage 'Error - DisplayName cannot be just a wildcard'
	}

	$RegPaths = @(
		'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall',
		'SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall'
	)

	foreach ($RegPath in $RegPaths) {
		$RegKeys = Reg_EnumKey -RegRoot HKLM -RegPath $RegPath
		foreach ($Item in $RegKeys) {
			Job_WriteLog -Text "$LogPrefix Running for $($Item)"

			$RegDisplayName = Reg_GetString -RegRoot HKLM -RegKey "$RegPath\$Item" -RegValue 'DisplayName'
			if ($RegDisplayName -notlike $DisplayName) {
				Job_WriteLog -Text "$LogPrefix Skipping $Item, DisplayName does not match"
				continue
			}

			$CheckForVersion = [string]::IsNullOrEmpty($Version) -eq $false
			$DisplayVersionExists = Reg_ExistVariable -RegRoot HKLM -RegKey "$RegPath\$Item" -RegVariable 'DisplayVersion'
			if ($DisplayVersionExists -eq $false -and $CheckForVersion) {
				Job_WriteLog -Text "$LogPrefix Skipping $Item, DisplayVersion does not exist"
				continue
			}

			if ($DisplayVersionExists) {
				$RegVersion = Reg_GetString -RegRoot HKLM -RegKey "$RegPath\$Item" -RegValue 'DisplayVersion'
				if ($CheckForVersion) {
					# You cannot compare version numbers on empty strings, so we need the parent if statement
					if ([version]$RegVersion -ne [version]$Version) {
						Job_WriteLog -Text "$LogPrefix Skipping $Item, DisplayVersion does not match"
						continue
					}
				}
			}

			if ((Reg_ExistVariable -RegRoot HKLM -RegKey "$RegPath\$Item" -RegVariable 'UninstallString') -eq $false) {
				Job_WriteLog -Text "$LogPrefix Skipping $Item, UninstallString does not exist"
				continue
			}

			$UninstallString = Reg_GetString -RegRoot HKLM -RegKey "$RegPath\$Item" -RegValue 'UninstallString'
			if ([string]::IsNullOrEmpty($UninstallString)) {
				Job_WriteLog -Text "$LogPrefix Skipping $Item, UninstallString is empty"
				continue
			} elseif ($UninstallString -notlike 'msiexec*') {
				Job_WriteLog -Text "$LogPrefix Skipping $Item, UninstallString is not an MSI"
				continue
			}

			$LogFolder = Split-Path $LogFile -Parent
			$MsiLogFolder = Join-Path $LogFolder 'MSILogs'
			File_CreateDir -Path $MsiLogFolder
			if ([string]::IsNullOrEmpty($RegVersion)) {
				$RegVersion = 'NoVersion'
			}
			$msiLog = Join-Path $MsiLogFolder "$RegDisplayName.$RegVersion.log"

			Job_WriteLog -Text "$LogPrefix Uninstallating $($Item)"
			$RetValue = Shell_Execute -Command 'msiexec.exe' -Arguments "/x $item /qn REBOOT=REALLYSUPPRESS /l*v `"$msiLog`""
			Job_WriteLog -Text "$LogPrefix Uninstall of $item completed with status: $retvalue"
			if ($retvalue -ne 0 -and $retvalue -ne 3010) {
				Exit-PpScript -ExitCode $retvalue
			}
		}
	}
}