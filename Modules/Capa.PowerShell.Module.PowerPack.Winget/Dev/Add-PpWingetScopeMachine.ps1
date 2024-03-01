<#
	.SYNOPSIS
		Set the winget scope to machine

	.DESCRIPTION
		Set the winget scope to machine

	.EXAMPLE
		Add-PpWingetScopeMachine

	.NOTES
		Custom function not from CapaSystems.
		Idea from: https://github.com/Romanitho/Winget-Install/blob/main/winget-install.ps1
#>
function Add-PpWingetScopeMachine {
	$Function = 'Add-PpWingetScopeMachine'

	#Get Settings path for system or current user
	if ([System.Security.Principal.WindowsIdentity]::GetCurrent().IsSystem) {
		$SettingsPath = "$global:gsWindowsDir\System32\config\systemprofile\AppData\Local\Microsoft\WinGet\Settings\defaultState\settings.json"
	} else {
		$SettingsPath = "$env:LOCALAPPDATA\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState\settings.json"
	}
	Job_WriteLog -Text "SettingsPath: $SettingsPath" -FunctionName $Function

	$ConfigFile = @{}

	#Check if setting file exist, if not create it
	if (Test-Path $SettingsPath) {
		$ConfigFile = Get-Content -Path $SettingsPath | Where-Object { $_ -notmatch '//' } | ConvertFrom-Json
		Job_WriteLog -Text 'The config file exists' -FunctionName $Function
	} else {
		New-Item -Path $SettingsPath -Force | Out-Null
		Job_WriteLog -Text 'The config file does not exist, creating it' -FunctionName $Function
	}

	if ($ConfigFile.installBehavior.preferences) {
		Add-Member -InputObject $ConfigFile.installBehavior.preferences -MemberType NoteProperty -Name 'scope' -Value 'Machine' -Force
	} else {
		$Scope = New-Object PSObject -Property $(@{scope = 'Machine' })
		$Preference = New-Object PSObject -Property $(@{preferences = $Scope })
		Add-Member -InputObject $ConfigFile -MemberType NoteProperty -Name 'installBehavior' -Value $Preference -Force
	}

	$ConfigFile | ConvertTo-Json | Out-File $SettingsPath -Encoding utf8 -Force
	Job_WriteLog -Text 'Scope set to Machine' -FunctionName $Function
}