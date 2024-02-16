$ModulesPath = Join-Path $PSScriptRoot 'Modules'
$Modules = Get-ChildItem -Path $ModulesPath -Directory | Sort-Object { $_.Name.Length } -Descending

$VersionPath = Join-Path $PSScriptRoot 'version.txt'
$Version = (Get-Content -Path $VersionPath).Trim()
Write-Host "Publishing version $Version"

foreach ($Module in $Modules) {
	Write-Host "Publishing module $($Module.Name)"
	$ModulePath = Join-Path $ModulesPath $Module.Name 'Prod'
	$PsdPath = Join-Path $ModulePath "$($Module.Name).psd1"

	try {
		Publish-Module -Path $ModulePath -NuGetApiKey $env:APIKEY
	} catch {
		try {
			Publish-PSResource -Path $ModulePath -ApiKey $env:APIKEY
		} catch {
			Test-ModuleManifest -Path $PsdPath
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