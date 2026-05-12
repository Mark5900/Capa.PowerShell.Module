BeforeAll {
	. $PSScriptRoot\Get-CapaOSDiskConfigration.ps1
}

Describe 'Get-CapaOSDiskConfigration' {
	It 'Parses SDK response into objects' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetOSDiskConfiguration -Value {
			param($OSPointID)
			@('1;Standard;Default disk;guid-1;0;1;1')
		}

		$result = Get-CapaOSDiskConfigration -CapaSDK $CapaSDK -OSPointID 1

		$result | Should -HaveCount 1
		$result[0].ID | Should -Be '1'
		$result[0].Name | Should -Be 'Standard'
		$result[0].LeaveDisk | Should -Be '1'
	}
}
