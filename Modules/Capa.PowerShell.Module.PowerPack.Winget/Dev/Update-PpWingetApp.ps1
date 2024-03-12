<#
	.SYNOPSIS
		Updates an application using winget.

	.DESCRIPTION
		Updates an application using winget.

	.PARAMETER AppId
		The id of the application to update.
		You can find all the available applications on https://winget.run

	.PARAMETER Locale
		The locale to use for the installation, for example 'da-DK'

	.PARAMETER UninstallPrevious
		Uninstall the previous version of the package during upgrade.Behavior will depend on the individual package. Some installers are designed to install new versions side-by-side. Some installers include a manifest that specifies “uninstallPrevious” so earlier versions are uninstalled without needing to use this command flag. In this case, using the winget upgrade --uninstall-previous command will tell WinGet to uninstall the previous version regardless of what is in the package manifest. If the package manifest does not include “uninstallPrevious” and the --uninstall-previous flag is not used, then the default behavior for the installer will apply.

	.PARAMETER AllowInstallOfWinGet
		Allow the installation of winget if it is not installed. Or update winget if it is installed.

	.EXAMPLE
		Update-PpWingetApp -AppId 'Mozilla.Firefox'

	.EXAMPLE
		Update-PpWingetApp -AppId 'Mozilla.Firefox' -Locale 'da-DK'

	.EXAMPLE
		Update-PpWingetApp -AppId 'Mozilla.Firefox' -UninstallPrevious $true

	.EXAMPLE
		Update-PpWingetApp -AppId 'Mozilla.Firefox' -AllowInstallOfWinGet $true
#>
function Update-PpWingetApp {
	param (
		[Parameter(Mandatory = $true)]
		[string]$AppId,
		[Parameter(Mandatory = $false)]
		[string]$Locale,
		[Parameter(Mandatory = $false)]
		[bool]$UninstallPrevious = $false,
		[Parameter(Mandatory = $false)]
		[bool]$AllowInstallOfWinGet = $false
	)
	$FunctionName = 'Update-PpWingetApp'

	$WingetPath = Find-PpWinGetCmd

	$UpdateCommand = "upgrade --id $AppId -e -h --accept-source-agreements --force"

	if ($UninstallPrevious) {
		$UpdateCommand += ' --uninstall-previous'
	}

	if ($Locale) {
		$UpdateCommand += " --locale $Locale"
	}

	if ($AllowInstallOfWinGet) {
		Install-PpWingetPrerequisites -WingetPath $WingetPath
		$WingetPath = Find-PpWinGetCmd
	}

	if ($WingetPath -eq $false) {
		Job_WriteLog -Text 'Winget not found' -FunctionName $FunctionName
		Exit-PpPackageFailedInstall -ExitMessage 'Winget not found'
	}

	$ExecuteSplatting = @{
		Command     = $WingetPath
		Arguments   = $UpdateCommand
		Wait        = $true
		WindowStyle = 'Hidden'
		MustExist   = $true
	}
	$Result = Shell_Execute @ExecuteSplatting
	$Text = Get-PpWingetReturnCodeDescription -Decimal $Result
	Job_WriteLog -Text "Command completed with status: $Result" -FunctionName $FunctionName

	return $Result
}