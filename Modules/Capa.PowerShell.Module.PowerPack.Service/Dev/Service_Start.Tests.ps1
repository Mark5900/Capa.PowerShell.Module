BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Service_Start' {
	BeforeEach {
		$script:capturedArgs = @()
		$global:cs = [pscustomobject]@{}
		$global:cs | Add-Member ScriptMethod Service_Start {
			param($ServiceName, $MaxTimeout)
			$script:capturedArgs = @($ServiceName, $MaxTimeout)
			$true
		}
	}

	It 'Calls the one-argument overload when timeout is omitted' {
		Service_Start -ServiceName 'gupdate' | Should -Be $true

		$script:capturedArgs[0] | Should -Be 'gupdate'
		$script:capturedArgs[1] | Should -BeNullOrEmpty
	}

	It 'Calls the two-argument overload when timeout is provided' {
		Service_Start -ServiceName 'gupdate' -MaxTimeout 120 | Should -Be $true

		$script:capturedArgs.Count | Should -Be 2
		$script:capturedArgs[1] | Should -Be 120
	}

	It 'Has CmdletBinding attribute' {
		$command = Get-Command -Name 'Service_Start' -CommandType Function -ErrorAction Stop

		($command.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }) | Should -Not -BeNullOrEmpty
	}
}
