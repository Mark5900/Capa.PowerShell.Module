BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'UsrMgr_GetNameBySid' {
	BeforeEach {
		$script:capturedSid = $null
		$global:cs = [pscustomobject]@{}
		$global:cs | Add-Member ScriptMethod UsrMgr_GetNameBySid {
			param($SID)
			$script:capturedSid = $SID
			'JohnDoe'
		}
	}

	It 'Calls the cs method and returns the result' {
		$result = UsrMgr_GetNameBySid -SID 'S-1-5-21-3623811015-3361044348-30300820-1013'

		$result | Should -Be 'JohnDoe'
		$script:capturedSid | Should -Be 'S-1-5-21-3623811015-3361044348-30300820-1013'
	}

	It 'Has CmdletBinding attribute' {
		$command = Get-Command -Name 'UsrMgr_GetNameBySid' -CommandType Function -ErrorAction Stop

		($command.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }) | Should -Not -BeNullOrEmpty
	}
}
