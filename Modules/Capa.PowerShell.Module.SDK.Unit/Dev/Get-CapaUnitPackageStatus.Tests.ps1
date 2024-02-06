BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
	$RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

	Import-Module "$RootPath\Capa.PowerShell.Module.SDK.Unit\Dev\Get-CapaUnits.ps1"
	Import-Module "$RootPath\Capa.PowerShell.Module.SDK.Unit\Dev\Get-CapaUnitPackages.ps1"
	Import-Module "$RootPath\Capa.PowerShell.Module.SDK.Authentication\Dev\Initialize-CapaSDK.ps1"

	$oCMS = Initialize-CapaSDK -Server 'localhost' -Database 'CapaInstaller' -DefaultManagementPoint '1'
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