BeforeAll {
	. $PSScriptRoot\Count-CapaConscomActions.ps1
}

Describe 'Count-CapaConscomActions' {
	It 'Calls SDK method with expected server id' {
		$script:called = $null
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member ScriptMethod CountConscomActions {
			param($ManagementServerID)
			$script:called = $ManagementServerID
			3
		}

		$result = Count-CapaConscomActions -CapaSDK $CapaSDK -ManagementServerID 1

		$result | Should -Be 3
		$script:called | Should -Be 1
	}
}
