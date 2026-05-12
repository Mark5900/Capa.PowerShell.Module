BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
	$script:CapaSDK = [pscustomobject]@{}
	Add-Member -InputObject $script:CapaSDK -MemberType ScriptMethod -Name GetProfiles -Value {
		return @('2;Profile1;Desc1;1;1.0;CMP1;GUID1')
	}
}

Describe 'Get-CapaProfiles' {
	It 'Parses SDK response into objects' {
		$Result = Get-CapaProfiles -CapaSDK $script:CapaSDK
		$Result.Count | Should -Be 1
		$Result[0].Name | Should -Be 'Profile1'
		$Result[0].ID | Should -Be '2'
	}
}

