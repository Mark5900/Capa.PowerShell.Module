BeforeAll {
	. $PSScriptRoot\Set-CapaPackagePriority.ps1
}

Describe 'Set-CapaPackagePriority' {
	It 'Calls SDK method and maps Computer to 1' {
		$script:called = $null
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member ScriptMethod SetPackagePriority {
			param($PackageName, $PackageVersion, $PackageType, $Priority)
			$script:called = @($PackageName, $PackageVersion, $PackageType, $Priority)
			$true
		}

		$result = Set-CapaPackagePriority -CapaSDK $CapaSDK -PackageName 'Pkg' -PackageVersion 'v1' -PackageType 'Computer' -Priority 900

		$result | Should -Be $true
		$script:called[2] | Should -Be '1'
		$script:called[3] | Should -Be 900
	}
}
