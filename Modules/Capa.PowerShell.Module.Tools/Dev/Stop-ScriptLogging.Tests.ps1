BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Stop-ScriptLogging' {
	BeforeEach {
		$Global:SDKScriptStopwatch = $null
		$Global:TranscriptSesions = $null
	}

	It 'Stops all transcript sessions and clears globals' {
		$Global:SDKScriptStopwatch = [Diagnostics.Stopwatch]::StartNew()
		$Global:TranscriptSesions = 2

		Mock Write-Host {}
		Mock Stop-Transcript {}

		$Result = Stop-ScriptLogging | Select-Object -Last 1

		$Result | Should -BeTrue
		$Global:SDKScriptStopwatch | Should -Be $null
		$Global:TranscriptSesions | Should -Be $null
		Assert-MockCalled Stop-Transcript -Times 2 -Exactly
	}

	It 'Returns false if Stop-Transcript throws' {
		$Global:TranscriptSesions = 1

		Mock Write-Host {}
		Mock Stop-Transcript { throw 'Stop transcript failed' }

		$Result = Stop-ScriptLogging | Select-Object -Last 1

		$Result | Should -BeFalse
		$Global:TranscriptSesions | Should -Be 1
		Assert-MockCalled Stop-Transcript -Times 1 -Exactly
	}
}
