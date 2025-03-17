BeforeAll {
	# Import file
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
	$RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

	Import-Module "$RootPath\Capa.PowerShell.Module.SDK.Package\Dev\Remove-CapaPackage.ps1"
	Import-Module "$RootPath\Capa.PowerShell.Module.SDK.Package\Dev\Exist-CapaPackage.ps1"
	Import-Module "$RootPath\Capa.PowerShell.Module.SDK.Package\Dev\New-CapaPowerPack.ps1"
	Import-Module "$RootPath\Capa.PowerShell.Module.SDK.Package\Dev\Export-CapaPackage.ps1"
	Import-Module "$RootPath\Capa.PowerShell.Module.SDK.Authentication\Dev\Initialize-CapaSDK.ps1"

	$CapaSDK = Initialize-CapaSDK -Server $env:COMPUTERNAME -Database 'CapaInstaller' -InstanceManagementPoint 1

	$PackageSplatting = @{
		CapaSDK           = $CapaSDK
		PackageName       = 'Test1'
		PackageVersion    = 'v1.0'
		DisplayName       = 'Test1 v1.0'
		SqlServerInstance = $env:COMPUTERNAME
		Database          = 'CapaInstaller'
	}
	$PackageExportSplatting = @{
		CapaSDK        = $CapaSDK
		PackageType    = 'Computer'
		PackageName    = 'Test1'
		PackageVersion = 'v1.0'
		ToFolder       = 'C:\Temp'
	}

	$PackageRemoveSplatting = @{
		CapaSDK        = $CapaSDK
		PackageName    = 'Test1'
		PackageVersion = 'v1.0'
		PackageType    = 'Computer'
	}

	if (!(Test-Path $PackageExportSplatting.ToFolder)) {
		New-Item -Path $PackageExportSplatting.ToFolder -ItemType Directory
	}

	New-CapaPowerPack @PackageSplatting
	Export-CapaPackage @PackageExportSplatting
	Remove-CapaPackage @PackageRemoveSplatting

	# Wait for the package to be removed and the export to be completed
	Start-Sleep -Seconds 10
}
Describe 'Test Import-CapaPackage' {
	BeforeAll {
		$PackageImportSplatting = @{
			CapaSDK               = $CapaSDK
			FilePath              = 'C:\Temp\Test1_v1.0.zip'
			OverrideCIPCdata      = $true
			ImportFolderStructure = $true
			ImportSchedule        = $true
		}
	}
	It 'Does the function work' {
		$Status = Import-CapaPackage @PackageImportSplatting
		$Status | Should -Be $true
	}
}
AfterAll {
	Remove-CapaPackage @PackageRemoveSplatting
	Remove-Item -Path 'C:\Temp\Test1_v1.0.zip' -Force
}