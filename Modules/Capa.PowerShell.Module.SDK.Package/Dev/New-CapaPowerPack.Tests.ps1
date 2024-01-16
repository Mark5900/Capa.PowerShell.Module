BeforeAll {
	# Import file
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
	$RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

	Import-Module "$RootPath\Capa.PowerShell.Module.SDK.Package\Dev\Import-CapaPackage.ps1"
	Import-Module "$RootPath\Capa.PowerShell.Module.SDK.Package\Dev\Remove-CapaPackage.ps1"
	Import-Module "$RootPath\Capa.PowerShell.Module.SDK.Package\Dev\Exist-CapaPackage.ps1"
	Import-Module "$RootPath\Capa.PowerShell.Module.SDK.Authentication\Dev\Initialize-CapaSDK.ps1"

	$CapaSDK = Initialize-CapaSDK -Server 'CISERVER' -Database 'CapaInstaller' -InstanceManagementPoint 1
}
Describe 'New plain PowerPack' {
	BeforeAll {
		$TempFolder = "C:\Users\$env:UserName\AppData\Local\CapaInstaller\CMS\TempScripts"
		$TempTempFolder = Join-Path $TempFolder 'Temp'

		$PowerPackSplatting = @{
			CapaSDK           = $CapaSDK
			PackageName       = 'Test1'
			PackageVersion    = 'v1.0'
			SqlServerInstance = 'CISERVER'
			Database          = 'CapaInstaller'
		}
		New-CapaPowerPack @PowerPackSplatting
	}
	It 'Package should exist' {
		$Package = Exist-CapaPackage -CapaSDK $CapaSDK -Name $PowerPackSplatting.PackageName -Version $PowerPackSplatting.PackageVersion -Type 'Computer'
		$Package | Should -Not -BeNullOrEmpty
	}
	It 'Temptemp folder should not exist' {
		$TempTempFolder | Should -Not -Exist
	}
	It 'Test package structure' {
		$PackagePath = Join-Path '\\localhost\CMPProduction\ComputerJobs' $PowerPackSplatting.PackageName $PowerPackSplatting.PackageVersion
		$DummyFile = Join-Path $PackagePath '\Kit\Dummy.txt'
		$KitFile = Join-Path $PackagePath '\Zip\CapaInstaller.kit'

		$DummyFile | Should -Exist
		$KitFile | Should -Exist
	}
	It 'Check data in DB' {
		$Query = "SELECT * FROM JOB WHERE Name = '$($PowerPackSplatting.PackageName)' AND Version = '$($PowerPackSplatting.PackageVersion)'"
		$Package = Invoke-Sqlcmd -ServerInstance $PowerPackSplatting.SqlServerInstance -Database $PowerPackSplatting.Database -Query $Query -TrustServerCertificate

		$Package | Should -Not -BeNullOrEmpty
		$Package.POWERPACK | Should -Be 'True'
		$Package.INSTALLSCRIPTCONTENT | Should -Not -BeNullOrEmpty
		$Package.UNINSTALLSCRIPTCONTENT | Should -Not -BeNullOrEmpty
	}
	AfterAll {
		$PackageSplatting = @{
			CapaSDK        = $CapaSDK
			PackageName    = $PowerPackSplatting.PackageName
			PackageVersion = $PowerPackSplatting.PackageVersion
			PackageType    = 'Computer'
		}
		Remove-CapaPackage @PackageSplatting
	}
}
Describe 'New PowerPack with it all' {
	BeforeAll {
		$TempFolder = "C:\Users\$env:UserName\AppData\Local\CapaInstaller\CMS\TempScripts"
		$TempTempFolder = Join-Path $TempFolder 'Temp'
		$KitFileName = 'Test2.txt'

		$PowerPackSplatting = @{
			CapaSDK                = $CapaSDK
			PackageName            = 'Test2'
			PackageVersion         = 'v1.0'
			DisplayName            = 'PowerPack Test2'
			InstallScriptContent   = 'Write-Host "Install"'
			UninstallScriptContent = 'Write-Host "Uninstall"'
			KitFolderPath          = 'C:\Temp\Kit'
			ChangelogComment       = 'Test'
			SqlServerInstance      = 'CISERVER'
			Database               = 'CapaInstaller'
			PointId                = 1
		}

		New-Item -Path $PowerPackSplatting.KitFolderPath -Name $KitFileName -ItemType File -Force | Out-Null

		New-CapaPowerPack @PowerPackSplatting
	}
	It 'Package should exist' {
		$Package = Exist-CapaPackage -CapaSDK $CapaSDK -Name $PowerPackSplatting.PackageName -Version $PowerPackSplatting.PackageVersion -Type 'Computer'
		$Package | Should -Not -BeNullOrEmpty
	}
	It 'Temptemp folder should not exist' {
		$TempTempFolder | Should -Not -Exist
	}
	It 'Test package structure' {
		$PackagePath = Join-Path '\\localhost\CMPProduction\ComputerJobs' $PowerPackSplatting.PackageName $PowerPackSplatting.PackageVersion
		$DummyFile = Join-Path $PackagePath 'Kit' $KitFileName
		$KitFile = Join-Path $PackagePath '\Zip\CapaInstaller.kit'

		$DummyFile | Should -Exist
		$KitFile | Should -Exist
	}
	It 'Check data in DB' {
		$Query = "SELECT * FROM JOB WHERE Name = '$($PowerPackSplatting.PackageName)' AND Version = '$($PowerPackSplatting.PackageVersion)'"
		$Package = Invoke-Sqlcmd -ServerInstance $PowerPackSplatting.SqlServerInstance -Database $PowerPackSplatting.Database -Query $Query -TrustServerCertificate

		$Package | Should -Not -BeNullOrEmpty
		$Package.POWERPACK | Should -Be 'True'
		$Package.INSTALLSCRIPTCONTENT | Should -Not -BeNullOrEmpty
		$Package.UNINSTALLSCRIPTCONTENT | Should -Not -BeNullOrEmpty
		$Package.DISPLAYNAME | Should -Be $PowerPackSplatting.DisplayName
	}
	AfterAll {
		$PackageSplatting = @{
			CapaSDK        = $CapaSDK
			PackageName    = $PowerPackSplatting.PackageName
			PackageVersion = $PowerPackSplatting.PackageVersion
			PackageType    = 'Computer'
		}
		Remove-CapaPackage @PackageSplatting
	}
}