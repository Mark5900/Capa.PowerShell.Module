BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
	$script:LastCall = $null
	$script:CapaSDK = [pscustomobject]@{}
	Add-Member -InputObject $script:CapaSDK -MemberType ScriptMethod -Name AddUnitToProfile -Value {
		param($UnitIdentifier, $ProfileName, $ChangelogComment)
		$script:LastCall = @($UnitIdentifier, $ProfileName, $ChangelogComment)
		return 'OK'
	}
}

Describe 'Add-CapaUnitToProfile' {
	It 'Uses UnitName in NameType parameter set' {
		$Result = Add-CapaUnitToProfile -CapaSDK $script:CapaSDK -UnitName 'PC01' -ProfileName 'WiFi' -Confirm:$false
		$Result | Should -Be 'OK'
		$script:LastCall[0] | Should -Be 'PC01'
	}

	It 'Uses Uuid in Uuid parameter set' {
		$Result = Add-CapaUnitToProfile -CapaSDK $script:CapaSDK -Uuid '1234-5678' -ProfileName 'WiFi' -Confirm:$false
		$Result | Should -Be 'OK'
		$script:LastCall[0] | Should -Be '1234-5678'
	}
}

