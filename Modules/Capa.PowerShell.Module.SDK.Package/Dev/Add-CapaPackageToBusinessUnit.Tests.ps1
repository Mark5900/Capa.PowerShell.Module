BeforeAll {
	. $PSScriptRoot\Add-CapaPackageToBusinessUnit.ps1
}

Describe 'Add-CapaPackageToBusinessUnit' {
	It 'Calls SDK method and maps Computer to 1' {
		$script:called = $null
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name AddPackageToBusinessUnit -Value {
			param($PackageName, $PackageVersion, $PackageType, $BusinessUnitName)
			$script:called = @($PackageName, $PackageVersion, $PackageType, $BusinessUnitName)
			$true
		}

		$result = Add-CapaPackageToBusinessUnit -CapaSDK $CapaSDK -PackageName 'Pkg' -PackageVersion 'v1' -PackageType 'Computer' -BusinessUnitName 'BU1'

		$result | Should -Be $true
		$script:called[2] | Should -Be '1'
	}
}
