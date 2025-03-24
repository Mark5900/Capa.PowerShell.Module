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