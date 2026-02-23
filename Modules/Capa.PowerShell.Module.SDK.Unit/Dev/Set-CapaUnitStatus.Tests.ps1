BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Set-CapaUnitStatus' {
	It 'Calls SDK SetUnitStatus and returns value' {
		$script:ReceivedArgs = $null

		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name SetUnitStatus -Value {
			param($UnitName, $Status)
			$script:ReceivedArgs = @($UnitName, $Status)
			$true
		}

		$Result = Set-CapaUnitStatus -CapaSDK $CapaSDK -UnitName 'TestComputer' -Status 'Active' -Confirm:$false

		$Result | Should -Be $true
		$script:ReceivedArgs[0] | Should -Be 'TestComputer'
		$script:ReceivedArgs[1] | Should -Be 'Active'
	}

	It 'Does not call SDK when using WhatIf' {
		$script:CallCount = 0

		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name SetUnitStatus -Value {
			param($UnitName, $Status)
			$script:CallCount++
			$true
		}

		$Result = Set-CapaUnitStatus -CapaSDK $CapaSDK -UnitName 'TestComputer' -Status 'Inactive' -WhatIf -Confirm:$false

		$script:CallCount | Should -Be 0
		$Result | Should -BeNullOrEmpty
	}

	It 'Throws when CapaSDK does not implement SetUnitStatus' {
		$CapaSDK = [pscustomobject]@{}

		{ Set-CapaUnitStatus -CapaSDK $CapaSDK -UnitName 'TestComputer' -Status 'Active' -Confirm:$false } | Should -Throw 'CapaSDK does not contain method SetUnitStatus.'
	}

	It 'Validates UnitName is not empty' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name SetUnitStatus -Value {
			param($UnitName, $Status)
			$true
		}

		{ Set-CapaUnitStatus -CapaSDK $CapaSDK -UnitName '' -Status 'Active' -Confirm:$false } | Should -Throw
	}

	It 'Validates Status values' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name SetUnitStatus -Value {
			param($UnitName, $Status)
			$true
		}

		{ Set-CapaUnitStatus -CapaSDK $CapaSDK -UnitName 'TestComputer' -Status 'Invalid' -Confirm:$false } | Should -Throw
	}
}
