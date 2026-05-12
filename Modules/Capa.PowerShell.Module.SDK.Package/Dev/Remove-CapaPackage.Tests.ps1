BeforeAll {
	. $PSScriptRoot\Remove-CapaPackage.ps1
}

Describe 'Remove-CapaPackage' {
	It 'Calls DeletePackage when BusinessUnitName is not provided' {
		$script:deleteCalled = $false
		$script:removeBuCalled = $false
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member ScriptMethod DeletePackage {
			param($PackageName, $PackageVersion, $PackageType, $Force)
			$script:deleteCalled = $true
			$true
		}
		$CapaSDK | Add-Member ScriptMethod RemovePackageFromBusinessUnit {
			param($PackageName, $PackageVersion, $PackageType, $BusinessUnitName)
			$script:removeBuCalled = $true
			$true
		}

		$result = Remove-CapaPackage -CapaSDK $CapaSDK -PackageName 'Pkg' -PackageVersion 'v1' -PackageType 'Computer'

		$result | Should -Be $true
		$script:deleteCalled | Should -Be $true
		$script:removeBuCalled | Should -Be $false
	}
}
