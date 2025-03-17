
<#
	.SYNOPSIS
		Installs an MSI file.

	.DESCRIPTION
		Installs an MSI file.

	.PARAMETER FilePath
		The path to the MSI file.

	.PARAMETER Arguments
		Additional arguments to pass to the MSI installer. By default the MSI is called with arguments to log the installation to a file.

	.EXAMPLE
		Install-Msi -FilePath 'C:\Temp\MyApp.msi' -Arguments '/qn'
#>
function Install-Msi {
	[CmdletBinding()]
	Param(
		[Parameter(Mandatory = $true)]
		[string]$FilePath,
		[Parameter(Mandatory = $false)]
		[string]$Arguments
	)
	$LogPrefix = "Install-Msi:"
	Job_WriteLog -Text "$LogPrefix FilePath: $FilePath, Arguments: $Arguments"

	$LogFolder = Split-Path $LogFile -Parent
	$MsiLogFolder = Join-Path $LogFolder 'MSILogs'
	$msiFile = Split-Path $msiFilePath -Leaf
	$msiLog = $MsiLogFolder + '\' + $msiFile + '_install.log'

	File_CreateDir -Path $MsiLogFolder

	$RetValue = Shell_Execute -Command 'msiexec.exe' -Arguments "/i `"$FilePath`" $Arguments /l*vx `"$msiLog`""
	Job_WriteLog -Text "$LogPrefix Return value: $RetValue"
	f ($retvalue -ne 0) {Exit-PpScript -ExitCode $retvalue}
}


# TODO: #83 Update and add tests

<#
	.SYNOPSIS
		Gets the product code of an MSI file.

	.PARAMETER MsiFile
		The path to the MSI file.

	.EXAMPLE
		PS C:\> MSI_GetProductCodeFromMSI -MsiFile "C:\Temp\test.msi"

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455717/cs.MSI+GetProductCodeFromMSI
#>
function MSI_GetProductCodeFromMSI {
	param (
		[Parameter(Mandatory = $true)]
		[string]$MsiFile
	)

	$Value = $Global:Cs.MSI_GetProductCodeFromMSI($MsiFile)

	return $Value
}


# TODO: #84 Update and add tests

<#
	.SYNOPSIS
		Gets the values of properties from an MSI file.

	.PARAMETER MsiFile
		The path to the MSI file.

	.PARAMETER Property
		Array of properties to retrieve.

	.EXAMPLE
		PS C:\> MSI_GetPropertiesFromMSI -MsiFile "C:\Temp\test.msi" -Property @("ProductVersion","UpgradeCode","ProductCode","ProductName","Manufacture")

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455751/cs.MSI+GetPropertiesFromMSI
#>
function MSI_GetPropertiesFromMSI {
	param (
		[Parameter(Mandatory = $true)]
		[string]$MsiFile,
		[Parameter(Mandatory = $false)]
		[array]$Property
	)

	$Value = $Global:Cs.MSI_GetPropertiesFromMSI($MsiFile, $Property)

	return $Value
}


# TODO: #85 Update and add tests

<#
	.SYNOPSIS
		Gets the value of a property from an MSI file.

	.PARAMETER MsiFile
		The path to the MSI file.

	.PARAMETER Property
		The property to get the value from.

	.EXAMPLE
		PS C:\> MSI_GetPropertyFromMSI -MsiFile "C:\Temp\test.msi" -Property "ProductVersion"

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455734/cs.MSI+GetPropertyFromMSI
#>
function MSI_GetPropertyFromMSI {
	param (
		[Parameter(Mandatory = $true)]
		[string]$MsiFile,
		[Parameter(Mandatory = $true)]
		[string]$Property
	)

	$Value = $Global:Cs.MSI_GetPropertyFromMSI($MsiFile, $Property)

	return $Value
}


# TODO: #86 Update and add tests

<#
	.SYNOPSIS
		Checks if an MSI file is installed.

	.PARAMETER MsiFile
		The path to the MSI file.

	.EXAMPLE
		PS C:\> MSI_IsMSIFileInstalled -MsiFile "C:\Temp\test.msi"

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455768/cs.MSI+IsMSIFileInstalled
#>
function MSI_IsMSIFileInstalled {
	param (
		[Parameter(Mandatory = $true)]
		[string]$MsiFile
	)

	$Value = $Global:Cs.MSI_IsMSIFileInstalled($MsiFile)

	return $Value
}


# TODO: #87 Update and add tests

<#
	.SYNOPSIS
		Checks if an GUID is installed.

	.PARAMETER MsiGuid
		TMSI Productcode to check installation status of.

	.EXAMPLE
		PS C:\> MSI_IsMSIGuidInstalled -MsiGuid "{AC76BA86-1033-FF00-7760-BC15014EA700}"

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455785/cs.MSI+IsMSIGuidInstalled
#>
function MSI_IsMSIGuidInstalled {
	param (
		[Parameter(Mandatory = $true)]
		[string]$MsiGuid
	)

	$Value = $Global:Cs.MSI_IsMSIGuidInstalled($MsiGuid)

	return $Value
}


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


