BeforeAll {
	. $PSScriptRoot\Clone-CapaPackage.ps1
}

Describe 'Clone-CapaPackage' {
	It 'Calls SDK method with expected values' {
		$script:called = $null
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member ScriptMethod ClonePackage {
			param($PackageName, $PackageVersion, $PackageType, $NewVersion)
			$script:called = @($PackageName, $PackageVersion, $PackageType, $NewVersion)
			$true
		}

		$result = Clone-CapaPackage -CapaSDK $CapaSDK -PackageName 'Pkg' -PackageVersion 'v1' -PackageType 'Computer' -NewVersion 'v2'

		$result | Should -Be $true
		$script:called[3] | Should -Be 'v2'
	}
}
