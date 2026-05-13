BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Get-CapaReinstallStatus' {
	It 'Calls SDK GetReinstallStatus and returns value' {
		$script:ReceivedArgs = $null

		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetReinstallStatus -Value {
			param($UnitName, $UnitType)
			$script:ReceivedArgs = @($UnitName, $UnitType)
			'True'
		}

		$Result = Get-CapaReinstallStatus -CapaSDK $CapaSDK -UnitName 'TestUser' -UnitType 'User'

		$Result | Should -Be 'True'
		$script:ReceivedArgs[0] | Should -Be 'TestUser'
		$script:ReceivedArgs[1] | Should -Be 'User'
	}

	It 'Throws when CapaSDK does not implement GetReinstallStatus' {
		$CapaSDK = [pscustomobject]@{}

		{ Get-CapaReinstallStatus -CapaSDK $CapaSDK -UnitName 'TestUser' -UnitType 'User' } | Should -Throw 'CapaSDK does not contain method GetReinstallStatus.'
	}

	It 'Validates UnitType values' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetReinstallStatus -Value {
			param($UnitName, $UnitType)
			'True'
		}

		{ Get-CapaReinstallStatus -CapaSDK $CapaSDK -UnitName 'TestUser' -UnitType 'Device' } | Should -Throw
	}

	It 'Validates UnitName is not empty' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name GetReinstallStatus -Value {
			param($UnitName, $UnitType)
			'True'
		}

		{ Get-CapaReinstallStatus -CapaSDK $CapaSDK -UnitName '' -UnitType 'User' } | Should -Throw
	}
}
