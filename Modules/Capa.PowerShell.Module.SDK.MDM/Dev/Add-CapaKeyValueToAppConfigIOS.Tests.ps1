BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
	$script:LastCall = $null
	$script:CapaSDK = [pscustomobject]@{}
	Add-Member -InputObject $script:CapaSDK -MemberType ScriptMethod -Name AddKeyValueToAppConfigIOS -Value {
		param($DeviceApplicationID, $Key, $Value, $KeyValueType, $ChangelogComment)
		$script:LastCall = @($DeviceApplicationID, $Key, $Value, $KeyValueType, $ChangelogComment)
		return 'OK'
	}
}

Describe 'Add-CapaKeyValueToAppConfigIOS' {
	It 'Calls SDK method with expected values' {
		$Result = Add-CapaKeyValueToAppConfigIOS -CapaSDK $script:CapaSDK -DeviceApplicationID 5 -Key 'AllowSync' -Value 'True' -KeyValueType 'Boolean' -Confirm:$false
		$Result | Should -Be 'OK'
		$script:LastCall[3] | Should -Be 'Boolean'
	}
}

