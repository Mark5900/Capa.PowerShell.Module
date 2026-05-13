BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
	$script:LastCall = $null
	$script:CapaSDK = [pscustomobject]@{}
	Add-Member -InputObject $script:CapaSDK -MemberType ScriptMethod -Name AssignProfileToBusinessUnit -Value {
		param($ProfileId, $BusinessUnitName, $ChangelogComment)
		$script:LastCall = @($ProfileId, $BusinessUnitName, $ChangelogComment)
		return 'OK'
	}
}

Describe 'Assign-CapaProfileToBusinessUnit' {
	It 'Calls SDK method with expected values' {
		$Result = Assign-CapaProfileToBusinessUnit -CapaSDK $script:CapaSDK -ProfileId 10 -BusinessUnitName 'Denmark' -Confirm:$false
		$Result | Should -Be 'OK'
		$script:LastCall[0] | Should -Be 10
		$script:LastCall[1] | Should -Be 'Denmark'
	}
}

