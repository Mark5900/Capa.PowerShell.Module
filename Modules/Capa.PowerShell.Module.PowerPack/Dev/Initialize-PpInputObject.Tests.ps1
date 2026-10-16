BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Initialize-PpInputObject' {
	It 'Creates Global InputObject when it is null' {
		$Global:InputObject = $null

		Initialize-PpInputObject

		$Global:InputObject | Should -Not -BeNullOrEmpty
		$Global:InputObject.GetType().Name | Should -Be 'InputObject'
	}

	It 'Does not overwrite an existing Global InputObject' {
		$existing = [InputObject]::new()
		$Global:InputObject = $existing

		Initialize-PpInputObject

		[object]::ReferenceEquals($Global:InputObject, $existing) | Should -Be $true
	}

	It 'Has CmdletBinding attribute' {
		$command = Get-Command -Name 'Initialize-PpInputObject' -CommandType Function -ErrorAction Stop

		($command.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }) | Should -Not -BeNullOrEmpty
	}
}
