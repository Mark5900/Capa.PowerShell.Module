BeforeAll {
	. $PSScriptRoot\Export-CapaPackage.ps1
}

Describe 'Export-CapaPackage' {
	It 'Calls SDK method with expected values' {
		$script:called = $null
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member ScriptMethod ExportPackage {
			param($PackageName, $PackageVersion, $PackageType, $ToFolder)
			$script:called = @($PackageName, $PackageVersion, $PackageType, $ToFolder)
			$true
		}

		$result = Export-CapaPackage -CapaSDK $CapaSDK -PackageName 'Pkg' -PackageVersion 'v1' -PackageType 'Computer' -ToFolder 'C:\Temp'

		$result | Should -Be $true
		$script:called[3] | Should -Be 'C:\Temp'
	}
}
