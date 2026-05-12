BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Get-CapaVppPrograms' {
	It 'Parses SDK response into program objects' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetVppPrograms -Value {
			return @('1;Program 1;Org A;org@example.com;2026-12-31;guid;x;Desc A')
		}

		$Result = Get-CapaVppPrograms -CapaSDK $CapaSDK

		$Result.Count | Should -Be 1
		$Result[0].ID | Should -Be '1'
		$Result[0].Name | Should -Be 'Program 1'
		$Result[0].Description | Should -Be 'Desc A'
	}

	It 'Skips empty and malformed rows' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetVppPrograms -Value {
			return @('', 'too;short', '2;Program 2;Org B;orgb@example.com;2027-01-01;guid2;x;Desc B')
		}

		$Result = Get-CapaVppPrograms -CapaSDK $CapaSDK

		$Result.Count | Should -Be 1
		$Result[0].Name | Should -Be 'Program 2'
	}

	It 'Returns empty array when SDK returns null' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetVppPrograms -Value {
			return $null
		}

		$Result = Get-CapaVppPrograms -CapaSDK $CapaSDK
		$Result | Should -BeNullOrEmpty
	}

	It 'Throws when CapaSDK does not implement GetVppPrograms' {
		{ Get-CapaVppPrograms -CapaSDK ([pscustomobject]@{}) } | Should -Throw
	}
}
