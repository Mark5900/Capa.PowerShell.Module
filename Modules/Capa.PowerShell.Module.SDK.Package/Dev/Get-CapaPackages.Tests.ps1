BeforeAll {
	. $PSScriptRoot\Get-CapaPackages.ps1
}

Describe 'Get-CapaPackages' {
	It 'Uses GetPackages when BusinessUnit is empty' {
		$script:getPackagesCalled = $false
		$script:getPackagesOnBuCalled = $false
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member ScriptMethod GetPackages {
			param($Type)
			$script:getPackagesCalled = $true
			@('Pkg;v1;Computer;Display;False;0;Desc;guid;1;False;0;False;0;500;False')
		}
		$CapaSDK | Add-Member ScriptMethod GetPackagesOnBusinessUnit {
			param($BusinessUnit)
			$script:getPackagesOnBuCalled = $true
			@()
		}

		$result = Get-CapaPackages -CapaSDK $CapaSDK -Type 'Computer'

		$result | Should -HaveCount 1
		$script:getPackagesCalled | Should -Be $true
		$script:getPackagesOnBuCalled | Should -Be $false
	}
}
