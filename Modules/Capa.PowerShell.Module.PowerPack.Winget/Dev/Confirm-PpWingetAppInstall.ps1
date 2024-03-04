<#
	.SYNOPSIS
		Confirm if an app is installed.

	.DESCRIPTION
		Confirm if an app is installed.
		Returns $true if the app is installed, otherwise $false.

	.PARAMETER AppId
		The AppId of the app to confirm.

	.PARAMETER WingetPath
		The path to the winget executable. If not provided, the function will try to find the winget executable.

	.EXAMPLE
		Confirm-PpWingetAppInstall -AppId 'Microsoft.VisualStudioCode'

	.NOTES
		Custom function not from CapaSystems.
		Idea from: https://github.com/Romanitho/Winget-Install/blob/main/winget-install.ps1
#>
function Confirm-PpWingetAppInstall {
	param (
		[Parameter(Mandatory = $true)]
		[string]$AppId,
		[Parameter(Mandatory = $false)]
		[string]$WingetPath
	)
	$Function = 'Confirm-PpWingetAppInstall'

	if ([string]::IsNullOrEmpty($WingetPath)) {
		$Winget = Find-PpWinGetCmd
	} else {
		$Winget = $WingetPath
	}

	#Get "Winget List AppID"
	$InstalledApp = & $winget list --Id $AppID -e --accept-source-agreements -s winget | Out-String

	#Return if AppID exists in the list
	if ($InstalledApp -match [regex]::Escape($AppID)) {
		return $true
	} else {
		return $false
	}
}