BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}
Describe 'Dependencies' {
	It 'Does all the dependencies exsist' {
		$DependenciesPath = Join-Path $PSScriptRoot 'Dependencies'
		$GitIgnoreFile = Join-Path $DependenciesPath '.gitignore'
		$VBInstallScript = Join-Path $DependenciesPath 'Install.cis'
		$VBUninstallScript = Join-Path $DependenciesPath 'Uninstall.cis'
		$PPInstallScript = Join-Path $DependenciesPath 'Install.ps1'
		$PPUninstallScript = Join-Path $DependenciesPath 'Uninstall.ps1'
		$UpdatePackageScript = Join-Path $DependenciesPath 'UpdatePackage.ps1'
		$GitHubActionsFile = Join-Path $DependenciesPath 'main.yml'
		$SettingsFile = Join-Path $DependenciesPath 'Settings.json'

		$DependenciesPath | Should -Exist
		$GitIgnoreFile | Should -Exist
		$VBInstallScript | Should -Exist
		$VBUninstallScript | Should -Exist
		$PPInstallScript | Should -Exist
		$PPUninstallScript | Should -Exist
		$UpdatePackageScript | Should -Exist
		$GitHubActionsFile | Should -Exist
		$SettingsFile | Should -Exist
	}
}
Describe 'VB package not advanced' {
	BeforeAll {
		$PackageSpllatting = @{
			PackageName            = 'Test'
			PackageVersion         = 'v1.0'
			PackageType            = 'VBScript'
			BasePath               = 'C:\Temp'
			CapaServer             = 'CISERVER'
			SQLServer              = 'CISERVER'
			Database               = 'CapaInstaller'
			DefaultManagementPoint = '1'
			PackageBasePath        = 'E:\CapaInstaller\CMPProduction\ComputerJobs'
		}
		New-CapaPackageWithGit @PackageSpllatting

		$PackagePath = Join-Path 'C:\Temp' 'Capa_Test'
		$VersionPath = Join-Path $PackagePath 'v1.0'
		$KitPath = Join-Path $VersionPath 'Kit'
		$ScriptPath = Join-Path $VersionPath 'Scripts'
		$GitIgnoreFile = Join-Path $PSScriptRoot 'Dependencies\.gitignore'

	}
	It 'Does the created folders exsist' {
		$PackagePath | Should -Exist
		$VersionPath | Should -Exist
		$KitPath | Should -Exist
		$ScriptPath | Should -Exist
	}
	#It "Does the created files exsist" {

	#}
}