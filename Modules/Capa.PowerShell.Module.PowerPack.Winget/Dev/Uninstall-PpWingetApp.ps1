<#
	.SYNOPSIS
		Uninstalls an application using winget.

	.DESCRIPTION
		Uninstalls an application using winget.

	.PARAMETER AppId
		The id of the application to uninstall.
		You can find all the available applications on https://winget.run

	.PARAMETER AllowInstallOfWinGet
		Allow the installation of winget if it is not installed. Or update winget if it is installed.

	.EXAMPLE
		Uninstall-PpWingetApp -AppId 'Mozilla.Firefox'

	.EXAMPLE
		Uninstall-PpWingetApp -AppId 'Mozilla.Firefox' -AllowInstallOfWinGet $true

	.NOTES
		Custom function not from CapaSystems.
#>
function Uninstall-PpWingetApp {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$AppId,
		[Parameter(Mandatory = $false)]
		[bool]$AllowInstallOfWinGet = $false
	)
	$FunctionName = 'Uninstall-PpWingetApp'

	$WingetPath = Find-PpWinGetCmd

	$UninstallCommand = "uninstall -e --id $AppId --force -h"

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
		Arguments   = $UninstallCommand
		Wait        = $true
		WindowStyle = 'Hidden'
		MustExist   = $true
	}

	$Result = Shell_Execute @ExecuteSplatting
	$Text = Get-PpWingetReturnCodeDescription -Decimal $Result
	Job_WriteLog -Text "Command completed with status: $Result" -FunctionName $FunctionName

	$AppInstalled = Confirm-PpWingetAppInstall -AppId $AppId
	if ($AppInstalled) {
		Job_WriteLog -Text "$AppId was not uninstalled" -FunctionName $FunctionName
		Exit-PpCommandFailed -ExitMessage "$AppId was not uninstalled"
	} else {
		Job_WriteLog -Text "$AppId was uninstalled" -FunctionName $FunctionName
	}
	return $Result
}