BeforeAll {
	. $PSScriptRoot\Enable-CapaPackageSchedule.ps1
}

Describe 'Enable-CapaPackageSchedule' {
	It 'Calls SDK method and maps User to 2' {
		$script:called = $null
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member ScriptMethod EnablePackageSchedule {
			param($PackageName, $PackageVersion, $PackageType)
			$script:called = @($PackageName, $PackageVersion, $PackageType)
			$true
		}

		$result = Enable-CapaPackageSchedule -CapaSDK $CapaSDK -PackageName 'Pkg' -PackageVersion 'v1' -PackageType 'User'

		$result | Should -Be $true
		$script:called[2] | Should -Be '2'
	}
}
