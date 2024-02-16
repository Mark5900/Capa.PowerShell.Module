$ModulesPath = Join-Path $PSScriptRoot 'Modules'
$Modules = Get-ChildItem -Path $ModulesPath -Directory | Sort-Object { $_.Name.Length } -Descending

$VersionPath = Join-Path $PSScriptRoot 'version.txt'
$Version = (Get-Content -Path $VersionPath).Trim()
Write-Host "Publishing version $Version"

foreach ($Module in $Modules) {
	Write-Host "Publishing module $($Module.Name)"
	$ModulePath = Join-Path $ModulesPath $Module.Name 'Prod'
	$PsdPath = Join-Path $ModulePath "$($Module.Name).psd1"

	Get-ChildItem $ModulePath | Import-Module

	<# Maybe it has something to do with that you need the required modules to be imported before publishing the module?
		Something fails with the manifest when publishing Capa.PowerShell.Module.PowerPack.

		The Error is:
		Failed to publish module Capa.PowerShell.Module.PowerPack
		Module manifest file validation failed with error: The specified RequiredModules entry 'Capa.PowerShell.Module.PowerPack.File' in the module manifest 'D:\a\Capa.PowerShell.Module\Capa.PowerShell.Module\Modules\Capa.PowerShell.Module.PowerPack\Prod\Capa.PowerShell.Module.PowerPack.psd1' is invalid. Try again after updating this entry with valid values.. Run 'Test-ModuleManifest' to validate the module manifest.
		Psd path: D:\a\Capa.PowerShell.Module\Capa.PowerShell.Module\Modules\Capa.PowerShell.Module.PowerPack\Prod\Capa.PowerShell.Module.PowerPack.psd1
		Test-ModuleManifest: D:\a\Capa.PowerShell.Module\Capa.PowerShell.Module\Publish.ps1:23
		Line |
			23 |              Test-ModuleManifest -Path $PsdPath
				|              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
				| The specified RequiredModules entry 'Capa.PowerShell.Module.PowerPack.File' in the module manifest
				| 'D:\a\Capa.PowerShell.Module\Capa.PowerShell.Module\Modules\Capa.PowerShell.Module.PowerPack\Prod\Capa.PowerShell.Module.PowerPack.psd1' is invalid. Try again after updating this entry with valid values.


	switch ($Modules[-8].Name) {
		'Capa.PowerShell.Module' {
			Start-Sleep -Seconds 10
		}
		'Capa.PowerShell.Module.PowerPack' {
			Start-Sleep -Seconds 10
		}
		'Capa.PowerShell.Module.SDK' {
			Start-Sleep -Seconds 10
		}
		Default {}
	}
	#>

	try {
		Publish-Module -Path $ModulePath -NuGetApiKey $env:APIKEY
	} catch {
		try {
			Publish-PSResource -Path $ModulePath -ApiKey $env:APIKEY
		} catch {
			Write-Host "Failed to publish module $($Module.Name)" -ForegroundColor Red
			Write-Host $_.Exception.Message
			Write-Host "Psd path: $PsdPath"

			Test-ModuleManifest -Path $PsdPath
			Write-Host $Error[0].Exception.Message
		}
	}

	$Run = $true

	while ($Run) {
		if (Find-Module -Name $Module.Name -RequiredVersion $Version -ErrorAction SilentlyContinue) {
			$Run = $false
		} else {
			Start-Sleep -Seconds 1
		}
	}
}