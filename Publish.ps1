$ModulesPath = Join-Path $PSScriptRoot 'Modules'
$Modules = Get-ChildItem -Path $ModulesPath -Directory | Sort-Object { $_.Name.Length } -Descending
foreach ($Module in $Modules) {
	$ModulePath = Join-Path $ModulesPath $Module.Name 'Prod'
	try {
		Publish-Module -Path $ModulePath -NuGetApiKey $env:APIKEY
	} catch {
		Publish-PSResource -Path $ModulePath -ApiKey $env:APIKEY -Repository PSGallery
	}
}