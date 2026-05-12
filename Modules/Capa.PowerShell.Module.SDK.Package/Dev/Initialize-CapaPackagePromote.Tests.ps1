BeforeAll {
	. $PSScriptRoot\Initialize-CapaPackagePromote.ps1
}

Describe 'Initialize-CapaPackagePromote' {
	It 'Calls SDK method with expected values' {
		$script:called = $null
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member ScriptMethod PackagePromote {
			param($PackageName, $PackageVersion, $PackageType)
			$script:called = @($PackageName, $PackageVersion, $PackageType)
			$true
		}

		$result = Initialize-CapaPackagePromote -CapaSDK $CapaSDK -PackageType 'Computer' -PackageName 'Pkg' -PackageVersion 'v1'

		$result | Should -Be $true
		$script:called[0] | Should -Be 'Pkg'
	}
}
