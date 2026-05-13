BeforeAll {
	. $PSScriptRoot\Get-CapaPackageFolder.ps1
}

Describe 'Get-CapaPackageFolder' {
	It 'Returns SDK folder value' {
		$CapaSDK = [pscustomobject]@{}
		$CapaSDK | Add-Member ScriptMethod GetPackageFolder {
			param($PackageName, $PackageVersion, $PackageType)
			'Folder1\\Folder2'
		}

		$result = Get-CapaPackageFolder -CapaSDK $CapaSDK -PackageType 'Computer' -PackageName 'Pkg' -PackageVersion 'v1'

		$result | Should -Be 'Folder1\\Folder2'
	}
}
