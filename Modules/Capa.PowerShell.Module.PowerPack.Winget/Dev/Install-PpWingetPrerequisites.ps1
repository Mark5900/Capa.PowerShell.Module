<#
.SYNOPSIS
	Install prerequisites for winget

.DESCRIPTION
	Install prerequisites for winget

.NOTES
		Custom function not from CapaSystems.
		Idea from: https://github.com/Romanitho/Winget-Install/blob/main/winget-install.ps1
#>
function Install-PpWingetPrerequisites {
	param (
		[Parameter(Mandatory = $false)]
		[string]$WingetPath
	)
	$Function = 'Install-PpWingetPrerequisites'

	<#
		Sometimes does the modules is not import the functions correctly, so we try to import it again.
		If it fails, then we try to import it with the Windows PowerShell.
		If that also fails, then keep going.
	#>
	try {
		Import-Module Appx
	} catch {
		Import-Module Appx -UseWindowsPowerShell
	}

	if ([string]::IsNullOrEmpty($WingetPath)) {
		$Winget = Find-PpWinGetCmd
	} else {
		$Winget = $WingetPath
	}

	Job_WriteLog -Text '###############################################' -FunctionName $Function
	Job_WriteLog -Text 'Checking prerequisites for winget' -FunctionName $Function

	#region Check if Visual C++ 2019 or 2022 installed
	$Visual2019 = 'Microsoft Visual C++ 2015-2019 Redistributable*'
	$Visual2022 = 'Microsoft Visual C++ 2015-2022 Redistributable*'
	$path = Get-Item HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*, HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object { $_.GetValue('DisplayName') -like $Visual2019 -or $_.GetValue('DisplayName') -like $Visual2022 }
	Job_WriteLog -Text "Visual C++ 2019 or 2022: $path" -FunctionName $Function

	#If not installed, download and install
	if (!($path)) {
		#region Download and install
		try {
			$SourceURL = "https://aka.ms/vs/17/release/VC_redist.$global:gsOsArchitechture.exe"
			$Installer = Join-Path $Global:TempFolder "\VC_redist.$global:gsOsArchitechture.exe"
			Job_WriteLog -Text "Downloading $SourceURL..." -FunctionName $Function
			Invoke-WebRequest $SourceURL -UseBasicParsing -OutFile $Installer
			Job_WriteLog -Text "Installing $Installer..." -FunctionName $Function
			Start-Process -FilePath $Installer -Args '/passive /norestart' -Wait
			Start-Sleep 3
			Remove-Item $Installer -ErrorAction Ignore
			Job_WriteLog -Text 'MS Visual C++ 2015-2022 installed successfully.' -FunctionName $Function
		} catch {
			Job_WriteLog -Text 'MS Visual C++ 2015-2022 installation failed.' -FunctionName $Function
			Job_WriteLog -Text $_.Exception.Message -FunctionName $Function
		}
	} else {
		Job_WriteLog -Text 'MS Visual C++ 2015-2022 is installed.' -FunctionName $Function

	}
	#endregion
	#endregion
	#region Check if Microsoft.VCLibs.140.00.UWPDesktop is installed
	if (!(Get-AppxPackage -Name 'Microsoft.VCLibs.140.00.UWPDesktop' -AllUsers)) {
		Job_WriteLog -Text 'Microsoft.VCLibs.140.00.UWPDesktop is not installed' -FunctionName $Function
		$VCLibsUrl = 'https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx'
		$VCLibsFile = "$Global:TempFolder\Microsoft.VCLibs.x64.14.00.Desktop.appx"
		Job_WriteLog -Text "Downloading $VCLibsUrl..." -FunctionName $Function
		Invoke-RestMethod -Uri $VCLibsUrl -OutFile $VCLibsFile
		try {
			Job_WriteLog -Text 'Installing Microsoft.VCLibs.140.00.UWPDesktop...' -FunctionName $Function
			Add-AppxProvisionedPackage -Online -PackagePath $VCLibsFile -SkipLicense | Out-Null
			Job_WriteLog -Text 'Microsoft.VCLibs.140.00.UWPDesktop installed successfully.' -FunctionName $Function
		} catch {
			Job_WriteLog -Text 'Microsoft.VCLibs.140.00.UWPDesktop installation failed.' -FunctionName $Function
			Job_WriteLog -Text $_.Exception.Message -FunctionName $Function
		}
		Remove-Item -Path $VCLibsFile -Force -ErrorAction Ignore
	} else {
		Job_WriteLog -Text 'Microsoft.VCLibs.140.00.UWPDesktop is installed.' -FunctionName $Function
	}
	#endregion
	#region Check available WinGet version, if fail set version to the latest version as of 2024-03-01
	$WingetURL = 'https://api.github.com/repos/microsoft/winget-cli/releases/latest'
	try {
		$WinGetAvailableVersion = ((Invoke-WebRequest $WingetURL -UseBasicParsing | ConvertFrom-Json)[0].tag_name).Replace('v', '')
	} catch {
		$WinGetAvailableVersion = '1.7.10582'
	}
	Job_WriteLog -Text "WinGet available version: $WinGetAvailableVersion" -FunctionName $Function

	#region Get installed Winget version
	try {
		$WingetInstalledVersionCmd = & $Winget -v
		$WinGetInstalledVersion = (($WingetInstalledVersionCmd).Replace('-preview', '')).Replace('v', '')
		Job_WriteLog -Text "Installed Winget version: $WinGetInstalledVersion" -FunctionName $Function
	} catch {
		Job_WriteLog -Text 'WinGet is not installed' -FunctionName $Function
	}
	#region Check if the available WinGet is newer than the installed
	if ($WinGetAvailableVersion -gt $WinGetInstalledVersion) {

		Job_WriteLog -Text "Downloading Winget v$WinGetAvailableVersion" -FunctionName $Function
		$WingetURL = "https://github.com/microsoft/winget-cli/releases/download/v$WinGetAvailableVersion/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
		$WingetInstaller = "$Global:TempFolder\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
		Invoke-RestMethod -Uri $WingetURL -OutFile $WingetInstaller
		try {
			Job_WriteLog -Text "Installing Winget v$WinGetAvailableVersion" -FunctionName $Function
			Add-AppxProvisionedPackage -Online -PackagePath $WingetInstaller -SkipLicense | Out-Null
			Job_WriteLog -Text 'Winget installed.' -FunctionName $Function
		} catch {
			Job_WriteLog -Text 'Failed to install Winget!' -FunctionName $Function
			Job_WriteLog -Text $_.Exception.Message -FunctionName $Function
		}
		Remove-Item -Path $WingetInstaller -Force -ErrorAction Ignore
	}
	#endregion
	#endregion
	#endregion

	Job_WriteLog -Text 'Checking prerequisites ended.' -FunctionName $Function
	Job_WriteLog -Text '###############################################' -FunctionName $Function
}