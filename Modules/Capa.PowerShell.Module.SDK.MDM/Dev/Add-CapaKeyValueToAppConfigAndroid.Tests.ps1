BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
	$script:LastCall = $null
	$script:CapaSDK = [pscustomobject]@{}
	Add-Member -InputObject $script:CapaSDK -MemberType ScriptMethod -Name AddKeyValueToAppConfigAndroid -Value {
		param($DeviceApplicationID, $Key, $Value, $KeyValueType, $ChangelogComment)
		$script:LastCall = @($DeviceApplicationID, $Key, $Value, $KeyValueType, $ChangelogComment)
		return 'OK'
	}
}

Describe 'Add-CapaKeyValueToAppConfigAndroid' {
	It 'Calls SDK method with expected values' {
		$Result = Add-CapaKeyValueToAppConfigAndroid -CapaSDK $script:CapaSDK -DeviceApplicationID 5 -Key 'AllowSync' -Value 'True' -KeyValueType 'Bool' -Confirm:$false
		$Result | Should -Be 'OK'
		$script:LastCall[0] | Should -Be 5
		$script:LastCall[1] | Should -Be 'AllowSync'
	}
}

