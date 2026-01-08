BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
	$RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

    $Folders = @(
        'Capa.PowerShell.Module.SDK.Authentication',
        'Capa.PowerShell.Module.SDK.Unit'
    )
    foreach ($Folder in $Folders) {
        $Items = Get-ChildItem -Path "$RootPath\$Folder\Dev\" -Filter '*.ps1' | Where-Object { $_.Name -notlike '*Tests.ps1' }
        foreach ($Item in $Items) {
            Import-Module $Item.FullName -Force -ErrorAction Stop
        }
    }


	$oCMS = Initialize-CapaSDK -Server 'localhost' -Database 'CapaInstaller' -DefaultManagementPoint '2'
}
Describe 'Get-CapaUnitPackageStatus' {
	BeforeAll {
		$Units = Get-CapaUnits -CapaSDK $oCMS -Type Computer
		$Packages = Get-CapaUnitPackages -CapaSDK $oCMS -UnitName $Units[0].Name -UnitType Computer
	}
	It 'Test the function' {
		$Splatting = @{
			CapaSDK        = $oCMS
			UnitName       = $Units[0].Name
			UnitType       = 'Computer'
			PackageName    = $Packages[0].Name
			PackageVersion = $Packages[0].Version
		}
		$Status = Get-CapaUnitPackageStatus @Splatting
		$Status | Should -Not -BeNullOrEmpty
	}
}