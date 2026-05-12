BeforeAll {
	. $PSScriptRoot\Get-CapaPackageGroups.ps1
}

Describe 'Get-CapaPackageGroups' {
	It 'Parses SDK response into objects' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member ScriptMethod GetPackageGroups {
			param($PackageName, $PackageVersion, $PackageType)
			@('G1;Static;1;Desc;guid-1;42')
		}

		$result = Get-CapaPackageGroups -CapaSDK $CapaSDK -PackageType 'Computer' -PackageName 'Pkg' -PackageVersion 'v1'

		$result | Should -HaveCount 1
		$result[0].Name | Should -Be 'G1'
		$result[0].ID | Should -Be '42'
	}
}
