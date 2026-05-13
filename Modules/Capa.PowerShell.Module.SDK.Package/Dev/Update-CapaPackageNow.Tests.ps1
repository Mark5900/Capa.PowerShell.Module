BeforeAll {
	. $PSScriptRoot\Update-CapaPackageNow.ps1
}

Describe 'Update-CapaPackageNow' {
	It 'Calls SDK method with expected values' {
		$script:called = $null
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member ScriptMethod PackageUpdateNow {
			param($PackageName, $PackageVersion, $PackageType)
			$script:called = @($PackageName, $PackageVersion, $PackageType)
			$true
		}

		$result = Update-CapaPackageNow -CapaSDK $CapaSDK -PackageName 'Pkg' -PackageVersion 'v1' -PackageType 'Computer'

		$result | Should -Be $true
		$script:called[2] | Should -Be 'Computer'
	}
}
