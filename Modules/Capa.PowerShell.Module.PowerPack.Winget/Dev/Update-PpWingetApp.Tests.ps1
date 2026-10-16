BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Update-PpWingetApp' {
	BeforeEach {
		$script:shellCalls = @()
		$script:loggedTexts = @()
		function Find-PpWinGetCmd { 'C:\Program Files\WinGet\winget.exe' }
		function Install-PpWingetPrerequisites { param($WingetPath) }
		function Add-PpWingetScopeMachine { }
		function Get-PpWingetReturnCodeDescription { param($Decimal) 'OK' }
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
		function Job_WriteLog {
			param($Text, $FunctionName)
			$script:loggedTexts += $Text
		}
		function Confirm-PpWingetAppInstall { $true }
		function Exit-PpPackageFailedInstall { param($ExitMessage) }
		function Exit-PpCommandFailed { param($ExitMessage) }
	}

	It 'Builds the upgrade command with locale and uninstall previous' {
		Update-PpWingetApp -AppId 'Mozilla.Firefox' -Locale 'da-DK' -UninstallPrevious $true | Should -Be 0

		$script:shellCalls.Count | Should -Be 1
		$script:shellCalls[0].Command | Should -Be 'C:\Program Files\WinGet\winget.exe'
		$script:shellCalls[0].Arguments | Should -Match 'upgrade --id Mozilla.Firefox -e -h --accept-source-agreements --force --uninstall-previous --locale da-DK'
	}

	It 'Has CmdletBinding attribute' {
		$command = Get-Command -Name 'Update-PpWingetApp' -CommandType Function -ErrorAction Stop

		($command.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }) | Should -Not -BeNullOrEmpty
	}
}