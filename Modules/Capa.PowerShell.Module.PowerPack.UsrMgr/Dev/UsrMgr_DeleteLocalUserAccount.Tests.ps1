BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'UsrMgr_DeleteLocalUserAccount' {
	BeforeEach {
		$script:capturedUserName = $null
		$global:cs = [pscustomobject]@{}
		$global:cs | Add-Member ScriptMethod UsrMgr_DeleteLocalUserAccount {
			param($UserName)
			$script:capturedUserName = $UserName
		}
	}

	It 'Calls the cs method with the provided user name' {
		UsrMgr_DeleteLocalUserAccount -UserName 'JohnDoe'

		$script:capturedUserName | Should -Be 'JohnDoe'
	}

	It 'Has CmdletBinding attribute' {
		$command = Get-Command -Name 'UsrMgr_DeleteLocalUserAccount' -CommandType Function -ErrorAction Stop

		($command.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }) | Should -Not -BeNullOrEmpty
	}
}