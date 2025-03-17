BeforeAll {
	#region Import stuff
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
	$RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

	Import-Module "$RootPath\Capa.PowerShell.Module.SDK.Package\Dev\Remove-CapaPackage.ps1"
	Import-Module "$RootPath\Capa.PowerShell.Module.SDK.Package\Dev\New-CapaPackage.ps1"
	Import-Module "$RootPath\Capa.PowerShell.Module.SDK.Package\Dev\New-CapaPowerPack.ps1"
	Import-Module "$RootPath\Capa.PowerShell.Module.SDK.Package\Dev\Exist-CapaPackage.ps1"
	Import-Module "$RootPath\Capa.PowerShell.Module.SDK.Authentication\Dev\Initialize-CapaSDK.ps1"
	#endregion

	##region Parameters
	$VBPackageSplat = @{
		PackageName    = 'VBTest'
		PackageVersion = 'v1.0'
		UnitType       = 'Computer'
		DisplayName    = 'VBTest v1.0'
	}

	$PowerPackSplat = @{
		PackageName       = 'PowerPackTest'
		PackageVersion    = 'v1.0'
		DisplayName       = 'PowerPackTest v1.0'
		SqlServerInstance = $env:COMPUTERNAME
		Database          = 'CapaInstaller'
	}

	$PackageRoot = Get-ItemPropertyValue -Path 'registry::HKEY_LOCAL_MACHINE\SOFTWARE\CapaSystems\CapaInstaller' -Name 'Packageroot'
	$ComputerJobsPath = Join-Path $PackageRoot 'ComputerJobs'
	$VBPackageFolder = Join-Path $ComputerJobsPath $VBPackageSplat.PackageName $VBPackageSplat.PackageVersion
	$VBScriptsFolder = Join-Path $VBPackageFolder 'Scripts'
	$VBInstallScriptFile = Join-Path $VBScriptsFolder "$($VBPackageSplat.PackageName).cis"
	$VBUninstallScriptFile = Join-Path $VBScriptsFolder "$($VBPackageSplat.PackageName)_uninstall.cis"
	$VBKitFolder = Join-Path $VBPackageFolder 'Kit'
	$TestKitFolder = 'C:\Temp\Kit'
	#endregion

	$CapaSDK = Initialize-CapaSDK -Server $env:COMPUTERNAME -Database 'CapaInstaller' -InstanceManagementPoint 1

	if (Exist-CapaPackage -CapaSDK $CapaSDK -Name $VBPackageSplat.PackageName -Version $VBPackageSplat.PackageVersion -Type Computer) {
		Remove-CapaPackage -CapaSDK $CapaSDK -PackageName $VBPackageSplat.PackageName -PackageVersion $VBPackageSplat.PackageVersion -PackageType Computer
	}
	if (Exist-CapaPackage -CapaSDK $CapaSDK -Name $PowerPackSplat.PackageName -Version $PowerPackSplat.PackageVersion -Type Computer) {
		Remove-CapaPackage -CapaSDK $CapaSDK -PackageName $PowerPackSplat.PackageName -PackageVersion $PowerPackSplat.PackageVersion -PackageType Computer
	}

	New-CapaPackage -CapaSDK $CapaSDK @VBPackageSplat
	New-CapaPowerPack -CapaSDK $CapaSDK @PowerPackSplat

	if ((Test-Path $VBScriptsFolder) -eq $false) {
		New-Item -Path $VBScriptsFolder -ItemType Directory
	}
	if ((Test-Path $VBInstallScriptFile) -eq $false) {
		New-Item -Path $VBInstallScriptFile -ItemType File
	}
	if ((Test-Path $VBUninstallScriptFile) -eq $false) {
		New-Item -Path $VBUninstallScriptFile -ItemType File
	}
	if ((Test-Path $VBKitFolder) -eq $false) {
		New-Item -Path $VBKitFolder -ItemType Directory
	}
	if ((Test-Path $TestKitFolder) -eq $false) {
		New-Item -Path $TestKitFolder -ItemType Directory
	}
	if ((Test-Path "$TestKitFolder\Test.txt") -eq $false) {
		New-Item -Path "$TestKitFolder\Test.txt" -ItemType File
		Set-Content -Path "$TestKitFolder\Test.txt" -Value 'Test'
	}
}
Describe 'PowerPack type' {
	BeforeAll {
		$CommandSplatting = @{
			PackageName    = $PowerPackSplat.PackageName
			PackageVersion = $PowerPackSplat.PackageVersion
			ScriptContent = "Write-Host 'Hello World'"
			ScriptType 	= 'Install'
			PackageType = 'PowerPack'
			SqlServerInstance = $PowerPackSplat.SqlServerInstance
			Database = $PowerPackSplat.Database
		}
		}
		It "Does the function work" {
			$Query = "UPDATE JOB SET INSTALLSCRIPTCONTENT = NULL, UNINSTALLSCRIPTCONTENT = NULL WHERE Name = '$($PowerPackSplat.PackageName)' AND Version = '$($PowerPackSplat.PackageVersion)'"
			Invoke-Sqlcmd -ServerInstance $PowerPackSplat.SqlServerInstance -Database $PowerPackSplat.Database -Query $Query -TrustServerCertificate

		$Status = Update-CapaPackageScriptAndKit @CommandSplatting
		$Status | Should -Be $true

		$CommandSplatting.ScriptType = 'Uninstall'
		$Status = Update-CapaPackageScriptAndKit @CommandSplatting
		$Status | Should -Be $true
	}
	It 'Has it set the INSTALLSCRIPTCONTENT in DB' {
		$Query = "SELECT * FROM JOB WHERE Name = '$($PowerPackSplat.PackageName)' AND Version = '$($PowerPackSplat.PackageVersion)'"
		$Package = Invoke-Sqlcmd -ServerInstance $PowerPackSplat.SqlServerInstance -Database $PowerPackSplat.Database -Query $Query -TrustServerCertificate

		$Package | Should -Not -BeNullOrEmpty
		$Package.POWERPACK | Should -Be 'True'
		$Package.INSTALLSCRIPTCONTENT | Should -Not -BeNullOrEmpty
		$Package.UNINSTALLSCRIPTCONTENT | Should -Not -BeNullOrEmpty
	}
}
Describe 'VBScript type' {
	BeforeAll {
		$CommandSplatting = @{
			PackageName     = $VBPackageSplat.PackageName
			PackageVersion  = $VBPackageSplat.PackageVersion
			ScriptContent   = 'Test'
			ScriptType      = 'Install'
			PackageType     = 'VBScript'
			PackageBasePath = $ComputerJobsPath
		}
	}
	It 'Does the function work' {
		$Status = Update-CapaPackageScriptAndKit @CommandSplatting
		$Status | Should -Be $true

		$CommandSplatting.ScriptType = 'Uninstall'
		$Status = Update-CapaPackageScriptAndKit @CommandSplatting
		$Status | Should -Be $true
	}
	It 'Does install script contain the content' {
		$VBInstallScriptFile | Should -Exist
		$InstallFileContent = Get-Content $VBInstallScriptFile
		$InstallFileContent | Should -Contain $CommandSplatting.ScriptContent

		$VBUninstallScriptFile | Should -Exist
		$UninstallFileContent = Get-Content $VBUninstallScriptFile
		$UninstallFileContent | Should -Contain $CommandSplatting.ScriptContent
	}
}
Describe 'PowerPack with kit' {
	BeforeAll {
		$CommandSplatting = @{
			PackageName       = $PowerPackSplat.PackageName
			PackageVersion    = $PowerPackSplat.PackageVersion
			ScriptContent     = "Write-Host 'Hello World'"
			ScriptType        = 'Install'
			PackageType       = 'PowerPack'
			PackageBasePath   = $ComputerJobsPath
			SqlServerInstance = $PowerPackSplat.SqlServerInstance
			Database          = $PowerPackSplat.Database
			KitFolderPath     = $TestKitFolder
		}
	}
	It 'Does the function work' {
		$Query = "UPDATE JOB SET INSTALLSCRIPTCONTENT = NULL, UNINSTALLSCRIPTCONTENT = NULL WHERE Name = '$($PowerPackSplat.PackageName)' AND Version = '$($PowerPackSplat.PackageVersion)'"
		Invoke-Sqlcmd -ServerInstance $PowerPackSplat.SqlServerInstance -Database $PowerPackSplat.Database -Query $Query -TrustServerCertificate

			$Status = Update-CapaPackageScriptAndKit @CommandSplatting
			$Status | Should -Be $true

			$CommandSplatting.ScriptType = 'Uninstall'
			$Status = Update-CapaPackageScriptAndKit @CommandSplatting
			$Status | Should -Be $true
		}
		It 'Has it set the INSTALLSCRIPTCONTENT in DB' {
			$Query = "SELECT * FROM JOB WHERE Name = '$($PowerPackSplat.PackageName)' AND Version = '$($PowerPackSplat.PackageVersion)'"
			$Package = Invoke-Sqlcmd -ServerInstance $PowerPackSplat.SqlServerInstance -Database $PowerPackSplat.Database -Query $Query -TrustServerCertificate

			$Package | Should -Not -BeNullOrEmpty
			$Package.POWERPACK | Should -Be 'True'
			$Package.INSTALLSCRIPTCONTENT | Should -Not -BeNullOrEmpty
			$Package.UNINSTALLSCRIPTCONTENT | Should -Not -BeNullOrEmpty
		}
		It 'Has it copied the kit' {
			$KitPath = Join-Path $ComputerJobsPath $PowerPackSplat.PackageName $PowerPackSplat.PackageVersion 'Kit'
			$KitPath | Should -Exist
			$KitPath | Should -Not -BeNullOrEmpty
		}
	}
	Describe 'VBScript with kit' {
		BeforeAll {
			$CommandSplatting = @{
				PackageName    = $VBPackageSplat.PackageName
				PackageVersion = $VBPackageSplat.PackageVersion
				ScriptContent = "Test"
				ScriptType 	= 'Install'
				PackageType = 'VBScript'
				PackageBasePath = $ComputerJobsPath
				KitFolderPath = $TestKitFolder
			}
		}
		It "Does the function work" {
			$Status = Update-CapaPackageScriptAndKit @CommandSplatting
			$Status | Should -Be $true

			$CommandSplatting.ScriptType = 'Uninstall'
			$Status = Update-CapaPackageScriptAndKit @CommandSplatting
			$Status | Should -Be $true
		}
		It "Does install script contain the content" {
			$VBInstallScriptFile | Should -Exist
			$InstallFileContent = Get-Content $VBInstallScriptFile
			$InstallFileContent | Should -Contain $CommandSplatting.ScriptContent

			$VBUninstallScriptFile | Should -Exist
			$UninstallFileContent = Get-Content $VBUninstallScriptFile
			$UninstallFileContent | Should -Contain $CommandSplatting.ScriptContent
		}
		It 'Has it copied the kit' {
			$KitPath = Join-Path $ComputerJobsPath $VBPackageSplat.PackageName $VBPackageSplat.PackageVersion 'Kit'
			$KitPath | Should -Exist
			$KitPath | Should -Not -BeNullOrEmpty
		}
	}
	Describe 'Kit' {
		BeforeAll {
			$CommandSplatting = @{
				PackageName    = $PowerPackSplat.PackageName
				PackageVersion = $PowerPackSplat.PackageVersion
				PackageBasePath = $ComputerJobsPath
				KitFolderPath = $TestKitFolder
			}

		$Query = "UPDATE JOB SET INSTALLSCRIPTCONTENT = NULL, UNINSTALLSCRIPTCONTENT = NULL WHERE Name = '$($PowerPackSplat.PackageName)' AND Version = '$($PowerPackSplat.PackageVersion)'"
		Invoke-Sqlcmd -ServerInstance $PowerPackSplat.SqlServerInstance -Database $PowerPackSplat.Database -Query $Query -TrustServerCertificate

		}
		It "Does the function work" {
			$Status = Update-CapaPackageScriptAndKit @CommandSplatting
			$Status | Should -Be $true
		}
		It "Scripts should be null" {
			$Query = "SELECT * FROM JOB WHERE Name = '$($PowerPackSplat.PackageName)' AND Version = '$($PowerPackSplat.PackageVersion)'"
			$Package = Invoke-Sqlcmd -ServerInstance $PowerPackSplat.SqlServerInstance -Database $PowerPackSplat.Database -Query $Query -TrustServerCertificate

			$Package | Should -Not -BeNullOrEmpty
			$Package.POWERPACK | Should -Be 'True'
			$Package.INSTALLSCRIPTCONTENT | Should -BeNullOrEmpty
			$Package.UNINSTALLSCRIPTCONTENT | Should -BeNullOrEmpty
		}
		It 'Has it copied the kit' {
			$KitPath = Join-Path $ComputerJobsPath $VBPackageSplat.PackageName $VBPackageSplat.PackageVersion 'Kit'
			$KitPath | Should -Exist
			$KitPath | Should -Not -BeNullOrEmpty
		}
	}
	AfterAll {
		Remove-CapaPackage -CapaSDK $CapaSDK -PackageName $VBPackageSplat.PackageName -PackageVersion $VBPackageSplat.PackageVersion -PackageType Computer
		Remove-CapaPackage -CapaSDK $CapaSDK -PackageName $PowerPackSplat.PackageName -PackageVersion $PowerPackSplat.PackageVersion -PackageType Computer
		Remove-Item -Path $TestKitFolder -Recurse -Force
	}