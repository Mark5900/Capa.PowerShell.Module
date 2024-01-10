function New-CapaPackageWithGit {
	param (
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('VBScript', 'PowerPack')]
		[string]$PackageType,
		[Parameter(Mandatory = $true)]
		[string]$BasePath,
		[Parameter(Mandatory = $false)]
		[string]$CapaServer,
		[Parameter(Mandatory = $false)]
		[string]$SQLServer,
		[Parameter(Mandatory = $false)]
		[string]$Database,
		[Parameter(Mandatory = $false)]
		[string]$DefaultManagementPoint,
		[Parameter(Mandatory = $false)]
		[string]$PackageBasePath,
		[Parameter(Mandatory = $false)]
		[switch]$Advanced
	)

	#region Parameters
	$GitIgnoreFile = Join-Path $PSScriptRoot 'Dependencies\.gitignore'
	$UpdatePackageScript = Join-Path $PSScriptRoot 'Dependencies\UpdatePackage.ps1'

	if ($PackageType -eq 'VBScript') {
		$TempInstallScript = Join-Path $PSScriptRoot 'Dependencies\Install.cis'
		$TempUninstallScript = Join-Path $PSScriptRoot 'Dependencies\Uninstall.cis'
	} ElseIf ($PackageType -eq 'PowerPack') {
		$TempInstallScript = Join-Path $PSScriptRoot 'Dependencies\Install.ps1'
		$TempUninstallScript = Join-Path $PSScriptRoot 'Dependencies\Uninstall.ps1'
	}

	$PackagePath = Join-Path $BasePath "Capa_$PackageName"

	if ($Advanced) {
		$ScriptPath = Join-Path $PackagePath 'Scripts'
		$KitPath = Join-Path $PackagePath 'Kit'
		$GitHubActionsPath = Join-Path $PackagePath '.github\workflows'
		$GitHubActionsFile = Join-Path $PSScriptRoot 'Dependencies\main.yml'
		$SettingsPath = Join-Path $PackagePath 'Settings.json'
		$SettingsFile = Join-Path $PSScriptRoot 'Dependencies\Settings.json'
	} Else {
		$VersionPath = Join-Path $PackagePath $PackageVersion
		$ScriptPath = Join-Path $VersionPath 'Scripts'
		$KitPath = Join-Path $VersionPath 'Kit'
	}
	#endregion
}