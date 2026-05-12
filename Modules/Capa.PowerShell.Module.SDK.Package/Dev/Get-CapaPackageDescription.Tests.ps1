BeforeAll {
	. $PSScriptRoot\Get-CapaPackageDescription.ps1
}

Describe 'Get-CapaPackageDescription' {
	It 'Calls SDK method and maps Computer to 1' {
		$script:called = $null
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member ScriptMethod GetPackageDescription {
			param($PackageName, $PackageVersion, $PackageType)
			$script:called = @($PackageName, $PackageVersion, $PackageType)
			'Description'
		}

		$result = Get-CapaPackageDescription -CapaSDK $CapaSDK -PackageName 'Pkg' -PackageVersion 'v1' -PackageType 'Computer'

		$result | Should -Be 'Description'
		$script:called[2] | Should -Be '1'
	}
}
