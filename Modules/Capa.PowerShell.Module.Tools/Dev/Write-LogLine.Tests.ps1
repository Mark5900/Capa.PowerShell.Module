BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Write-LogLine' {
	It 'Runs with default ScriptPart when a valid color is provided' {
		{ Write-LogLine -Text 'Hello world' -ForegroundColor 'White' } | Should -Not -Throw
	}

	It 'Runs with custom ScriptPart and valid color' {
		{ Write-LogLine -Text 'Done' -ScriptPart 'UnitTest' -ForegroundColor 'Red' } | Should -Not -Throw
	}

	It 'Throws on invalid foreground color' {
		{ Write-LogLine -Text 'X' -ForegroundColor 'Orange' } | Should -Throw
	}
}
