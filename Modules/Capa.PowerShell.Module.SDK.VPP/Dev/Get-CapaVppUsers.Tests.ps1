BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Get-CapaVppUsers' {
	It 'Calls GetVppUsersAll when VppProgramID is not provided' {
		$script:CalledAll = $false
		$script:CalledSingle = $false
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetVppUsersAll -Value {
			$script:CalledAll = $true
			return @('1;Active;2026-01-01;u1;client1;User One;x;Desc;u1@example.com;hash;url;code;acc;guid')
		}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetVppUsers -Value {
			param($VppProgramID)
			$script:CalledSingle = $true
			return @()
		}

		$Result = Get-CapaVppUsers -CapaSDK $CapaSDK

		$script:CalledAll | Should -BeTrue
		$script:CalledSingle | Should -BeFalse
		$Result.Count | Should -Be 1
		$Result[0].Name | Should -Be 'User One'
	}

	It 'Calls GetVppUsers when VppProgramID is provided' {
		$script:ProgramIdReceived = $null
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetVppUsersAll -Value { return @() }
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetVppUsers -Value {
			param($VppProgramID)
			$script:ProgramIdReceived = $VppProgramID
			return @('2;Active;2026-01-02;u2;client2;User Two;x;Desc2;u2@example.com;hash2;url2;code2;acc2;guid2')
		}

		$Result = Get-CapaVppUsers -CapaSDK $CapaSDK -VppProgramID 9

		$script:ProgramIdReceived | Should -Be 9
		$Result.Count | Should -Be 1
		$Result[0].ID | Should -Be '2'
	}

	It 'Skips empty and malformed rows' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetVppUsersAll -Value {
			return @('', 'too;short', '3;Active;2026-01-03;u3;client3;User Three;x;Desc3;u3@example.com;hash3;url3;code3;acc3;guid3')
		}

		$Result = Get-CapaVppUsers -CapaSDK $CapaSDK

		$Result.Count | Should -Be 1
		$Result[0].Name | Should -Be 'User Three'
	}

	It 'Returns empty array when SDK returns null' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetVppUsersAll -Value { return $null }

		$Result = Get-CapaVppUsers -CapaSDK $CapaSDK
		$Result | Should -BeNullOrEmpty
	}

	It 'Throws when GetVppUsersAll is missing and VppProgramID is not provided' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetVppUsers -Value { param($VppProgramID) @() }

		{ Get-CapaVppUsers -CapaSDK $CapaSDK } | Should -Throw
	}

	It 'Throws when GetVppUsers is missing and VppProgramID is provided' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetVppUsersAll -Value { @() }

		{ Get-CapaVppUsers -CapaSDK $CapaSDK -VppProgramID 1 } | Should -Throw
	}

	It 'Validates VppProgramID range' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetVppUsersAll -Value { @() }
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetVppUsers -Value { param($VppProgramID) @() }

		{ Get-CapaVppUsers -CapaSDK $CapaSDK -VppProgramID 0 } | Should -Throw
	}
}
