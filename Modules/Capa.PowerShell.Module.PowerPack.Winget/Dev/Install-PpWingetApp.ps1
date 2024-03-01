function Install-PpWingetApp {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$Id,
		[Parameter(Mandatory = $false)]
		[string]$Locale,
		[Parameter(Mandatory = $false)]
		[bool]$AllowInstallOfWinGet = $false
	)
	$FunctionName = 'Install-PpWingetApp'

	$WingetPath = Find-PpWinGetCmd

	$InstallCommand = "install -e --id $Id -h --accept-package-agreements --accept-source-agreements --force"

	if ($Locale) {
		$InstallCommand += " --locale $Locale"
	}

	if ($AllowInstallOfWinGet) {
		Install-PpWingetPrerequisites -WingetPath $WingetPath
		$WingetPath = Find-PpWinGetCmd
	}

	if ($WingetPath -eq $false) {
		Job_WriteLog -Text 'Winget not found' -FunctionName $FunctionName
		Exit-PpPackageFailedInstall -ExitMessage 'Winget not found'
	}

	Add-PpWingetScopeMachine

	$ExecuteSplatting = @{
		Command     = $WingetPath
		Arguments   = "$InstallCommande"
		Wait        = $true
		WindowStyle = 'Hidden'
		MustExist   = $true
	}

	$Result = Shell_Execute @ExecuteSplatting
	Get-PpWingetErrorCode -Decimal $Result
	Job_WriteLog -Text "Command completed with status: $Result"
}