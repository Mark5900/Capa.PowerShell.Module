BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Uninstall-PpWingetApp' {
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
		function Confirm-PpWingetAppInstall { $false }
		function Exit-PpPackageFailedInstall { param($ExitMessage) }
		function Exit-PpCommandFailed { param($ExitMessage) }
	}

	It 'Builds the uninstall command and executes winget' {
		Uninstall-PpWingetApp -AppId 'Mozilla.Firefox' | Should -Be 0

		$script:shellCalls.Count | Should -Be 1
		$script:shellCalls[0].Command | Should -Be 'C:\Program Files\WinGet\winget.exe'
		$script:shellCalls[0].Arguments | Should -Match 'uninstall -e --id Mozilla.Firefox --force -h'
	}

	It 'Runs prerequisites when winget installation is allowed' {
		Uninstall-PpWingetApp -AppId 'Mozilla.Firefox' -AllowInstallOfWinGet $true | Should -Be 0

		$script:prereqCalls.Count | Should -Be 1
		$script:prereqCalls[0] | Should -Be 'C:\Program Files\WinGet\winget.exe'
	}

	It 'Has CmdletBinding attribute' {
		$command = Get-Command -Name 'Uninstall-PpWingetApp' -CommandType Function -ErrorAction Stop

		($command.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] }) | Should -Not -BeNullOrEmpty
	}
}