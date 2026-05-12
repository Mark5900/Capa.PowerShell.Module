BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Invoke-CCSIsError' {
	It 'Returns true for does-not-exist pattern' {
		Invoke-CCSIsError -Result 'Computer XYZ does not exist in Active Directory' | Should -BeTrue
	}

	It 'Returns true for unwilling-to-process pattern' {
		Invoke-CCSIsError -Result 'The server is unwilling to process the request due to policy' | Should -BeTrue
	}

	It 'Returns true for not-operational pattern' {
		Invoke-CCSIsError -Result 'The server is not operational right now' | Should -BeTrue
	}

	It 'Returns false for non-error message' {
		Invoke-CCSIsError -Result 'Operation completed successfully' | Should -BeFalse
	}

	It 'Validates Result is not empty' {
		{ Invoke-CCSIsError -Result '' } | Should -Throw
	}
}
