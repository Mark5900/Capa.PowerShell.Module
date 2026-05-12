BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Set-CapaWakeOnLAN' {
	It 'Calls SDK SetWakeOnLAN and returns value' {
		$script:ReceivedArgs = $null

		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name SetWakeOnLAN -Value {
			param($UnitName, $WakeOnLanValue)
			$script:ReceivedArgs = @($UnitName, $WakeOnLanValue)
			$true
		}

		$Result = Set-CapaWakeOnLAN -CapaSDK $CapaSDK -UnitName 'TestComputer' -Confirm:$false

		$Result | Should -Be $true
		$script:ReceivedArgs[0] | Should -Be 'TestComputer'
		$script:ReceivedArgs[1] | Should -Be '1'
	}

	It 'Does not call SDK when using WhatIf' {
		$script:CallCount = 0

		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name SetWakeOnLAN -Value {
			param($UnitName, $WakeOnLanValue)
			$script:CallCount++
			$true
		}

		$Result = Set-CapaWakeOnLAN -CapaSDK $CapaSDK -UnitName 'TestComputer' -WhatIf -Confirm:$false

		$script:CallCount | Should -Be 0
		$Result | Should -BeNullOrEmpty
	}

	It 'Throws when CapaSDK does not implement SetWakeOnLAN' {
		$CapaSDK = [pscustomobject]@{}

		{ Set-CapaWakeOnLAN -CapaSDK $CapaSDK -UnitName 'TestComputer' -Confirm:$false } | Should -Throw 'CapaSDK does not contain method SetWakeOnLAN.'
	}

	It 'Validates UnitName is not empty' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name SetWakeOnLAN -Value {
			param($UnitName, $WakeOnLanValue)
			$true
		}

		{ Set-CapaWakeOnLAN -CapaSDK $CapaSDK -UnitName '' -Confirm:$false } | Should -Throw
	}
}
