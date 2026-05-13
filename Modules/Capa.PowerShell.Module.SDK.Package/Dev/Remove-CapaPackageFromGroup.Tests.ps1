BeforeAll {
	. $PSScriptRoot\Remove-CapaPackageFromGroup.ps1
}

Describe 'Remove-CapaPackageFromGroup' {
	It 'Calls SDK method with expected values' {
		$script:called = $null
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member ScriptMethod RemovePackageFromGroup {
			param($PackageName, $PackageVersion, $PackageType, $GroupName, $GroupType)
			$script:called = @($PackageName, $PackageVersion, $PackageType, $GroupName, $GroupType)
			$true
		}

		$result = Remove-CapaPackageFromGroup -CapaSDK $CapaSDK -PackageName 'Pkg' -PackageVersion 'v1' -PackageType 'Computer' -GroupName 'G1' -GroupType 'Static'

		$result | Should -Be $true
		$script:called[4] | Should -Be 'Static'
	}
}
