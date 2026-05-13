BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'UsrMgr_AddUserToLocalGroup' {
	BeforeEach {
		$script:capturedArgs = @()
		$global:cs = [pscustomobject]@{}
		$global:cs | Add-Member ScriptMethod UsrMgr_AddUserToLocalGroup {
			param($UserName, $GroupName)
			$script:capturedArgs = @($UserName, $GroupName)
		}
	}

	It 'Calls the cs method with the provided user and group' {
		UsrMgr_AddUserToLocalGroup -UserName 'JohnDoe' -GroupName 'Administrators'

		$script:capturedArgs[0] | Should -Be 'JohnDoe'
		$script:capturedArgs[1] | Should -Be 'Administrators'
	}

	It 'Has CmdletBinding attribute' {
		$command = Get-Command -Name 'UsrMgr_AddUserToLocalGroup' -CommandType Function -ErrorAction Stop

		($command.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }) | Should -Not -BeNullOrEmpty
	}
}