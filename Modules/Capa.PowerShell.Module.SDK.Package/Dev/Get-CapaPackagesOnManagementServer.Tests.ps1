BeforeAll {
	. $PSScriptRoot\Get-CapaPackagesOnManagementServer.ps1
}

Describe 'Get-CapaPackagesOnManagementServer' {
	It 'Calls correct SDK method and parses response' {
		$script:called = $null
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member ScriptMethod GetPackagesOnManagementServer {
			param($ServerName, $PackageType)
			$script:called = @($ServerName, $PackageType)
			@('Pkg;v1;Computer;Display;False;0;Desc;guid;1;False;0;False;0;500;False')
		}

		$result = Get-CapaPackagesOnManagementServer -CapaSDK $CapaSDK -ServerName 'Srv1' -PackageType 'Computer'

		$result | Should -HaveCount 1
		$result[0].Description | Should -Be 'Desc'
		$script:called[0] | Should -Be 'Srv1'
	}
}
