BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Move-CapaDeviceToPoint' {
	It 'Calls SDK MoveDeviceToPoint and returns value' {
		$script:ReceivedArgs = $null

		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name MoveDeviceToPoint -Value {
			param($DeviceUUID, $PointName, $ManagementServerFQDN)
			$script:ReceivedArgs = @($DeviceUUID, $PointName, $ManagementServerFQDN)
			$true
		}

		$Result = Move-CapaDeviceToPoint -CapaSDK $CapaSDK -DeviceUUID '12345678-1234-1234-1234-123456789012' -PointName 'Point1' -ManagementServerFQDN 'server.test.local' -Confirm:$false

		$Result | Should -Be $true
		$script:ReceivedArgs[0] | Should -Be '12345678-1234-1234-1234-123456789012'
		$script:ReceivedArgs[1] | Should -Be 'Point1'
		$script:ReceivedArgs[2] | Should -Be 'server.test.local'
	}

	It 'Allows empty ManagementServerFQDN' {
		$script:ReceivedArgs = $null

		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name MoveDeviceToPoint -Value {
			param($DeviceUUID, $PointName, $ManagementServerFQDN)
			$script:ReceivedArgs = @($DeviceUUID, $PointName, $ManagementServerFQDN)
			$true
		}

		$Result = Move-CapaDeviceToPoint -CapaSDK $CapaSDK -DeviceUUID '12345678-1234-1234-1234-123456789012' -PointName 'Point1' -ManagementServerFQDN '' -Confirm:$false

		$Result | Should -Be $true
		$script:ReceivedArgs[2] | Should -Be ''
	}

	It 'Does not call SDK when using WhatIf' {
		$script:CallCount = 0

		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name MoveDeviceToPoint -Value {
			param($DeviceUUID, $PointName, $ManagementServerFQDN)
			$script:CallCount++
			$true
		}

		$Result = Move-CapaDeviceToPoint -CapaSDK $CapaSDK -DeviceUUID '12345678-1234-1234-1234-123456789012' -PointName 'Point1' -ManagementServerFQDN 'server.test.local' -WhatIf -Confirm:$false

		$script:CallCount | Should -Be 0
		$Result | Should -BeNullOrEmpty
	}

	It 'Throws when CapaSDK does not implement MoveDeviceToPoint' {
		$CapaSDK = [pscustomobject]@{}

		{ Move-CapaDeviceToPoint -CapaSDK $CapaSDK -DeviceUUID '12345678-1234-1234-1234-123456789012' -PointName 'Point1' -ManagementServerFQDN 'server.test.local' -Confirm:$false } | Should -Throw 'CapaSDK does not contain method MoveDeviceToPoint.'
	}

	It 'Validates DeviceUUID format' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member -MemberType ScriptMethod -Name MoveDeviceToPoint -Value {
			param($DeviceUUID, $PointName, $ManagementServerFQDN)
			$true
		}

		{ Move-CapaDeviceToPoint -CapaSDK $CapaSDK -DeviceUUID 'not-a-guid' -PointName 'Point1' -ManagementServerFQDN 'server.test.local' -Confirm:$false } | Should -Throw
	}
}
