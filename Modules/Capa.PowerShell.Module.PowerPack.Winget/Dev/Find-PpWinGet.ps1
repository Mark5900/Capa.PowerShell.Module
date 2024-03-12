<#
	.SYNOPSIS
		Find the path to the WinGet executable.

	.DESCRIPTION
		Find the path to the WinGet executable. If the WinGet executable is not found, the function will return $false.

	.PARAMETER AllowInstallOfWinGet
		If set to $true, the function will try to install or update WinGet if it is not found or if the version is outdated.

	.EXAMPLE
		$WingetPath = Find-PpWinGetCmd

	.EXAMPLE
		$WingetPath = Find-PpWinGetCmd -AllowInstallOfWinGet $true

	.NOTES
		Custom function not from CapaSystems.
		Idea from: https://github.com/Romanitho/Winget-Install/blob/main/winget-install.ps1
#>
function Find-PpWinGetCmd {
	[CmdletBinding()]
	param (	)
	$FunctionName = 'Find-WinGet'
	$WingetCmd = $false

	if ($global:gsOsSystem -like '*server*') {
		Job_WriteLog -Text 'WinGet is not supported on server OS' -FunctionName $FunctionName
		return $false
	}

	#Get WinGet Path
	try {
		#Get Admin Context Winget Location
		$WingetInfo = (Get-Item "$env:ProgramFiles\WindowsApps\Microsoft.DesktopAppInstaller_*_8wekyb3d8bbwe\winget.exe").VersionInfo | Sort-Object -Property FileVersionRaw
		#If multiple versions, pick most recent one
		$WingetCmd = $WingetInfo[-1].FileName
	} catch {
		#Get User context Winget Location
		if (Test-Path "$env:LocalAppData\Microsoft\WindowsApps\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\winget.exe") {
			$WingetCmd = "$env:LocalAppData\Microsoft\WindowsApps\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\winget.exe"
		}
	}

	Job_WriteLog -Text "WingetCmd: $WingetCmd" -FunctionName $FunctionName

	return $WingetCmd
}