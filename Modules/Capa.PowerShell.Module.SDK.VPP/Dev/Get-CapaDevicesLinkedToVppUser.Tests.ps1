BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Get-CapaDevicesLinkedToVppUser' {
	It 'Parses SDK response into device objects' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetDevicesLinkedToVppUser -Value {
			param($VppUserID)
			return @('PC01;2026-01-01;2026-01-02;OK;Desc;guid;x;42;Computer;uuid-1;false;Root\\Computers')
		}

		$Result = Get-CapaDevicesLinkedToVppUser -CapaSDK $CapaSDK -vppUserID 1

		$Result.Count | Should -Be 1
		$Result[0].Name | Should -Be 'PC01'
		$Result[0].ID | Should -Be '42'
		$Result[0].TypeName | Should -Be 'Computer'
		$Result[0].Location | Should -Be 'Root\\Computers'
	}

	It 'Skips empty and malformed rows' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetDevicesLinkedToVppUser -Value {
			param($VppUserID)
			return @('', 'too;short', 'PC02;2026-01-01;2026-01-02;OK;Desc;guid;x;43;Computer;uuid-2;false;Root\\Devices')
		}

		$Result = Get-CapaDevicesLinkedToVppUser -CapaSDK $CapaSDK -vppUserID 2

		$Result.Count | Should -Be 1
		$Result[0].Name | Should -Be 'PC02'
	}

	It 'Returns empty array when SDK returns null' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetDevicesLinkedToVppUser -Value {
			param($VppUserID)
			return $null
		}

		$Result = Get-CapaDevicesLinkedToVppUser -CapaSDK $CapaSDK -vppUserID 3
		$Result | Should -BeNullOrEmpty
	}

	It 'Throws when CapaSDK does not implement GetDevicesLinkedToVppUser' {
		{ Get-CapaDevicesLinkedToVppUser -CapaSDK ([pscustomobject]@{}) -vppUserID 1 } | Should -Throw
	}

	It 'Validates vppUserID range' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetDevicesLinkedToVppUser -Value { param($VppUserID) @() }

		{ Get-CapaDevicesLinkedToVppUser -CapaSDK $CapaSDK -vppUserID 0 } | Should -Throw
	}
}
