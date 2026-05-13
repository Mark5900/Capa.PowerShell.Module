BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'New-MessageBox' {
	It 'Returns integer button code by default' {
		Mock New-Object {
			$Popup = [pscustomobject]@{}
			$Popup | Add-Member -MemberType ScriptMethod -Name Popup -Value { param($Message, $Time, $Title, $Type) return 1 }
			return $Popup
		} -ParameterFilter { $ComObject -eq 'Wscript.Shell' }

		$Result = New-MessageBox -Message 'Test message' -Title 'Test title' -Time 1

		$Result | Should -Be 1
	}

	It 'Returns string button name when AsString is used' {
		Mock New-Object {
			$Popup = [pscustomobject]@{}
			$Popup | Add-Member -MemberType ScriptMethod -Name Popup -Value { param($Message, $Time, $Title, $Type) return 2 }
			return $Popup
		} -ParameterFilter { $ComObject -eq 'Wscript.Shell' }

		$Result = New-MessageBox -Message 'Test message' -Title 'Test title' -Time 1 -AsString

		$Result | Should -Be 'Cancel'
	}

	It 'Validates Time is zero or positive' {
		{ New-MessageBox -Message 'Test message' -Title 'Test title' -Time -1 } | Should -Throw
	}
}
