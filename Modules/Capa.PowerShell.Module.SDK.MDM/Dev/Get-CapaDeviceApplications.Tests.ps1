BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
	$script:CapaSDK = [pscustomobject]@{}
	Add-Member -InputObject $script:CapaSDK -MemberType ScriptMethod -Name GetDeviceApplications -Value {
		return @('1;App1;Desc1;10;1.0;CMP1;GUID1')
	}
}

Describe 'Get-CapaDeviceApplications' {
	It 'Parses SDK response into objects' {
		$Result = Get-CapaDeviceApplications -CapaSDK $script:CapaSDK
		$Result.Count | Should -Be 1
		$Result[0].Name | Should -Be 'App1'
		$Result[0].CMPID | Should -Be 'CMP1'
	}
}

