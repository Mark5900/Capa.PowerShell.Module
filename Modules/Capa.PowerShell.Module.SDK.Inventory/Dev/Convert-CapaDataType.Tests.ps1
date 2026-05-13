BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'Convert-CapaDataType' {
	It 'Converts integer 1 to String' {
		Convert-CapaDataType -Datatype 1 | Should -Be 'String'
	}

	It 'Converts integer 2 to Time' {
		Convert-CapaDataType -Datatype 2 | Should -Be 'Time'
	}

	It 'Converts integer 3 to Integer' {
		Convert-CapaDataType -Datatype 3 | Should -Be 'Integer'
	}

	It 'Converts I to Integer' {
		Convert-CapaDataType -Datatype 'I' | Should -Be 'Integer'
	}

	It 'Converts T to Time' {
		Convert-CapaDataType -Datatype 'T' | Should -Be 'Time'
	}

	It 'Converts S to String' {
		Convert-CapaDataType -Datatype 'S' | Should -Be 'String'
	}

	It 'Converts N to Text' {
		Convert-CapaDataType -Datatype 'N' | Should -Be 'Text'
	}

	It 'Returns unknown value as-is' {
		Convert-CapaDataType -Datatype 'X' | Should -Be 'X'
	}
}
