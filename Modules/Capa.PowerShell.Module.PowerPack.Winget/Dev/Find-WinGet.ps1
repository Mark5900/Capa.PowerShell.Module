<#
	.SYNOPSIS
		Find the path to the WinGet executable.

	.DESCRIPTION
		Find the path to the WinGet executable.

	.PARAMETER AllowInstallOfWinGet
		Allow the installation of WinGet if it is not found.

	.EXAMPLE
		$WingetPath = Find-WinGet -AllowInstallOfWinGet $true

	.EXAMPLE
		$WingetPath = Find-WinGet
		if ($WingetPath -eq $false) {
			Exit-PpPackageNotCompliant
		}

	.NOTES
		Custom function not from CapaSystems.
#>
function Find-WinGet {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $false)]
		[bool]$AllowInstallOfWinGet = $false
	)
	$FunctionName = 'Find-WinGet'

	if ($global:gsOsSystem -like '*server*') {
		Job_WriteLog -Text 'WinGet is not supported on server OS' -FunctionName $FunctionName
		return $false
	}

	if (Get-Command 'winget' -ErrorAction SilentlyContinue) {
		Job_WriteLog -Text 'WinGet was found' -FunctionName $FunctionName
	} else {
		if ($AllowInstallOfWinGet) {
			# https://learn.microsoft.com/en-us/windows/package-manager/winget/#install-winget
			try {
				Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe
				Job_WriteLog -Text 'WinGet was installed' -FunctionName $FunctionName
			} catch {
				Job_WriteLog -Text 'Error - WinGet was not installed' -FunctionName $FunctionName
				$line = $_.InvocationInfo.ScriptLineNumber
				Job_WriteLog -Text "Something bad happend at line $($line): $($_.Exception.Message)" -FunctionName $FunctionName
				Exit-PSScript $_.Exception.HResult
			}
		} else {
			Job_WriteLog -Text 'WinGet was not found' -FunctionName $FunctionName
			return $false
		}
	}

	$ResolveWingetPath = Resolve-Path 'C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe'
	if ($ResolveWingetPath) {
		$WingetPath = $ResolveWingetPath[-1].Path
	}
	Job_WriteLog -Text "WinGet path: $WingetPath" -FunctionName $FunctionName
	return $WingetPath
}