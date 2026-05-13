BeforeAll {
	. $PSScriptRoot\Get-CapaOSPoints.ps1
}

Describe 'Get-CapaOSPoints' {
	It 'Parses SDK response into objects' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetOSPoints -Value {
			@('4;Main Point;Primary OSD point;guid-4;boot.cfg;driver.map;gui.xml;common;drivers;images;osd;media;scripts;winpe;7.2;server01;share01;\\server01\share01')
		}

		$result = Get-CapaOSPoints -CapaSDK $CapaSDK

		$result | Should -HaveCount 1
		$result[0].ID | Should -Be '4'
		$result[0].Name | Should -Be 'Main Point'
		$result[0].Servername | Should -Be 'server01'
	}
}
