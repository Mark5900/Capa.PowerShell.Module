BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'UsrMgr_ChangePassword' {
	BeforeEach {
		$script:capturedArgs = @()
		$global:cs = [pscustomobject]@{}
		$global:cs | Add-Member ScriptMethod UsrMgr_ChangePassword {
			param($UserName, $Password)
			$script:capturedArgs = @($UserName, $Password)
		}
	}

	It 'Calls the cs method with the provided user and password' {
		UsrMgr_ChangePassword -UserName 'JohnDoe' -Password 'P@ssw0rd'

		$script:capturedArgs[0] | Should -Be 'JohnDoe'
		$script:capturedArgs[1] | Should -Be 'P@ssw0rd'
	}

	It 'Has CmdletBinding attribute' {
		$command = Get-Command -Name 'UsrMgr_ChangePassword' -CommandType Function -ErrorAction Stop

		($command.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }) | Should -Not -BeNullOrEmpty
	}
}