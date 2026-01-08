BeforeAll {
	# Import file
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
	$RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

    $Folders = @(
        'Capa.PowerShell.Module.SDK.Authentication',
        'Capa.PowerShell.Module.SDK.Package'
    )
    foreach ($Folder in $Folders) {
        $Items = Get-ChildItem -Path "$RootPath\$Folder\Dev\" -Filter '*.ps1' | Where-Object { $_.Name -notlike '*Tests.ps1' }
        foreach ($Item in $Items) {
            Import-Module $Item.FullName -Force -ErrorAction Stop
        }
    }

	$CapaSDK = Initialize-CapaSDK -Server $env:COMPUTERNAME -Database 'CapaInstaller' -InstanceManagementPoint 1

	$TestSettings = @{
		CapaSDK        = $CapaSDK
		PackageName    = 'Test1'
		PackageVersion = 'v1.0'
		UnitType       = 'Computer'
		DisplayName    = 'Test Package'
	}
}
Describe 'Create a new package' {
	It 'Does the function work' {
		$Status = New-CapaPackage @TestSettings
		$Status | Should -Be $true
	}
	It 'Does the package exist' {
		$Package = Exist-CapaPackage -CapaSDK $CapaSDK -Name $TestSettings.PackageName -Version $TestSettings.PackageVersion -Type $TestSettings.UnitType
		$Package | Should -Be $true
	}
}
AfterAll {
	$PackageSplatting = @{
		CapaSDK        = $CapaSDK
		PackageName    = $TestSettings.PackageName
		PackageVersion = $TestSettings.PackageVersion
		PackageType    = $TestSettings.UnitType
	}
	Remove-CapaPackage @PackageSplatting
}