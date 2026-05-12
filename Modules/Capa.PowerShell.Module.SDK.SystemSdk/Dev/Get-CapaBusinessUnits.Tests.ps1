BeforeAll {
	. $PSScriptRoot\Get-CapaBusinessUnits.ps1
}

Describe 'Get-CapaBusinessUnits' {
	It 'Parses SDK response into objects' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member ScriptMethod GetBusinessUnits {
			@('BU1;guid-1;10')
		}

		$result = Get-CapaBusinessUnits -CapaSDK $CapaSDK

		$result | Should -HaveCount 1
		$result[0].Name | Should -Be 'BU1'
		$result[0].Id | Should -Be '10'
	}
}
