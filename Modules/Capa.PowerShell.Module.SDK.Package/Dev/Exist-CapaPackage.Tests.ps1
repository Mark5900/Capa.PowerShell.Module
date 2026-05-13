BeforeAll {
	. $PSScriptRoot\Exist-CapaPackage.ps1
}

Describe 'Exist-CapaPackage' {
	It 'Calls SDK method and maps Computer to 1' {
		$script:called = $null
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member ScriptMethod ExistPackage {
			param($Name, $Version, $Type)
			$script:called = @($Name, $Version, $Type)
			$true
		}

		$result = Exist-CapaPackage -CapaSDK $CapaSDK -Name 'Pkg' -Version 'v1' -Type 'Computer'

		$result | Should -Be $true
		$script:called[2] | Should -Be '1'
	}
}
