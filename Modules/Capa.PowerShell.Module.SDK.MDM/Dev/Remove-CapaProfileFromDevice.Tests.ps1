BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
	$script:LastCall = $null
	$script:CapaSDK = [pscustomobject]@{}
	Add-Member -InputObject $script:CapaSDK -MemberType ScriptMethod -Name RemoveUnitFromProfile -Value {
		param($UnitIdentifier, $ProfileName, $ChangelogComment)
		$script:LastCall = @($UnitIdentifier, $ProfileName, $ChangelogComment)
		return 'OK'
	}
}

Describe 'Remove-CapaProfileFromDevice' {
	It 'Uses UnitName in NameType parameter set' {
		$Result = Remove-CapaProfileFromDevice -CapaSDK $script:CapaSDK -UnitName 'PC01' -ProfileName 'WiFi' -Confirm:$false
		$Result | Should -Be 'OK'
		$script:LastCall[0] | Should -Be 'PC01'
	}

	It 'Uses UUID in Uuid parameter set' {
		$Result = Remove-CapaProfileFromDevice -CapaSDK $script:CapaSDK -UUID '1234-5678' -ProfileName 'WiFi' -Confirm:$false
		$Result | Should -Be 'OK'
		$script:LastCall[0] | Should -Be '1234-5678'
	}
}

