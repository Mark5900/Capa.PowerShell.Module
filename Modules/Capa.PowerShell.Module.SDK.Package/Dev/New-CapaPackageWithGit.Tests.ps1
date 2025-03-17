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
			CapaServer             = $env:COMPUTERNAME
			SQLServer              = $env:COMPUTERNAME
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
		$DummyFile = Join-Path $KitPath 'CapaInstaller.txt'
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
		$DummyFile | Should -Exist
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
			CapaServer             = $env:COMPUTERNAME
			SQLServer              = $env:COMPUTERNAME
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
		$DummyFile = Join-Path $KitPath 'CapaInstaller.txt'
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
		$DummyFile | Should -Exist
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
Describe 'VB package advanced' {
	BeforeAll {
		$PackageSpllatting = @{
			SoftwareName           = 'Test3'
			SoftwareVersion        = '1.0'
			PackageType            = 'VBScript'
			BasePath               = 'C:\Temp'
			CapaServer             = $env:COMPUTERNAME
			SQLServer              = $env:COMPUTERNAME
			Database               = 'CapaInstaller'
			DefaultManagementPoint = '1'
			PackageBasePath        = 'E:\CapaInstaller\CMPProduction\ComputerJobs'
		}
		New-CapaPackageWithGit @PackageSpllatting -Advanced

		$PackagePath = Join-Path 'C:\Temp' "Capa_$($PackageSpllatting.SoftwareName)"
		$KitPath = Join-Path $PackagePath 'Kit'
		$ScriptPath = Join-Path $PackagePath 'Scripts'
		$GitHubActionsPath = Join-Path $PackagePath '.github\workflows'
		$GitIgnoreFile = Join-Path $PackagePath '.gitignore'
		$UpdateScript = Join-Path $PackagePath 'UpdatePackage.ps1'
		$InstallScript = Join-Path $ScriptPath "$($PackageSpllatting.SoftwareName).cis"
		$UninstallScript = Join-Path $ScriptPath "$($PackageSpllatting.SoftwareName)_Uninstall.cis"
		$GitHubActionsFile = Join-Path $GitHubActionsPath 'main.yml'
		$SettingsFile = Join-Path $PackagePath 'Settings.json'
		$DummyFile = Join-Path $KitPath 'CapaInstaller.txt'
	}
	It 'Does the created folders exsist' {
		$PackagePath | Should -Exist
		$KitPath | Should -Exist
		$ScriptPath | Should -Exist
		$GitHubActionsPath | Should -Exist
	}
	It 'Does the created files exsist' {
		$GitIgnoreFile | Should -Exist
		$UpdateScript | Should -Exist
		$InstallScript | Should -Exist
		$UninstallScript | Should -Exist
		$GitHubActionsFile | Should -Exist
		$SettingsFile | Should -Exist
		$DummyFile | Should -Exist
	}
	It 'Does the installfile contains the correct content' {
		$InstallScript | Should -FileContentMatch $PackageSpllatting.SoftwareName
		$InstallScript | Should -FileContentMatch $PackageSpllatting.SoftwareVersion
		$InstallScript | Should -FileContentMatch $env:USERNAME
		$InstallScript | Should -FileContentMatch (Get-Date -Format 'dd-MM-yyyy')
	}
	It 'Does the uninstallfile contains the correct content' {
		$UninstallScript | Should -FileContentMatch $PackageSpllatting.SoftwareName
		$UninstallScript | Should -FileContentMatch $PackageSpllatting.SoftwareVersion
		$UninstallScript | Should -FileContentMatch $env:USERNAME
		$UninstallScript | Should -FileContentMatch (Get-Date -Format 'dd-MM-yyyy')
	}
	It 'Does the update package script contains the correct content' {
		$UpdateScript | Should -FileContentMatch 'CapaServer = ..'
		$UpdateScript | Should -FileContentMatch 'SQLServer = ..'
		$UpdateScript | Should -FileContentMatch 'Database = ..'
		$UpdateScript | Should -FileContentMatch 'DefaultManagementPointDev = ..'
		$UpdateScript | Should -FileContentMatch 'PackageBasePath = ..'
	}
	It 'Does the setting file contains the correct content' {
		$Content = Get-Content $SettingsFile | ConvertFrom-Json

		$Content.SoftwareName | Should -Be $PackageSpllatting.SoftwareName
		$Content.SoftwareVersion | Should -Be $PackageSpllatting.SoftwareVersion
		$Content.CapaServer | Should -Be $PackageSpllatting.CapaServer
		$Content.SQLServer | Should -Be $PackageSpllatting.SQLServer
		$Content.Database | Should -Be $PackageSpllatting.Database
		$Content.DefaultManagementPoint | Should -Be $PackageSpllatting.DefaultManagementPoint
		$Content.PackageBasePath | Should -Be $PackageSpllatting.PackageBasePath
	}
	AfterAll {
		Remove-Item -Path $PackagePath -Recurse -Force
	}
}
AfterAll {
	Get-Module | Remove-Module
}