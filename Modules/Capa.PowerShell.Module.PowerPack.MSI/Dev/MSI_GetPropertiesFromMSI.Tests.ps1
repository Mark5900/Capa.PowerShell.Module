BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'MSI_GetPropertiesFromMSI' {
	It 'Has CmdletBinding attribute' {
		$command = Get-Command -Name 'MSI_GetPropertiesFromMSI' -CommandType Function -ErrorAction Stop

		($command.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }) | Should -Not -BeNullOrEmpty
	}
}
