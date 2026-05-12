BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Initialize-CapaSDK' {
	It 'Returns an object with Windows Authentication' {
		$Result = Initialize-CapaSDK -Server $env:COMPUTERNAME -Database 'CapaInstaller' -InstanceManagementPoint 2
		$Result | Should -Not -BeNullOrEmpty
	}

	It 'Returns an object using DefaultManagementPoint' {
		$Result = Initialize-CapaSDK -Server $env:COMPUTERNAME -Database 'CapaInstaller' -DefaultManagementPoint 1
		$Result | Should -Not -BeNullOrEmpty
	}

	It 'Throws when Server is empty' {
		{ Initialize-CapaSDK -Server '' -Database 'CapaInstaller' } | Should -Throw
	}

	It 'Throws when Database is empty' {
		{ Initialize-CapaSDK -Server $env:COMPUTERNAME -Database '' } | Should -Throw
	}
}
