$ModulesPath = Join-Path $PSScriptRoot 'Modules'
$Modules = Get-ChildItem -Path $ModulesPath -Directory
foreach ($Module in $Modules) {
	$ModulePath = Join-Path $ModulesPath $Module
	Publish-Module -Path $ModulePath -NuGetApiKey $env:APIKEY -Exclude 'Dev'
}