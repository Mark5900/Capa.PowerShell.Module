BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Get-CapaWSUSGroups' {
	It 'Returns parsed WSUS groups from SDK response' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetWSUSGroups -Value {
			param($PointID)
			@(
				'1;Workstations;guid-1',
				'2;Servers;guid-2'
			)
		}

		$Result = Get-CapaWSUSGroups -CapaSDK $CapaSDK -PointID 1

		$Result.Count | Should -Be 2
		$Result[0].ID | Should -Be '1'
		$Result[0].Name | Should -Be 'Workstations'
		$Result[0].GUID | Should -Be 'guid-1'
		$Result[1].ID | Should -Be '2'
		$Result[1].Name | Should -Be 'Servers'
		$Result[1].GUID | Should -Be 'guid-2'
	}

	It 'Skips empty and malformed rows' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetWSUSGroups -Value {
			param($PointID)
			@(
				'',
				'OnlyOneField',
				'3;Valid Group;guid-3'
			)
		}

		$Result = Get-CapaWSUSGroups -CapaSDK $CapaSDK -PointID 1

		$Result.Count | Should -Be 1
		$Result[0].ID | Should -Be '3'
		$Result[0].Name | Should -Be 'Valid Group'
		$Result[0].GUID | Should -Be 'guid-3'
	}

	It 'Returns empty array when SDK returns null' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetWSUSGroups -Value {
			param($PointID)
			$null
		}

		$Result = Get-CapaWSUSGroups -CapaSDK $CapaSDK -PointID 1

		$Result | Should -BeNullOrEmpty
	}

	It 'Throws when CapaSDK does not implement GetWSUSGroups' {
		$CapaSDK = [pscustomobject]@{}

		{ Get-CapaWSUSGroups -CapaSDK $CapaSDK -PointID 1 } | Should -Throw 'CapaSDK does not contain method GetWSUSGroups.'
	}
}
