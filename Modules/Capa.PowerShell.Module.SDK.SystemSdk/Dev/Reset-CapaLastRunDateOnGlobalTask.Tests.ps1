BeforeAll {
	. $PSScriptRoot\Reset-CapaLastRunDateOnGlobalTask.ps1
}

Describe 'Reset-CapaLastRunDateOnGlobalTask' {
	It 'Calls SDK method with expected task display name' {
		$script:called = $null
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member ScriptMethod ResetLastRunOnGlobalTask {
			param($TaskDisplayName)
			$script:called = $TaskDisplayName
			$true
		}

		$result = Reset-CapaLastRunDateOnGlobalTask -CapaSDK $CapaSDK -TaskDisplayName 'Auto Archive Changelog'

		$result | Should -Be $true
		$script:called | Should -Be 'Auto Archive Changelog'
	}
}
