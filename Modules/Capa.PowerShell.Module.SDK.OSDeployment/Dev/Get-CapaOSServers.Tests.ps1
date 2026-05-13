BeforeAll {
	. $PSScriptRoot\Get-CapaOSServers.ps1
}

Describe 'Get-CapaOSServers' {
	It 'Parses SDK response into objects' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetOSServers -Value {
			param($OSPointID)
			@('5;Server node;10.0.0.10;server01;deploy$;\\server01\deploy$')
		}

		$result = Get-CapaOSServers -CapaSDK $CapaSDK -OSPointID 5

		$result | Should -HaveCount 1
		$result[0].ID | Should -Be '5'
		$result[0].IP | Should -Be '10.0.0.10'
		$result[0].Sharename | Should -Be 'deploy$'
	}
}
