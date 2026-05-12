BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Get-CapaUsersLinkedToVppUser' {
	It 'Parses SDK response into user objects' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetUsersLinkedToVppUser -Value {
			param($VppUserID)
			return @('User01;2026-01-01;2026-01-02;OK;Desc;guid;x;51;User;uuid-u1;Root\\Users;Test User;a@b.c;b@c.d;c@d.e')
		}

		$Result = Get-CapaUsersLinkedToVppUser -CapaSDK $CapaSDK -VppUserID 1

		$Result.Count | Should -Be 1
		$Result[0].Name | Should -Be 'User01'
		$Result[0].FullName | Should -Be 'Test User'
		$Result[0].EmailPrimary | Should -Be 'a@b.c'
	}

	It 'Skips empty and malformed rows' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetUsersLinkedToVppUser -Value {
			param($VppUserID)
			return @('', 'too;short', 'User02;2026-01-01;2026-01-02;OK;Desc;guid;x;52;User;uuid-u2;Root\\Users;Second User;a2@b.c;b2@c.d;c2@d.e')
		}

		$Result = Get-CapaUsersLinkedToVppUser -CapaSDK $CapaSDK -VppUserID 2

		$Result.Count | Should -Be 1
		$Result[0].Name | Should -Be 'User02'
	}

	It 'Returns empty array when SDK returns null' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetUsersLinkedToVppUser -Value {
			param($VppUserID)
			return $null
		}

		$Result = Get-CapaUsersLinkedToVppUser -CapaSDK $CapaSDK -VppUserID 3
		$Result | Should -BeNullOrEmpty
	}

	It 'Throws when CapaSDK does not implement GetUsersLinkedToVppUser' {
		{ Get-CapaUsersLinkedToVppUser -CapaSDK ([pscustomobject]@{}) -VppUserID 1 } | Should -Throw
	}

	It 'Validates VppUserID range' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetUsersLinkedToVppUser -Value { param($VppUserID) @() }

		{ Get-CapaUsersLinkedToVppUser -CapaSDK $CapaSDK -VppUserID 0 } | Should -Throw
	}
}
