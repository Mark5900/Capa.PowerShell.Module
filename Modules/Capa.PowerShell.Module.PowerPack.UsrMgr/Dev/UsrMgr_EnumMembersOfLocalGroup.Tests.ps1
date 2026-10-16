BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'UsrMgr_EnumMembersOfLocalGroup' {
	BeforeEach {
		$script:capturedGroupName = $null
		$global:cs = [pscustomobject]@{}
		$global:cs | Add-Member ScriptMethod UsrMgr_EnumMembersOfLocalGroup {
			param($GroupName)
			$script:capturedGroupName = $GroupName
			@('JohnDoe', 'JaneDoe')
		}
	}

	It 'Calls the cs method and returns the members' {
		$result = UsrMgr_EnumMembersOfLocalGroup -GroupName 'Administrators'

		$result | Should -Be @('JohnDoe', 'JaneDoe')
		$script:capturedGroupName | Should -Be 'Administrators'
	}

	It 'Has CmdletBinding attribute' {
		$command = Get-Command -Name 'UsrMgr_EnumMembersOfLocalGroup' -CommandType Function -ErrorAction Stop

		($command.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }) | Should -Not -BeNullOrEmpty
	}
}