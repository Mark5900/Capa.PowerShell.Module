BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Get-CapaUsers' {
	It 'Returns parsed users from SDK response' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetUsers -Value {
			@(
				'user1;2026-01-01;2026-01-02;Active;Desc1;guid-1;unused;101;User;uuid-1;HQ;User One;u1@contoso.com;u1b@contoso.com;u1c@contoso.com',
				'user2;2026-01-03;2026-01-04;Active;Desc2;guid-2;unused;102;User;uuid-2;Branch;User Two;u2@contoso.com;u2b@contoso.com;u2c@contoso.com'
			)
		}

		$Result = Get-CapaUsers -CapaSDK $CapaSDK

		$Result.Count | Should -Be 2
		$Result[0].Name | Should -Be 'user1'
		$Result[0].ID | Should -Be '101'
		$Result[0].EmailPrimary | Should -Be 'u1@contoso.com'
		$Result[1].Name | Should -Be 'user2'
		$Result[1].UUID | Should -Be 'uuid-2'
	}

	It 'Skips empty and malformed rows' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetUsers -Value {
			@(
				'',
				'user-invalid;too;few;columns',
				'user3;2026-01-05;2026-01-06;Active;Desc3;guid-3;unused;103;User;uuid-3;Remote;User Three;u3@contoso.com;u3b@contoso.com;u3c@contoso.com'
			)
		}

		$Result = Get-CapaUsers -CapaSDK $CapaSDK

		$Result.Count | Should -Be 1
		$Result[0].Name | Should -Be 'user3'
		$Result[0].ID | Should -Be '103'
	}

	It 'Returns empty array when SDK returns null' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetUsers -Value {
			$null
		}

		$Result = Get-CapaUsers -CapaSDK $CapaSDK

		$Result | Should -BeNullOrEmpty
	}

	It 'Throws when CapaSDK does not implement GetUsers' {
		$CapaSDK = [pscustomobject]@{}

		{ Get-CapaUsers -CapaSDK $CapaSDK } | Should -Throw 'CapaSDK does not contain method GetUsers.'
	}
}
