BeforeAll {
	# Import file
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
	$RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

	Import-Module "$RootPath\Capa.PowerShell.Module.SDK.Package\Dev\Get-CapaPackageFolder.ps1"
	Import-Module "$RootPath\Capa.PowerShell.Module.SDK.Package\Dev\New-CapaPackage.ps1"
	Import-Module "$RootPath\Capa.PowerShell.Module.SDK.Authentication\Dev\Initialize-CapaSDK.ps1"
	Import-Module "$RootPath\Capa.PowerShell.Module.SDK.Package\Dev\Remove-CapaPackage.ps1"

	$CapaSDK = Initialize-CapaSDK -Server $env:COMPUTERNAME -Database 'CapaInstaller' -InstanceManagementPoint 1

	$FolderStructure = 'Test1\Test2'
}
Describe 'Test with a new package' {
	It 'Should create a new package' {
		$PackageSpllatting = @{
			CapaSDK        = $CapaSDK
			PackageName    = 'Test1'
			PackageVersion = 'v1.0'
			UnitType       = 'Computer'
			DisplayName    = 'Test1 v1.0'
		}
		$bStatus = New-CapaPackage @PackageSpllatting
		$bStatus | Should -Be $true
	}
	It 'Should set the folder structure of the package' {
		$ChangelogText = 'This is a changelog'
		$bStatus = Set-CapaPackageFolder -CapaSDK $CapaSDK -PackageType 'Computer' -PackageName 'Test1' -PackageVersion 'v1.0' -FolderStructure $FolderStructure -ChangelogText $ChangelogText
		$bStatus | Should -Be $true
	}
	It 'The package should be in the folder' {
		$PackageFolder = Get-CapaPackageFolder -CapaSDK $CapaSDK -PackageType 'Computer' -PackageName 'Test1' -PackageVersion 'v1.0'
		$PackageFolder | Should -BeLike "$FolderStructure*"
	}
}
Describe 'Test with a package allready in the folder' {
	It 'Move to same folder' {
		$bStatus = Set-CapaPackageFolder -CapaSDK $CapaSDK -PackageType 'Computer' -PackageName 'Test1' -PackageVersion 'v1.0' -FolderStructure $FolderStructure -ChangelogText $ChangelogText
		$bStatus | Should -Be $true
	}
	It 'The package should be in the folder' {
		$PackageFolder = Get-CapaPackageFolder -CapaSDK $CapaSDK -PackageType 'Computer' -PackageName 'Test1' -PackageVersion 'v1.0'
		$PackageFolder | Should -BeLike "$FolderStructure*"
	}
}
AfterAll {
	Remove-CapaPackage -CapaSDK $CapaSDK -PackageName 'Test1' -PackageVersion 'v1.0' -PackageType 'Computer' -Force True
	Get-Module | Remove-Module
}