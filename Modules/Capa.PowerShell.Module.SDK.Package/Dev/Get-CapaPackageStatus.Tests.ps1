BeforeAll {
	. $PSScriptRoot\Get-CapaPackageStatus.ps1
}

Describe 'Get-CapaPackageStatus' {
	It 'Parses SDK response into objects' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member ScriptMethod GetPackageStatus {
			param($UnitName, $UnitType)
			@('PC01;Pkg;v1;0;Installed')
		}

		$result = Get-CapaPackageStatus -CapaSDK $CapaSDK -UnitName 'PC01' -UnitType 'Computer'

		$result | Should -HaveCount 1
		$result[0].PackageName | Should -Be 'Pkg'
		$result[0].DisplayStatus | Should -Be 'Installed'
	}
}
