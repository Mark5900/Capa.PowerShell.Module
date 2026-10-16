BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Add-PpWingetScopeMachine' {
	BeforeEach {
		$script:originalLocalAppData = $env:LOCALAPPDATA
		$script:testRoot = Join-Path $TestDrive 'LocalAppData'
		$script:settingsPath = Join-Path $script:testRoot 'Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState\settings.json'
		$null = New-Item -ItemType Directory -Path (Split-Path $script:settingsPath -Parent) -Force
		$env:LOCALAPPDATA = $script:testRoot

		function Job_WriteLog {
			param(
				$Text,
				$FunctionName
			)
		}
	}

	AfterEach {
		$env:LOCALAPPDATA = $script:originalLocalAppData
	}

	It 'Updates the settings file with machine scope' {
		Add-PpWingetScopeMachine

		(Get-Content -Path $script:settingsPath -Raw) | Should -Match '"scope":\s*"Machine"'
	}

	It 'Has CmdletBinding attribute' {
		$command = Get-Command -Name 'Add-PpWingetScopeMachine' -CommandType Function -ErrorAction Stop

		($command.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }) | Should -Not -BeNullOrEmpty
	}
}