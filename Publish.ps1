$ModulesPath = Join-Path $PSScriptRoot 'Modules'
$Modules = Get-ChildItem -Path $ModulesPath -Directory
foreach ($Module in $Modules) {
	$ModulePath = Join-Path $ModulesPath $Module 'Prod'
	Publish-Module -Path $ModulePath -NuGetApiKey $env:APIKEY
}