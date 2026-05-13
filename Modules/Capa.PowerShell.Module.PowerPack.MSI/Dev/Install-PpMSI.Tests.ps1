BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Install-PpMSI' {
	BeforeEach {
		$script:LogFile = Join-Path $TestDrive 'PowerPack.log'
		$script:createdPath = $null
		$script:shellCall = $null
		$script:exitCode = $null
		$script:shellReturnValue = 0

		function Job_WriteLog { param($Text) }
		function File_CreateDir {
			param($Path)
			$script:createdPath = $Path
		}
		function Shell_Execute {
			param($Command, $Arguments)
			$script:shellCall = [pscustomobject]@{ Command = $Command; Arguments = $Arguments }
			$script:shellReturnValue
		}
		function Exit-PpScript {
			param($ExitCode, $ExitMessage)
			$script:exitCode = $ExitCode
		}
	}

	It 'Builds and executes the msiexec install command' {
		Install-PpMSI -FilePath 'C:\Temp\MyApp.msi' -Arguments '/qn'

		$script:createdPath | Should -Match 'MSILogs$'
		$script:shellCall.Command | Should -Be 'msiexec.exe'
		$script:shellCall.Arguments | Should -Match '/i "C:\\Temp\\MyApp.msi" /qn /l\*vx '
		$script:exitCode | Should -Be $null
	}

	It 'Calls Exit-PpScript when msiexec returns a non-zero code' {
		$script:shellReturnValue = 1603

		Install-PpMSI -FilePath 'C:\Temp\MyApp.msi'

		$script:exitCode | Should -Be 1603
	}

	It 'Has CmdletBinding attribute' {
		$command = Get-Command -Name 'Install-PpMSI' -CommandType Function -ErrorAction Stop

		($command.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }) | Should -Not -BeNullOrEmpty
	}
}