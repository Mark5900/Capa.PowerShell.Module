$ModulesPath = Join-Path $PSScriptRoot 'Modules'
$Modules = Get-ChildItem -Path $ModulesPath -Directory
foreach ($Module in $Modules) {
	$ModulePath = Join-Path $ModulesPath $Module.Name 'Prod'
	try {
		Publish-Module -Path $ModulePath -NuGetApiKey $env:APIKEY
	} catch {
		Publish-PSResource -Path $ModulePath -NuGetApiKey $env:APIKEY -Repository PSGallery
	}
}