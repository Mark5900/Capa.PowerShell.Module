BeforeAll {
	# Import file
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
	$RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

    $Folders = @(
        'Capa.PowerShell.Module.SDK.Authentication',
        'Capa.PowerShell.Module.SDK.Package'
    )
    foreach ($Folder in $Folders) {
        $Items = Get-ChildItem -Path "$RootPath\$Folder\Dev\" -Filter '*.ps1' | Where-Object { $_.Name -notlike '*Tests.ps1' }
        foreach ($Item in $Items) {
            Import-Module $Item.FullName -Force -ErrorAction Stop
        }
    }

    $oCMSDev = Initialize-CapaSDK -Server $env:COMPUTERNAME -Database 'CapaInstaller' -InstanceManagementPoint 1

	$PackageSplatting = @{
		CapaSDK           = $oCMSDev
		PackageName       = 'Test1'
		PackageVersion    = 'v1.0'
		DisplayName       = 'Test1 v1.0'
		SqlServerInstance = $env:COMPUTERNAME
		Database          = 'CapaInstaller'
	}
	$PackageExportSplatting = @{
		CapaSDK        = $oCMSDev
		PackageType    = 'Computer'
		PackageName    = 'Test1'
		PackageVersion = 'v1.0'
		ToFolder       = 'C:\Temp'
	}

	$PackageRemoveSplatting = @{
		CapaSDK        = $oCMSDev
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
			CapaSDK               = $oCMSDev
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