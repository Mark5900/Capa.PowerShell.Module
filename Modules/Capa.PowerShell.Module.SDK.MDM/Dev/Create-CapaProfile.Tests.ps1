BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
	$script:LastCall = $null
	$script:LastCallBU = $null
	$script:CapaSDK = [pscustomobject]@{}
	Add-Member -InputObject $script:CapaSDK -MemberType ScriptMethod -Name CreateProfile -Value {
		param($Name, $Description, $Priority, $ChangelogComment)
		$script:LastCall = @($Name, $Description, $Priority, $ChangelogComment)
		return 'OK'
	}
	Add-Member -InputObject $script:CapaSDK -MemberType ScriptMethod -Name CreateProfileInBusinessUnit -Value {
		param($Name, $Description, $Priority, $ChangelogComment, $BusinessUnitId)
		$script:LastCallBU = @($Name, $Description, $Priority, $ChangelogComment, $BusinessUnitId)
		return 'OKBU'
	}
}

Describe 'Create-CapaProfile' {
	It 'Calls CreateProfile without business unit' {
		$Result = Create-CapaProfile -CapaSDK $script:CapaSDK -Name 'P1' -Description 'D1' -Priority 1 -Confirm:$false
		$Result | Should -Be 'OK'
		$script:LastCall[0] | Should -Be 'P1'
	}

	It 'Calls CreateProfileInBusinessUnit when BusinessUnitId is provided' {
		$Result = Create-CapaProfile -CapaSDK $script:CapaSDK -Name 'P2' -Description 'D2' -Priority 2 -BusinessUnitId 'BU1' -Confirm:$false
		$Result | Should -Be 'OKBU'
		$script:LastCallBU[4] | Should -Be 'BU1'
	}
}

