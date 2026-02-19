BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Restart-CapaAgent' {
	It 'Calls SDK RestartAgent and maps Computer to 1' {
		$script:ReceivedArgs = $null

		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name RestartAgent -Value {
			param($UnitName, $UnitType)
			$script:ReceivedArgs = @($UnitName, $UnitType)
			$true
		}

		$Result = Restart-CapaAgent -CapaSDK $CapaSDK -UnitName 'TestComputer' -UnitType 'Computer' -Confirm:$false

		$Result | Should -Be $true
		$script:ReceivedArgs[0] | Should -Be 'TestComputer'
		$script:ReceivedArgs[1] | Should -Be '1'
	}

	It 'Calls SDK RestartAgent and maps User to 2' {
		$script:ReceivedArgs = $null

		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name RestartAgent -Value {
			param($UnitName, $UnitType)
			$script:ReceivedArgs = @($UnitName, $UnitType)
			$true
		}

		$Result = Restart-CapaAgent -CapaSDK $CapaSDK -UnitName 'TestUser' -UnitType 'User' -Confirm:$false

		$Result | Should -Be $true
		$script:ReceivedArgs[1] | Should -Be '2'
	}

	It 'Passes numeric UnitType through unchanged' {
		$script:ReceivedArgs = $null

		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name RestartAgent -Value {
			param($UnitName, $UnitType)
			$script:ReceivedArgs = @($UnitName, $UnitType)
			$true
		}

		$Result = Restart-CapaAgent -CapaSDK $CapaSDK -UnitName 'TestComputer' -UnitType '1' -Confirm:$false

		$Result | Should -Be $true
		$script:ReceivedArgs[1] | Should -Be '1'
	}

	It 'Does not call SDK when using WhatIf' {
		$script:CallCount = 0

		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name RestartAgent -Value {
			param($UnitName, $UnitType)
			$script:CallCount++
			$true
		}

		$Result = Restart-CapaAgent -CapaSDK $CapaSDK -UnitName 'TestComputer' -UnitType 'Computer' -WhatIf -Confirm:$false

		$script:CallCount | Should -Be 0
		$Result | Should -BeNullOrEmpty
	}

	It 'Throws when CapaSDK does not implement RestartAgent' {
		$CapaSDK = [pscustomobject]@{}

		{ Restart-CapaAgent -CapaSDK $CapaSDK -UnitName 'TestComputer' -UnitType 'Computer' -Confirm:$false } | Should -Throw 'CapaSDK does not contain method RestartAgent.'
	}
}
