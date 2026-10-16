BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Service_Exist' {
	BeforeEach {
		$script:capturedArgs = $null
		$global:cs = [pscustomobject]@{}
		$global:cs | Add-Member ScriptMethod Service_Exist {
			param($ServiceName)
			$script:capturedArgs = @($ServiceName)
			$true
		}
	}

	It 'Calls the cs method and returns the result' {
		$result = Service_Exist -ServiceName 'W32Time'

		$result | Should -Be $true
		$script:capturedArgs[0] | Should -Be 'W32Time'
	}

	It 'Has CmdletBinding attribute' {
		$command = Get-Command -Name 'Service_Exist' -CommandType Function -ErrorAction Stop

		($command.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }) | Should -Not -BeNullOrEmpty
	}
}
