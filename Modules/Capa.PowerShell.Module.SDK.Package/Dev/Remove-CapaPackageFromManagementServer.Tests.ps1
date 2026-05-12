BeforeAll {
	. $PSScriptRoot\Remove-CapaPackageFromManagementServer.ps1
}

Describe 'Remove-CapaPackageFromManagementServer' {
	It 'Calls SDK method and maps Computer to 1' {
		$script:called = $null
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member ScriptMethod RemovePackageFromManagementServer {
			param($PackageName, $PackageVersion, $PackageType, $ServerName)
			$script:called = @($PackageName, $PackageVersion, $PackageType, $ServerName)
			$true
		}

		$result = Remove-CapaPackageFromManagementServer -CapaSDK $CapaSDK -PackageName 'Pkg' -PackageVersion 'v1' -PackageType 'Computer' -ServerName 'Srv1'

		$result | Should -Be $true
		$script:called[2] | Should -Be '1'
	}
}
