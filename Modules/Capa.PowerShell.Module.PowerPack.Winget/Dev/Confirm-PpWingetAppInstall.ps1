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