BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'UsrMgr_CreateLocalUser' {
	BeforeEach {
		$script:capturedArgs = @()
		$global:cs = [pscustomobject]@{}
		$global:cs | Add-Member ScriptMethod UsrMgr_CreateLocalUser {
			param($UserName, $FullName, $Password, $Description, $PasswordNeverExpire)
			$script:capturedArgs = @($UserName, $FullName, $Password, $Description, $PasswordNeverExpire)
		}
	}

	It 'Calls the cs method with the provided values' {
		UsrMgr_CreateLocalUser -UserName 'JohnDoe' -FullName 'John Doe' -Password 'P@ssw0rd' -Description 'Test user' -PasswordNeverExpire $false

		$script:capturedArgs[0] | Should -Be 'JohnDoe'
		$script:capturedArgs[1] | Should -Be 'John Doe'
		$script:capturedArgs[2] | Should -Be 'P@ssw0rd'
		$script:capturedArgs[3] | Should -Be 'Test user'
		$script:capturedArgs[4] | Should -Be $false
	}

	It 'Has CmdletBinding attribute' {
		$command = Get-Command -Name 'UsrMgr_CreateLocalUser' -CommandType Function -ErrorAction Stop

		($command.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }) | Should -Not -BeNullOrEmpty
	}
}