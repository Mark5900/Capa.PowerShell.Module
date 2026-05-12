BeforeAll {
	. $PSScriptRoot\Get-CapaManagementServers.ps1
}

Describe 'Get-CapaManagementServers' {
	It 'Parses SDK response into objects' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member ScriptMethod GetManagementServers {
			@('MS1;\\srv\path;7.0;D:;srv;share;x;True;guid;12')
		}

		$result = Get-CapaManagementServers -CapaSDK $CapaSDK

		$result | Should -HaveCount 1
		$result[0].Name | Should -Be 'MS1'
		$result[0].ID | Should -Be '12'
	}
}
