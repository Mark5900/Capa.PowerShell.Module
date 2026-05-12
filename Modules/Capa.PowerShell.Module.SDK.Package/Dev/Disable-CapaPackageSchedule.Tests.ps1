BeforeAll {
	. $PSScriptRoot\Disable-CapaPackageSchedule.ps1
}

Describe 'Disable-CapaPackageSchedule' {
	It 'Calls SDK method with expected values' {
		$script:called = $null
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member ScriptMethod DisablePackageSchedule {
			param($PackageName, $PackageVersion, $PackageType)
			$script:called = @($PackageName, $PackageVersion, $PackageType)
			$true
		}

		$result = Disable-CapaPackageSchedule -CapaSDK $CapaSDK -PackageName 'Pkg' -PackageVersion 'v1' -PackageType 'Computer'

		$result | Should -Be $true
		$script:called[0] | Should -Be 'Pkg'
	}
}
