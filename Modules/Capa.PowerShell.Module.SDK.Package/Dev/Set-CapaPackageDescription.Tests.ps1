BeforeAll {
	. $PSScriptRoot\Set-CapaPackageDescription.ps1
}

Describe 'Set-CapaPackageDescription' {
	It 'Calls SDK method and maps User to 2' {
		$script:called = $null
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member ScriptMethod SetPackageDescription {
			param($PackageName, $PackageVersion, $PackageType, $Description)
			$script:called = @($PackageName, $PackageVersion, $PackageType, $Description)
			$true
		}

		$result = Set-CapaPackageDescription -CapaSDK $CapaSDK -PackageName 'Pkg' -PackageVersion 'v1' -PackageType 'User' -Description 'Desc'

		$result | Should -Be $true
		$script:called[2] | Should -Be '2'
	}
}
