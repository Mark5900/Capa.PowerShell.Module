BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Install-PpWingetApp' {
	BeforeEach {
		$script:shellCalls = @()
		$script:loggedTexts = @()
		$script:prereqCalls = @()
		$script:scopeCalls = 0

		function Find-PpWinGetCmd { 'C:\Program Files\WinGet\winget.exe' }
		function Install-PpWingetPrerequisites {
			param($WingetPath)
			$script:prereqCalls += $WingetPath
		}
		function Add-PpWingetScopeMachine {
			$script:scopeCalls++
		}
		function Shell_Execute {
			param($Command, $Arguments, $Wait, $WindowStyle, $MustExist)
			$script:shellCalls += [pscustomobject]@{
				Command = $Command
				Arguments = $Arguments
				Wait = $Wait
				WindowStyle = $WindowStyle
				MustExist = $MustExist
			}
			0
		}
		function Get-PpWingetReturnCodeDescription {
			param($Decimal)
			'OK'
		}
		function Job_WriteLog {
			param($Text, $FunctionName)
			$script:loggedTexts += $Text
		}
		function Confirm-PpWingetAppInstall { $true }
		function Exit-PpPackageFailedInstall { param($ExitMessage) }
		function Exit-PpCommandFailed { param($ExitMessage) }
	}

	It 'Builds the install command with locale and executes winget' {
		Install-PpWingetApp -AppId 'Mozilla.Firefox' -Locale 'da-DK' | Should -Be 0

		$script:shellCalls.Count | Should -Be 1
		$script:shellCalls[0].Command | Should -Be 'C:\Program Files\WinGet\winget.exe'
		$script:shellCalls[0].Arguments | Should -Match 'install -e --id Mozilla.Firefox -h --accept-package-agreements --accept-source-agreements --force --locale da-DK'
		$script:scopeCalls | Should -Be 1
	}

	It 'Runs prerequisites when winget installation is allowed' {
		Install-PpWingetApp -AppId 'Mozilla.Firefox' -AllowInstallOfWinGet $true | Should -Be 0

		$script:prereqCalls.Count | Should -Be 1
		$script:prereqCalls[0] | Should -Be 'C:\Program Files\WinGet\winget.exe'
	}

	It 'Has CmdletBinding attribute' {
		$command = Get-Command -Name 'Install-PpWingetApp' -CommandType Function -ErrorAction Stop

		($command.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }) | Should -Not -BeNullOrEmpty
	}
}