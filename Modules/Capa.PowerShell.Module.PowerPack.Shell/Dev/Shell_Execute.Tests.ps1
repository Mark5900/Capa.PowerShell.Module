BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Shell_Execute' {
	BeforeEach {
		$script:capturedArgs = $null
		$global:cs = [pscustomobject]@{}
		$global:cs | Add-Member ScriptMethod Shell_Execute {
			param($Command, $Arguments, $Wait, $WindowStyleInt, $MustExist, $WorkingDirectory)
			$script:capturedArgs = @($Command, $Arguments, $Wait, $WindowStyleInt, $MustExist, $WorkingDirectory)
			17
		}
	}

	It 'Maps Normal window style to 1 and calls the cs method' {
		$result = Shell_Execute -Command 'cmd.exe' -Arguments '/c echo test' -Wait $false -WindowStyle Normal -MustExist $true -WorkingDirectory 'C:\Temp'

		$result | Should -Be 17
		$script:capturedArgs[0] | Should -Be 'cmd.exe'
		$script:capturedArgs[3] | Should -Be 1
		$script:capturedArgs[4] | Should -Be $true
	}

	It 'Has CmdletBinding attribute' {
		$command = Get-Command -Name 'Shell_Execute' -CommandType Function -ErrorAction Stop

		($command.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }) | Should -Not -BeNullOrEmpty
	}
}
