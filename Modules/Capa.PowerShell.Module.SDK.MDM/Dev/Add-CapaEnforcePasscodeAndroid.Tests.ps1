BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
	$script:LastCall = $null
	$script:CapaSDK = [pscustomobject]@{}
	Add-Member -InputObject $script:CapaSDK -MemberType ScriptMethod -Name AddEditEnforcePasscodeAndroid -Value {
		param($ProfileId, $Passcode, $ChangelogComment)
		$script:LastCall = @($ProfileId, $Passcode, $ChangelogComment)
		return 'OK'
	}
}

Describe 'Add-CapaEnforcePasscodeAndroid' {
	It 'Calls SDK method with expected values' {
		$Result = Add-CapaEnforcePasscodeAndroid -CapaSDK $script:CapaSDK -ProfileId 7 -Passcode '1234' -ChangelogComment 'test' -Confirm:$false
		$Result | Should -Be 'OK'
		$script:LastCall[0] | Should -Be 7
		$script:LastCall[1] | Should -Be '1234'
		$script:LastCall[2] | Should -Be 'test'
	}
}

