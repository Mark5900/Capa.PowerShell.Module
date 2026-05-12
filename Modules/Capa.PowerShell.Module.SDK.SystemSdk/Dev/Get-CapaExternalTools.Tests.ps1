BeforeAll {
	. $PSScriptRoot\Get-CapaExternalTools.ps1
}

Describe 'Get-CapaExternalTools' {
	It 'Parses SDK response into objects' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member ScriptMethod GetExternalTools {
			@('1;Tool1;C:\\Tool.exe;/silent')
		}

		$result = Get-CapaExternalTools -CapaSDK $CapaSDK

		$result | Should -HaveCount 1
		$result[0].Name | Should -Be 'Tool1'
		$result[0].Arguments | Should -Be '/silent'
	}
}
