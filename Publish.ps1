$ModulesPath = Join-Path $PSScriptRoot 'Modules'
$Modules = Get-ChildItem -Path $ModulesPath -Directory | Sort-Object { $_.Name.Length } -Descending

$VersionPath = Join-Path $PSScriptRoot 'version.txt'
$Version = (Get-Content -Path $VersionPath).Trim()
Write-Host "Publishing version $Version"

foreach ($Module in $Modules) {
	Write-Host "Publishing module $($Module.Name)"
	$ModulePath = Join-Path $ModulesPath $Module.Name 'Prod'
	$PsdPath = Join-Path $ModulePath "$($Module.Name).psd1"

	if (Find-Module -Name $Module.Name -RequiredVersion $Version -ErrorAction SilentlyContinue) {
		Write-Host "Module $($Module.Name) version $Version already published. Skipping" -ForegroundColor Green
		continue
	}

	try {
		Publish-PSResource -Path $ModulePath -ApiKey $env:APIKEY -SkipDependenciesCheck -SkipModuleManifestValidate
	} catch {
		Write-Host "Failed to publish module $($Module.Name)" -ForegroundColor Red
		Write-Host $_.Exception.Message
		Write-Host "Psd path: $PsdPath"

		Test-ModuleManifest -Path $PsdPath
		Write-Host $Error[0].Exception.Message
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