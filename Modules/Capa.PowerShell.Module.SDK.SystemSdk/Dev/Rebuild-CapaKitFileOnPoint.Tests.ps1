BeforeAll {
	. $PSScriptRoot\Rebuild-CapaKitFileOnPoint.ps1
}

Describe 'Rebuild-CapaKitFileOnPoint' {
	It 'Calls SDK method and maps User to 2' {
		$script:called = $null
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member ScriptMethod RebuildKitFileOnPoint {
			param($PackageName, $PackageVersion, $PackageType, $PointID)
			$script:called = @($PackageName, $PackageVersion, $PackageType, $PointID)
			$true
		}

		$result = Rebuild-CapaKitFileOnPoint -CapaSDK $CapaSDK -PackageName 'Pkg' -PackageVersion 'v1' -PackageType 'User' -PointID 1

		$result | Should -Be $true
		$script:called[2] | Should -Be '2'
	}
}
