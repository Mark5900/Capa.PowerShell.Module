BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Ini_WriteEntry' {
	It 'Has CmdletBinding attribute' {
		$command = Get-Command -Name 'Ini_WriteEntry' -CommandType Function -ErrorAction Stop

		($command.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }) | Should -Not -BeNullOrEmpty
	}
}
