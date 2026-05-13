BeforeAll {
	. $PSScriptRoot\Add-CapaPackageToGroup.ps1
}

Describe 'Add-CapaPackageToGroup' {
	It 'Calls SDK method with expected values' {
		$script:called = $null
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member ScriptMethod AddPackageToGroup {
			param($PackageName, $PackageVersion, $PackageType, $GroupName, $GroupType)
			$script:called = @($PackageName, $PackageVersion, $PackageType, $GroupName, $GroupType)
			$true
		}

		$result = Add-CapaPackageToGroup -CapaSDK $CapaSDK -PackageName 'Pkg' -PackageVersion 'v1' -PackageType 'Computer' -GroupName 'G1' -GroupType 'Static'

		$result | Should -Be $true
		$script:called[3] | Should -Be 'G1'
	}
}
