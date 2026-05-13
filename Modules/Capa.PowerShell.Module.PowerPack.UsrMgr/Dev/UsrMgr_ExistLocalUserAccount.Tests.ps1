BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'UsrMgr_ExistLocalUserAccount' {
	BeforeEach {
		$script:capturedUserName = $null
		$global:cs = [pscustomobject]@{}
		$global:cs | Add-Member ScriptMethod UsrMgr_ExistLocalUserAccount {
			param($UserName)
			$script:capturedUserName = $UserName
			$true
		}
	}

	It 'Calls the cs method and returns the result' {
		$result = UsrMgr_ExistLocalUserAccount -UserName 'JohnDoe'

		$result | Should -Be $true
		$script:capturedUserName | Should -Be 'JohnDoe'
	}

	It 'Has CmdletBinding attribute' {
		$command = Get-Command -Name 'UsrMgr_ExistLocalUserAccount' -CommandType Function -ErrorAction Stop

		($command.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }) | Should -Not -BeNullOrEmpty
	}
}
