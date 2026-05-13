BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Invite-CapaUnitToVppProgram' {
	It 'Calls SDK InviteUnitToVppProgram and returns value' {
		$script:CallCount = 0
		$script:Args = $null
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name InviteUnitToVppProgram -Value {
			param($VppProgramID, $UnitID, $UserFullName, $UserEmailName, $UserDescription)
			$script:CallCount++
			$script:Args = @($VppProgramID, $UnitID, $UserFullName, $UserEmailName, $UserDescription)
			return $true
		}

		$Result = Invite-CapaUnitToVppProgram -CapaSDK $CapaSDK -VppProgramID 1 -UnitID 10 -UserFullName 'Test User' -UserEmailName 'test@example.com' -UserDescription 'Test invite'

		$Result | Should -BeTrue
		$script:CallCount | Should -Be 1
		$script:Args[0] | Should -Be 1
		$script:Args[1] | Should -Be 10
	}

	It 'Does not call SDK when using WhatIf' {
		$script:CallCount = 0
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name InviteUnitToVppProgram -Value {
			param($VppProgramID, $UnitID, $UserFullName, $UserEmailName, $UserDescription)
			$script:CallCount++
			return $true
		}

		$Result = Invite-CapaUnitToVppProgram -CapaSDK $CapaSDK -VppProgramID 1 -UnitID 10 -UserFullName 'Test User' -UserEmailName 'test@example.com' -UserDescription 'Test invite' -WhatIf

		$Result | Should -BeFalse
		$script:CallCount | Should -Be 0
	}

	It 'Throws when CapaSDK does not implement InviteUnitToVppProgram' {
		{ Invite-CapaUnitToVppProgram -CapaSDK ([pscustomobject]@{}) -VppProgramID 1 -UnitID 10 -UserFullName 'Test User' -UserEmailName 'test@example.com' -UserDescription 'Test invite' } | Should -Throw
	}

	It 'Validates VppProgramID range' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name InviteUnitToVppProgram -Value { param($a, $b, $c, $d, $e) $true }

		{ Invite-CapaUnitToVppProgram -CapaSDK $CapaSDK -VppProgramID 0 -UnitID 10 -UserFullName 'Test User' -UserEmailName 'test@example.com' -UserDescription 'Test invite' } | Should -Throw
	}

	It 'Validates UnitID range' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name InviteUnitToVppProgram -Value { param($a, $b, $c, $d, $e) $true }

		{ Invite-CapaUnitToVppProgram -CapaSDK $CapaSDK -VppProgramID 1 -UnitID 0 -UserFullName 'Test User' -UserEmailName 'test@example.com' -UserDescription 'Test invite' } | Should -Throw
	}

	It 'Validates UserFullName is not empty' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name InviteUnitToVppProgram -Value { param($a, $b, $c, $d, $e) $true }

		{ Invite-CapaUnitToVppProgram -CapaSDK $CapaSDK -VppProgramID 1 -UnitID 10 -UserFullName '' -UserEmailName 'test@example.com' -UserDescription 'Test invite' } | Should -Throw
	}

	It 'Validates UserEmailName is not empty' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name InviteUnitToVppProgram -Value { param($a, $b, $c, $d, $e) $true }

		{ Invite-CapaUnitToVppProgram -CapaSDK $CapaSDK -VppProgramID 1 -UnitID 10 -UserFullName 'Test User' -UserEmailName '' -UserDescription 'Test invite' } | Should -Throw
	}

	It 'Validates UserDescription is not empty' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name InviteUnitToVppProgram -Value { param($a, $b, $c, $d, $e) $true }

		{ Invite-CapaUnitToVppProgram -CapaSDK $CapaSDK -VppProgramID 1 -UnitID 10 -UserFullName 'Test User' -UserEmailName 'test@example.com' -UserDescription '' } | Should -Throw
	}
}
