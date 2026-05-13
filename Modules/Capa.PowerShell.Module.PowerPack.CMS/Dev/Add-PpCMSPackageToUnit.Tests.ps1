BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Add-PpCMSPackageToUnit' {
	It 'Has CmdletBinding attribute' {
		$command = Get-Command -Name 'Add-PpCMSPackageToUnit' -CommandType Function -ErrorAction Stop

		($command.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }) | Should -Not -BeNullOrEmpty
	}
}