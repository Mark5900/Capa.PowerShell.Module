BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Get-CapaWSUSGroupUnits' {
	It 'Returns parsed WSUS group unit rows' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetWSUSGroupUnits -Value {
			param($WSUSGroupName)
			@(
				'PC001;2026-01-01;2026-01-10;Installed;Description A;guid-a;Unused;101;Computer;uuid-a;False;HQ',
				'PC002;2026-01-02;2026-01-11;Pending;Description B;guid-b;Unused;102;Computer;uuid-b;True;Branch'
			)
		}

		$Result = Get-CapaWSUSGroupUnits -CapaSDK $CapaSDK -WSUSGroupName 'WSUS Group'

		$Result.Count | Should -Be 2
		$Result[0].Name | Should -Be 'PC001'
		$Result[0].ID | Should -Be '101'
		$Result[0].TypeName | Should -Be 'Computer'
		$Result[0].Location | Should -Be 'HQ'
		$Result[1].Name | Should -Be 'PC002'
		$Result[1].IsMobileDevice | Should -Be 'True'
	}

	It 'Passes WSUSGroupName to SDK method' {
		$script:ReceivedWSUSGroupName = $null

		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetWSUSGroupUnits -Value {
			param($WSUSGroupName)
			$script:ReceivedWSUSGroupName = $WSUSGroupName
			@('PC001;2026-01-01;2026-01-10;Installed;Description A;guid-a;Unused;101;Computer;uuid-a;False;HQ')
		}

		Get-CapaWSUSGroupUnits -CapaSDK $CapaSDK -WSUSGroupName 'My Group' | Out-Null

		$script:ReceivedWSUSGroupName | Should -Be 'My Group'
	}

	It 'Skips empty and malformed rows' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetWSUSGroupUnits -Value {
			param($WSUSGroupName)
			@(
				'',
				'PC-Invalid;Too;Few;Columns',
				'PC003;2026-01-03;2026-01-12;Installed;Description C;guid-c;Unused;103;Computer;uuid-c;False;Remote'
			)
		}

		$Result = Get-CapaWSUSGroupUnits -CapaSDK $CapaSDK -WSUSGroupName 'WSUS Group'

		$Result.Count | Should -Be 1
		$Result[0].Name | Should -Be 'PC003'
		$Result[0].ID | Should -Be '103'
	}

	It 'Returns empty array when SDK returns null' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetWSUSGroupUnits -Value {
			param($WSUSGroupName)
			$null
		}

		$Result = Get-CapaWSUSGroupUnits -CapaSDK $CapaSDK -WSUSGroupName 'WSUS Group'

		$Result | Should -BeNullOrEmpty
	}

	It 'Throws when CapaSDK does not implement GetWSUSGroupUnits' {
		$CapaSDK = [pscustomobject]@{}

		{ Get-CapaWSUSGroupUnits -CapaSDK $CapaSDK -WSUSGroupName 'WSUS Group' } | Should -Throw 'CapaSDK does not contain method GetWSUSGroupUnits.'
	}
}
