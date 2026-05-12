BeforeAll {
	. $PSScriptRoot\Get-CapaOSImages.ps1
}

Describe 'Get-CapaOSImages' {
	It 'Parses SDK response into objects' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetOSImages -Value {
			param($OSPointID)
			@('2;Windows 11;Corporate image;win11.wim;guid-2;img.wim;local.wim;Windows 11 Pro')
		}

		$result = Get-CapaOSImages -CapaSDK $CapaSDK -OSPointID 2

		$result | Should -HaveCount 1
		$result[0].ID | Should -Be '2'
		$result[0].Filename | Should -Be 'win11.wim'
		$result[0].OSName | Should -Be 'Windows 11 Pro'
	}
}
