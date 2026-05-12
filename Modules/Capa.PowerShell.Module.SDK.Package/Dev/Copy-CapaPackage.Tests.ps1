BeforeAll {
	. $PSScriptRoot\Copy-CapaPackage.ps1
}

Describe 'Copy-CapaPackage' {
	It 'Calls SDK method and maps User to 2' {
		$script:called = $null
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member ScriptMethod CopyPackage {
			param($PackageName, $PackageVersion, $PackageType, $NewName, $NewVersion)
			$script:called = @($PackageName, $PackageVersion, $PackageType, $NewName, $NewVersion)
			$true
		}

		$result = Copy-CapaPackage -CapaSDK $CapaSDK -PackageName 'Pkg' -PackageVersion 'v1' -PackageType 'User' -NewName 'Pkg2' -NewVersion 'v2'

		$result | Should -Be $true
		$script:called[2] | Should -Be '2'
	}
}
