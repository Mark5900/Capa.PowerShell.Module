BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Get-ScriptDirectory' {
	It 'Returns a non-empty path string' {
		$Result = Get-ScriptDirectory

		$Result | Should -BeOfType [string]
		$Result | Should -Not -BeNullOrEmpty
	}

	It 'Returns a path that exists as a folder' {
		$Result = Get-ScriptDirectory
		Test-Path -Path $Result -PathType Container | Should -BeTrue
	}
}
