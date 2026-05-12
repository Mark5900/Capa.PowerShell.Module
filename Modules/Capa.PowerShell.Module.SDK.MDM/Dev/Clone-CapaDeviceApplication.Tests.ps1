BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
	$script:LastCall = $null
	$script:CapaSDK = [pscustomobject]@{}
	Add-Member -InputObject $script:CapaSDK -MemberType ScriptMethod -Name CloneDeviceApplication -Value {
		param($DeviceApplicationID, $NewName, $ChangelogComment)
		$script:LastCall = @($DeviceApplicationID, $NewName, $ChangelogComment)
		return 'OK'
	}
}

Describe 'Clone-CapaDeviceApplication' {
	It 'Calls SDK method with expected values' {
		$Result = Clone-CapaDeviceApplication -CapaSDK $script:CapaSDK -DeviceApplicationID 3 -NewName 'ClonedApp' -Confirm:$false
		$Result | Should -Be 'OK'
		$script:LastCall[0] | Should -Be 3
		$script:LastCall[1] | Should -Be 'ClonedApp'
	}
}
