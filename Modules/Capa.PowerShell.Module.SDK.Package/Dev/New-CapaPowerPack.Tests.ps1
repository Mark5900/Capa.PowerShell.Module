BeforeAll {
	# Import file
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
	$RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

	Import-Module "$RootPath\Capa.PowerShell.Module.SDK.Package\Dev\Import-CapaPackage.ps1"
	Import-Module "$RootPath\Capa.PowerShell.Module.SDK.Package\Dev\Remove-CapaPackage.ps1"
	Import-Module "$RootPath\Capa.PowerShell.Module.SDK.Package\Dev\Exist-CapaPackage.ps1"
	Import-Module "$RootPath\Capa.PowerShell.Module.SDK.Authentication\Dev\Initialize-CapaSDK.ps1"

	$CapaSDK = Initialize-CapaSDK -Server $env:COMPUTERNAME -Database 'CapaInstaller' -InstanceManagementPoint 1

	$PackageRoot = Get-ItemPropertyValue -Path 'registry::HKEY_LOCAL_MACHINE\SOFTWARE\CapaSystems\CapaInstaller' -Name 'Packageroot'
	$ComputerJobPath = Join-Path $PackageRoot 'ComputerJobs'
}
Describe 'New plain PowerPack' {
	BeforeAll {
		$TempFolder = "C:\Users\$env:UserName\AppData\Local\CapaInstaller\CMS\TempScripts"
		$TempTempFolder = Join-Path $TempFolder 'Temp'

		$PowerPackSplatting = @{
			CapaSDK           = $CapaSDK
			PackageName       = 'Test1'
			PackageVersion    = 'v1.0'
			SqlServerInstance = $env:COMPUTERNAME
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
		$PackagePath = Join-Path $ComputerJobPath $PowerPackSplatting.PackageName $PowerPackSplatting.PackageVersion
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
			SqlServerInstance      = $env:COMPUTERNAME
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
		$PackagePath = Join-Path $ComputerJobPath $PowerPackSplatting.PackageName $PowerPackSplatting.PackageVersion
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
Describe 'New PowerPack with large kit folder' {
	BeforeAll {
		$TempFolder = "C:\Users\$env:UserName\AppData\Local\CapaInstaller\CMS\TempScripts"
		$TempTempFolder = Join-Path $TempFolder 'Temp'
		$KitFolderPath = 'C:\Temp\Kit'
		$KitFileName1 = 'Test3.1.txt'
		$KitFileName2 = 'Test3.2.txt'
		$KitFileName3 = 'Test3.3.txt'

		$PowerPackSplatting = @{
			CapaSDK                = $CapaSDK
			PackageName            = 'Test3'
			PackageVersion         = 'v1.0'
			DisplayName            = 'PowerPack Test3'
			InstallScriptContent   = 'Write-Host "Install"'
			UninstallScriptContent = 'Write-Host "Uninstall"'
			KitFolderPath          = $KitFolderPath
			ChangelogComment       = 'Test'
			SqlServerInstance      = $env:COMPUTERNAME
			Database               = 'CapaInstaller'
			PointId                = 1
		}

		# Create large files
		$Size = 1GB
		$Content = New-Object byte[] $Size
		(New-Object System.Random).NextBytes($Content)

		[System.IO.File]::WriteAllBytes("$KitFolderPath\$KitFileName1", $Content)
		[System.IO.File]::WriteAllBytes("$KitFolderPath\$KitFileName2", $Content)
		[System.IO.File]::WriteAllBytes("$KitFolderPath\$KitFileName3", $Content)

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
		$PackagePath = Join-Path $ComputerJobPath $PowerPackSplatting.PackageName $PowerPackSplatting.PackageVersion
		$DummyFile1 = Join-Path $PackagePath 'Kit' $KitFileName1
		$DummyFile2 = Join-Path $PackagePath 'Kit' $KitFileName2
		$DummyFile3 = Join-Path $PackagePath 'Kit' $KitFileName3
		$KitFile = Join-Path $PackagePath '\Zip\CapaInstaller.kit'
		$DummyFile1Size = (Get-Item $DummyFile1).Length
		$DummyFile2Size = (Get-Item $DummyFile2).Length
		$DummyFile3Size = (Get-Item $DummyFile3).Length

		$DummyFile1 | Should -Exist
		$DummyFile2 | Should -Exist
		$DummyFile3 | Should -Exist
		$DummyFile1Size | Should -Be 1GB
		$DummyFile2Size | Should -Be 1GB
		$DummyFile3Size | Should -Be 1GB
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
AfterAll {
	Remove-Item -Path 'C:\Temp\Kit' -Force -Confirm:$false -Recurse
}