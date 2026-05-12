BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Set-CapaPrimaryUser' {
	It 'Calls SDK SetPrimaryUser and returns value' {
		$script:ReceivedArgs = $null

		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name SetPrimaryUser -Value {
			param($Uuid, $UserIdentifier)
			$script:ReceivedArgs = @($Uuid, $UserIdentifier)
			$true
		}

		$Result = Set-CapaPrimaryUser -CapaSDK $CapaSDK -Uuid 'B16BAC7B-2975-431C-A380-B702B1A83AF4' -UserIdentifier 'testuser' -Confirm:$false

		$Result | Should -Be $true
		$script:ReceivedArgs[0] | Should -Be 'B16BAC7B-2975-431C-A380-B702B1A83AF4'
		$script:ReceivedArgs[1] | Should -Be 'testuser'
	}

	It 'Does not call SDK when using WhatIf' {
		$script:CallCount = 0

		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name SetPrimaryUser -Value {
			param($Uuid, $UserIdentifier)
			$script:CallCount++
			$true
		}

		$Result = Set-CapaPrimaryUser -CapaSDK $CapaSDK -Uuid 'B16BAC7B-2975-431C-A380-B702B1A83AF4' -UserIdentifier 'testuser' -WhatIf -Confirm:$false

		$script:CallCount | Should -Be 0
		$Result | Should -BeNullOrEmpty
	}

	It 'Throws when CapaSDK does not implement SetPrimaryUser' {
		$CapaSDK = [pscustomobject]@{}

		{ Set-CapaPrimaryUser -CapaSDK $CapaSDK -Uuid 'B16BAC7B-2975-431C-A380-B702B1A83AF4' -UserIdentifier 'testuser' -Confirm:$false } | Should -Throw 'CapaSDK does not contain method SetPrimaryUser.'
	}

	It 'Validates Uuid format' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name SetPrimaryUser -Value {
			param($Uuid, $UserIdentifier)
			$true
		}

		{ Set-CapaPrimaryUser -CapaSDK $CapaSDK -Uuid 'not-a-guid' -UserIdentifier 'testuser' -Confirm:$false } | Should -Throw
	}

	It 'Validates UserIdentifier is not empty' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name SetPrimaryUser -Value {
			param($Uuid, $UserIdentifier)
			$true
		}

		{ Set-CapaPrimaryUser -CapaSDK $CapaSDK -Uuid 'B16BAC7B-2975-431C-A380-B702B1A83AF4' -UserIdentifier '' -Confirm:$false } | Should -Throw
	}
}
