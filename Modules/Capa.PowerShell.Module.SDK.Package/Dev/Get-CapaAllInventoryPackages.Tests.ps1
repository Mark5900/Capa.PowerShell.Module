BeforeAll {
	. $PSScriptRoot\Get-CapaAllInventoryPackages.ps1
}

Describe 'Get-CapaAllInventoryPackages' {
	It 'Parses SDK response into objects' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member ScriptMethod GetAllInventoryPackages {
			param($PackageType)
			@('Pkg;v1;Computer;Display;False;0;Desc;guid;1;False;0;True;0;500;False')
		}

		$result = Get-CapaAllInventoryPackages -CapaSDK $CapaSDK -PackageType 'Computer'

		$result | Should -HaveCount 1
		$result[0].IsInventoryPackage | Should -Be 'True'
	}
}
