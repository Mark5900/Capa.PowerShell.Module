BeforeAll {
	. $PSScriptRoot\Get-CapaPackageUnits.ps1
}

Describe 'Get-CapaPackageUnits' {
	It 'Parses SDK response into objects' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member ScriptMethod GetPackageUnits {
			param($PackageName, $PackageVersion, $PackageType)
			@('PC01;2026-01-01;2026-01-02;1;Desc;guid-1;77;Computer')
		}

		$result = Get-CapaPackageUnits -CapaSDK $CapaSDK -PackageName 'Pkg' -PackageVersion 'v1' -PackageType 'Computer'

		$result | Should -HaveCount 1
		$result[0].Name | Should -Be 'PC01'
		$result[0].ID | Should -Be '77'
	}
}
