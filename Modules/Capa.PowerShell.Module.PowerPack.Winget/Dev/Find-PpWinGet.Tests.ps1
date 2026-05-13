BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Find-PpWinGetCmd' {
	BeforeEach {
		$script:loggedTexts = @()
		$script:originalLocalAppData = $env:LocalAppData
		$script:testRoot = Join-Path $TestDrive 'LocalAppData'
		$env:LocalAppData = $script:testRoot
		$script:wingetPath = Join-Path $script:testRoot 'Microsoft\WindowsApps\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\winget.exe'
		$null = New-Item -ItemType Directory -Path (Split-Path $script:wingetPath -Parent) -Force

		function Job_WriteLog {
			param($Text, $FunctionName)
			$script:loggedTexts += $Text
		}
	}

	AfterEach {
		$env:LocalAppData = $script:originalLocalAppData
	}

	It 'Returns false for server OS' {
		$global:gsOsSystem = 'Windows Server 2022'

		Find-PpWinGetCmd | Should -Be $false
	}

	It 'Returns the user-context winget path when the file exists' {
		$global:gsOsSystem = 'Windows 11'
		function Get-Item { throw 'forced fallback' }
		New-Item -ItemType File -Path $script:wingetPath -Force | Out-Null

		Find-PpWinGetCmd | Should -Be $script:wingetPath
	}

	It 'Has CmdletBinding attribute' {
		$command = Get-Command -Name 'Find-PpWinGetCmd' -CommandType Function -ErrorAction Stop

		($command.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }) | Should -Not -BeNullOrEmpty
	}
}