<#
	.SYNOPSIS
		Install an application using winget

	.DESCRIPTION
		Install an application using winget

	.PARAMETER Id
		The id of the application to install.
		You can find all the available applications on https://winget.run

	.PARAMETER Locale
		The locale to use for the installation, for example 'da-DK'

	.PARAMETER AllowInstallOfWinGet
		Allow the installation of winget if it is not installed. Or update winget if it is installed.

	.EXAMPLE
		Install-PpWingetApp -Id 'Mozilla.Firefox'

	.EXAMPLE
		Install-PpWingetApp -Id 'Mozilla.Firefox' -Locale 'da-DK'

	.EXAMPLE
		Install-PpWingetApp -Id 'Mozilla.Firefox' -AllowInstallOfWinGet $true

	.NOTES
		Custom function not from CapaSystems.
		Idea from: https://github.com/Romanitho/Winget-Install/blob/main/winget-install.ps1
#>
function Install-PpWingetApp {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$AppId,
		[Parameter(Mandatory = $false)]
		[string]$Locale,
		[Parameter(Mandatory = $false)]
		[bool]$AllowInstallOfWinGet = $false
	)
	$FunctionName = 'Install-PpWingetApp'

	$WingetPath = Find-PpWinGetCmd

	$InstallCommand = "install -e --id $AppId -h --accept-package-agreements --accept-source-agreements --force"

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
		Arguments   = $InstallCommand
		Wait        = $true
		WindowStyle = 'Hidden'
		MustExist   = $true
	}

	$Result = Shell_Execute @ExecuteSplatting
	$Text = Get-PpWingetReturnCodeDescription -Decimal $Result
	Job_WriteLog -Text "Command completed with status: $Result" -FunctionName $FunctionName

	$AppInstalled = Confirm-PpWingetAppInstall -AppId 'Mozilla.Firefox'
	if ($AppInstalled) {
		Job_WriteLog -Text "$AppId was installed" -FunctionName $FunctionName
	} else {
		Job_WriteLog -Text "$AppId was not installed" -FunctionName $FunctionName
		Exit-PpCommandFailed -ExitMessage "$AppId was not installed"
	}

	return $Result
}