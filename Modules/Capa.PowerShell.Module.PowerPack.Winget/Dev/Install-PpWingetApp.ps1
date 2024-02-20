function Install-PpWingetApp {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$AppId,
		[Parameter(Mandatory = $false)]
		[string]$AppVersion,
		[Parameter(Mandatory = $false)]
		[bool]$AllowInstallOfWinGet = $false
	)
	$FunctionName = 'Install-PpWingetApp'

	$WingetPath = Find-PpWinGet -AllowInstallOfWinGet $AllowInstallOfWinGet
	if ($WingetPath -eq $false) {
		Job_WriteLog -Text 'WinGet was not found' -FunctionName $FunctionName
		return $false
	}
}