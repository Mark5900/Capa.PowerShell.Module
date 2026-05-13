BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'UsrMgr_RemoveUserFromLocalGroup' {
	BeforeEach {
		$script:capturedArgs = @()
		$global:cs = [pscustomobject]@{}
		$global:cs | Add-Member ScriptMethod UsrMgr_RemoveUserFromLocalGroup {
			param($Domain, $UserName, $GroupName)
			$script:capturedArgs = @($Domain, $UserName, $GroupName)
		}
	}

	It 'Calls the cs method with the provided domain, user and group' {
		UsrMgr_RemoveUserFromLocalGroup -Domain 'CONTOSO' -UserName 'JohnDoe' -GroupName 'Administrators'

		$script:capturedArgs[0] | Should -Be 'CONTOSO'
		$script:capturedArgs[1] | Should -Be 'JohnDoe'
		$script:capturedArgs[2] | Should -Be 'Administrators'
	}

	It 'Has CmdletBinding attribute' {
		$command = Get-Command -Name 'UsrMgr_RemoveUserFromLocalGroup' -CommandType Function -ErrorAction Stop

		($command.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }) | Should -Not -BeNullOrEmpty
	}
}