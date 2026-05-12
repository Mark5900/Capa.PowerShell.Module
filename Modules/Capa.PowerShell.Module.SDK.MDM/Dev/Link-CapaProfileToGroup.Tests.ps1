BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
	$script:LastCall = $null
	$script:CapaSDK = [pscustomobject]@{}
	Add-Member -InputObject $script:CapaSDK -MemberType ScriptMethod -Name AddProfileToGroup -Value {
		param($ProfileId, $GroupName, $GroupType, $BusinessUnitName, $ChangelogComment)
		$script:LastCall = @($ProfileId, $GroupName, $GroupType, $BusinessUnitName, $ChangelogComment)
		return 'OK'
	}
}

Describe 'Link-CapaProfileToGroup' {
	It 'Calls SDK method with expected values' {
		$Result = Link-CapaProfileToGroup -CapaSDK $script:CapaSDK -ProfileId 10 -GroupName 'G1' -GroupType Static -BusinessUnitName 'BU1' -Confirm:$false
		$Result | Should -Be 'OK'
		$script:LastCall[0] | Should -Be 10
		$script:LastCall[1] | Should -Be 'G1'
	}
}

