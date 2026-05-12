BeforeAll {
	. $PSScriptRoot\Add-CapaPackageToManagementServer.ps1
}

Describe 'Add-CapaPackageToManagementServer' {
	It 'Calls SDK method and maps Computer to 1' {
		$script:called = $null
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member ScriptMethod AddPackageToManagementServer {
			param($PackageName, $PackageVersion, $PackageType, $ServerName)
			$script:called = @($PackageName, $PackageVersion, $PackageType, $ServerName)
			$true
		}

		$result = Add-CapaPackageToManagementServer -CapaSDK $CapaSDK -PackageName 'Pkg' -PackageVersion 'v1' -PackageType 'Computer' -ServerName 'Srv1'

		$result | Should -Be $true
		$script:called[2] | Should -Be '1'
	}
}
