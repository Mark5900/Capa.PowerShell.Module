BeforeAll {
	. $PSScriptRoot\Rebuild-CapaKitFileOnManagementServer.ps1
}

Describe 'Rebuild-CapaKitFileOnManagementServer' {
	It 'Calls SDK method and maps Computer to 1' {
		$script:called = $null
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member ScriptMethod RebuildKitFileOnServer {
			param($PackageName, $PackageVersion, $PackageType, $ServerName)
			$script:called = @($PackageName, $PackageVersion, $PackageType, $ServerName)
			$true
		}

		$result = Rebuild-CapaKitFileOnManagementServer -CapaSDK $CapaSDK -PackageName 'Pkg' -PackageVersion 'v1' -PackageType 'Computer' -ServerName 'MS1'

		$result | Should -Be $true
		$script:called[2] | Should -Be '1'
	}
}
