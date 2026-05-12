BeforeAll {
	. $PSScriptRoot\Get-CapaOSInstallationTypes.ps1
}

Describe 'Get-CapaOSInstallationTypes' {
	It 'Parses SDK response into objects' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetOSInstallationTypes -Value {
			param($OSPointID)
			@('3;guid-3;Refresh')
		}

		$result = Get-CapaOSInstallationTypes -CapaSDK $CapaSDK -OSPointID 3

		$result | Should -HaveCount 1
		$result[0].ID | Should -Be '3'
		$result[0].GUID | Should -Be 'guid-3'
		$result[0].Type | Should -Be 'Refresh'
	}
}
