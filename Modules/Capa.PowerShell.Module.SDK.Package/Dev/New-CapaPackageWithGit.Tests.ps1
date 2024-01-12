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
			PackageName            = 'Test1'
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

		$PackagePath = Join-Path 'C:\Temp' "Capa_$($PackageSpllatting.PackageName)"
		$VersionPath = Join-Path $PackagePath $PackageSpllatting.PackageVersion
		$KitPath = Join-Path $VersionPath 'Kit'
		$ScriptPath = Join-Path $VersionPath 'Scripts'
		$GitIgnoreFile = Join-Path $PackagePath '.gitignore'
		$UpdateScript = Join-Path $PackagePath 'UpdatePackage.ps1'
		$InstallScript = Join-Path $ScriptPath "$($PackageSpllatting.PackageName).cis"
		$UninstallScript = Join-Path $ScriptPath "$($PackageSpllatting.PackageName)_Uninstall.cis"
	}
	It 'Does the created folders exsist' {
		$PackagePath | Should -Exist
		$VersionPath | Should -Exist
		$KitPath | Should -Exist
		$ScriptPath | Should -Exist
	}
	It 'Does the created files exsist' {
		$GitIgnoreFile | Should -Exist
		$UpdateScript | Should -Exist
		$InstallScript | Should -Exist
		$UninstallScript | Should -Exist
	}
	It 'Does the installfile contains the correct content' {
		$InstallScript | Should -FileContentMatch $PackageSpllatting.PackageName
		$InstallScript | Should -FileContentMatch $PackageSpllatting.PackageVersion
		$InstallScript | Should -FileContentMatch $env:USERNAME
		$InstallScript | Should -FileContentMatch (Get-Date -Format 'dd-MM-yyyy')
	}
	It 'Does the uninstallfile contains the correct content' {
		$UninstallScript | Should -FileContentMatch $PackageSpllatting.PackageName
		$UninstallScript | Should -FileContentMatch $PackageSpllatting.PackageVersion
		$UninstallScript | Should -FileContentMatch $env:USERNAME
		$UninstallScript | Should -FileContentMatch (Get-Date -Format 'dd-MM-yyyy')
	}
	It 'Does the update package script contains the correct content' {
		$UpdateScript | Should -FileContentMatch "CapaServer = '$($PackageSpllatting.CapaServer)'"
		$UpdateScript | Should -FileContentMatch "SQLServer = '$($PackageSpllatting.SQLServer)'"
		$UpdateScript | Should -FileContentMatch "Database = '$($PackageSpllatting.Database)'"
		$UpdateScript | Should -FileContentMatch "DefaultManagementPointDev = '$($PackageSpllatting.DefaultManagementPoint)'"
		$UpdateScript | Should -FileContentMatch "PackageBasePath = '$($PackageSpllatting.PackageBasePath.Replace('\','\\'))'"
	}
	AfterAll {
		Remove-Item -Path $PackagePath -Recurse -Force
	}
}
Describe 'PowerPack package not advanced' {
	BeforeAll {
		$PackageSpllatting = @{
			PackageName            = 'Test2'
			PackageVersion         = 'v1.0'
			PackageType            = 'PowerPack'
			BasePath               = 'C:\Temp'
			CapaServer             = 'CISERVER'
			SQLServer              = 'CISERVER'
			Database               = 'CapaInstaller'
			DefaultManagementPoint = '1'
			PackageBasePath        = 'E:\CapaInstaller\CMPProduction\ComputerJobs'
		}
		New-CapaPackageWithGit @PackageSpllatting

		$PackagePath = Join-Path 'C:\Temp' "Capa_$($PackageSpllatting.PackageName)"
		$VersionPath = Join-Path $PackagePath $PackageSpllatting.PackageVersion
		$KitPath = Join-Path $VersionPath 'Kit'
		$ScriptPath = Join-Path $VersionPath 'Scripts'
		$GitIgnoreFile = Join-Path $PackagePath '.gitignore'
		$UpdateScript = Join-Path $PackagePath 'UpdatePackage.ps1'
		$InstallScript = Join-Path $ScriptPath 'Install.ps1'
		$UninstallScript = Join-Path $ScriptPath 'Uninstall.ps1'
	}
	It 'Does the created folders exsist' {
		$PackagePath | Should -Exist
		$VersionPath | Should -Exist
		$KitPath | Should -Exist
		$ScriptPath | Should -Exist
	}
	It 'Does the created files exsist' {
		$GitIgnoreFile | Should -Exist
		$UpdateScript | Should -Exist
		$InstallScript | Should -Exist
		$UninstallScript | Should -Exist
	}
	It 'Does the update package script contains the correct content' {
		$UpdateScript | Should -FileContentMatch "CapaServer = '$($PackageSpllatting.CapaServer)'"
		$UpdateScript | Should -FileContentMatch "SQLServer = '$($PackageSpllatting.SQLServer)'"
		$UpdateScript | Should -FileContentMatch "Database = '$($PackageSpllatting.Database)'"
		$UpdateScript | Should -FileContentMatch "DefaultManagementPointDev = '$($PackageSpllatting.DefaultManagementPoint)'"
		$UpdateScript | Should -FileContentMatch "PackageBasePath = '$($PackageSpllatting.PackageBasePath.Replace('\','\\'))'"
	}
	AfterAll {
		Remove-Item -Path $PackagePath -Recurse -Force
	}
}