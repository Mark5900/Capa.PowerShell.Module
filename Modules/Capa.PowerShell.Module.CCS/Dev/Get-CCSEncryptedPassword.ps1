<#
	.SYNOPSIS
		This function encrypts a string using the InstallationScreen.exe utility.

	.DESCRIPTION
		This function takes a string as input and uses the InstallationScreen.exe utility to encrypt it.
		The encrypted string is returned as output and used multiple times, when working with the CCS Webservice.

	.PARAMETER String
		The string to be encrypted.

	.EXAMPLE
		PS C:\> Get-CCSEncryptedPassword -String "Admin1234"
#>
function Get-CCSEncryptedPassword {
	param (
		[Parameter(Mandatory = $true)]
		[string]$String
	)
	$OutputPath = Join-Path $env:TEMP 'InstallationScreen.log'

	try {
		$ExePath = Join-Path $PSScriptRoot 'Dependencies' 'InstallationScreen.exe'
		$Arguments = "power $String"

		if (Test-Path $OutputPath) {
			Remove-Item $OutputPath -Force
		}

		Start-Process -FilePath $ExePath -ArgumentList $Arguments -Wait -RedirectStandardOutput $OutputPath -NoNewWindow
		$Output = Get-Content $OutputPath

		return $Output.Trim() -replace '\r?\n', ''
	} catch {
		<#Do this if a terminating exception happens#>
	} finally {
		if (Test-Path $OutputPath) {
			Remove-Item $OutputPath -Force
		}
	}
}