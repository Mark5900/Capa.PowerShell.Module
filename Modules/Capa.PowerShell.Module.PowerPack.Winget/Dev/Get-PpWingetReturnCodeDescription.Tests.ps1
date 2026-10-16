BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Get-PpWingetReturnCodeDescription' {
	BeforeEach {
		$script:loggedTexts = @()
		function Job_WriteLog {
			param(
				$Text,
				$FunctionName
			)

			$script:loggedTexts += $Text
		}
	}

	It 'Returns the success message for code 0' {
		Get-PpWingetReturnCodeDescription -Decimal 0 | Should -Be 'Command completed successfully'
		$script:loggedTexts | Should -Contain 'Command completed successfully'
	}

	It 'Returns the internal error message for the known error code' {
		Get-PpWingetReturnCodeDescription -Decimal -1978335231 | Should -Be 'Internal Error'
		$script:loggedTexts | Should -Contain 'Internal Error'
	}

	It 'Has CmdletBinding attribute' {
		$command = Get-Command -Name 'Get-PpWingetReturnCodeDescription' -CommandType Function -ErrorAction Stop

		($command.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }) | Should -Not -BeNullOrEmpty
	}
}