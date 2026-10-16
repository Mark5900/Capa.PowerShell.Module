BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Uninstall-PpMSI' {
	BeforeEach {
		$script:exitCode = $null
		$script:exitMessage = $null

		function Job_WriteLog { param($Text) }
		function Exit-PpScript {
			param($ExitCode, $ExitMessage)
			$script:exitCode = $ExitCode
			$script:exitMessage = $ExitMessage
			throw 'ExitCalled'
		}
	}

	It 'Stops immediately when DisplayName is only wildcard' {
		{ Uninstall-PpMSI -DisplayName '*' } | Should -Throw 'ExitCalled'

		$script:exitCode | Should -Be 1
		$script:exitMessage | Should -Be 'Error - DisplayName cannot be just a wildcard'
	}

	It 'Has CmdletBinding attribute' {
		$command = Get-Command -Name 'Uninstall-PpMSI' -CommandType Function -ErrorAction Stop

		($command.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }) | Should -Not -BeNullOrEmpty
	}
}