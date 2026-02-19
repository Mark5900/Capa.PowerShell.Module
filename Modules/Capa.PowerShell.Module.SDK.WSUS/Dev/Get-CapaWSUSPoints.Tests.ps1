BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Get-CapaWSUSPoints' {
	It 'Returns parsed WSUS points from SDK response' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetWSUSPoints -Value {
			@(
				'1;WSUS-Point-1;guid-1',
				'2;WSUS-Point-2;guid-2'
			)
		}

		$Result = Get-CapaWSUSPoints -CapaSDK $CapaSDK

		$Result.Count | Should -Be 2
		$Result[0].ID | Should -Be '1'
		$Result[0].Name | Should -Be 'WSUS-Point-1'
		$Result[0].GUID | Should -Be 'guid-1'
		$Result[1].ID | Should -Be '2'
		$Result[1].Name | Should -Be 'WSUS-Point-2'
		$Result[1].GUID | Should -Be 'guid-2'
	}

	It 'Skips empty and malformed rows' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetWSUSPoints -Value {
			@(
				'',
				'OnlyOneField',
				'3;WSUS-Point-3;guid-3'
			)
		}

		$Result = Get-CapaWSUSPoints -CapaSDK $CapaSDK

		$Result.Count | Should -Be 1
		$Result[0].ID | Should -Be '3'
		$Result[0].Name | Should -Be 'WSUS-Point-3'
		$Result[0].GUID | Should -Be 'guid-3'
	}

	It 'Returns empty array when SDK returns null' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetWSUSPoints -Value {
			$null
		}

		$Result = Get-CapaWSUSPoints -CapaSDK $CapaSDK

		$Result | Should -BeNullOrEmpty
	}

	It 'Throws when CapaSDK does not implement GetWSUSPoints' {
		$CapaSDK = [pscustomobject]@{}

		{ Get-CapaWSUSPoints -CapaSDK $CapaSDK } | Should -Throw 'CapaSDK does not contain method GetWSUSPoints.'
	}
}
