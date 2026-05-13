BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Shell_ExecuteWithTimeout' {
	BeforeEach {
		$script:capturedArgs = $null
		$global:cs = [pscustomobject]@{}
		$global:cs | Add-Member ScriptMethod Shell_ExecuteWithTimeout {
			param($Command, $Arguments, $MustExist, $Timeout)
			$script:capturedArgs = @($Command, $Arguments, $MustExist, $Timeout)
			23
		}
	}

	It 'Calls the cs method with timeout arguments' {
		$result = Shell_ExecuteWithTimeout -Command 'ping.exe' -Arguments 'localhost' -MustExist $false -Timeout 12

		$result | Should -Be 23
		$script:capturedArgs[0] | Should -Be 'ping.exe'
		$script:capturedArgs[2] | Should -Be $false
		$script:capturedArgs[3] | Should -Be 12
	}

	It 'Has CmdletBinding attribute' {
		$command = Get-Command -Name 'Shell_ExecuteWithTimeout' -CommandType Function -ErrorAction Stop

		($command.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }) | Should -Not -BeNullOrEmpty
	}
}
