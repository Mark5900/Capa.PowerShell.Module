BeforeAll {
	. $PSScriptRoot\Get-CapatAllNoneInventoryPackages.ps1
}

Describe 'Get-CapatAllNoneInventoryPackages' {
	It 'Parses SDK response into objects' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member ScriptMethod GetAllNoneInventoryPackages {
			param($PackageType)
			@('Pkg;v1;Computer;Display;False;0;Desc;guid;1;False;0;False;0;500;False')
		}

		$result = Get-CapatAllNoneInventoryPackages -CapaSDK $CapaSDK -PackageType 'Computer'

		$result | Should -HaveCount 1
		$result[0].IsInventoryPackage | Should -Be 'False'
	}
}
