BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Set-CapaUnitName' {
	It 'Calls SDK SetUnitName and returns value' {
		$script:ReceivedArgs = $null

		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name SetUnitName -Value {
			param($UnitName, $UnitType, $Name)
			$script:ReceivedArgs = @($UnitName, $UnitType, $Name)
			$true
		}

		$Result = Set-CapaUnitName -CapaSDK $CapaSDK -UnitName 'PC001' -UnitType 'Computer' -Name 'PC001-RENAMED' -Confirm:$false

		$Result | Should -Be $true
		$script:ReceivedArgs[0] | Should -Be 'PC001'
		$script:ReceivedArgs[1] | Should -Be 'Computer'
		$script:ReceivedArgs[2] | Should -Be 'PC001-RENAMED'
	}

	It 'Does not call SDK when using WhatIf' {
		$script:CallCount = 0

		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name SetUnitName -Value {
			param($UnitName, $UnitType, $Name)
			$script:CallCount++
			$true
		}

		$Result = Set-CapaUnitName -CapaSDK $CapaSDK -UnitName 'PC001' -UnitType 'Computer' -Name 'PC001-RENAMED' -WhatIf -Confirm:$false

		$script:CallCount | Should -Be 0
		$Result | Should -BeNullOrEmpty
	}

	It 'Throws when CapaSDK does not implement SetUnitName' {
		$CapaSDK = [pscustomobject]@{}

		{ Set-CapaUnitName -CapaSDK $CapaSDK -UnitName 'PC001' -UnitType 'Computer' -Name 'PC001-RENAMED' -Confirm:$false } | Should -Throw 'CapaSDK does not contain method SetUnitName.'
	}

	It 'Validates UnitName is not empty' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name SetUnitName -Value {
			param($UnitName, $UnitType, $Name)
			$true
		}

		{ Set-CapaUnitName -CapaSDK $CapaSDK -UnitName '' -UnitType 'Computer' -Name 'PC001-RENAMED' -Confirm:$false } | Should -Throw
	}

	It 'Validates Name is not empty' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name SetUnitName -Value {
			param($UnitName, $UnitType, $Name)
			$true
		}

		{ Set-CapaUnitName -CapaSDK $CapaSDK -UnitName 'PC001' -UnitType 'Computer' -Name '' -Confirm:$false } | Should -Throw
	}

	It 'Validates UnitType values' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name SetUnitName -Value {
			param($UnitName, $UnitType, $Name)
			$true
		}

		{ Set-CapaUnitName -CapaSDK $CapaSDK -UnitName 'PC001' -UnitType 'Device' -Name 'PC001-RENAMED' -Confirm:$false } | Should -Throw
	}
}
