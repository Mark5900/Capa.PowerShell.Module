$ModulesPath = Join-Path $PSScriptRoot 'Modules'
$Modules = Get-ChildItem -Path $ModulesPath -Directory | Sort-Object { $_.Name.Length } -Descending

$VersionPath = Join-Path $PSScriptRoot 'version.txt'
$Version = (Get-Content -Path $VersionPath).Trim()

foreach ($Module in $Modules) {
	$ModulePath = Join-Path $ModulesPath $Module.Name 'Prod'

	try {
		Publish-Module -Path $ModulePath -NuGetApiKey $env:APIKEY
	} catch {
		Publish-PSResource -Path $ModulePath -ApiKey $env:APIKEY
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