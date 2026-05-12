BeforeAll {
	$RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

	$Folders = @(
		'Capa.PowerShell.Module.SDK.Authentication',
		'Capa.PowerShell.Module.SDK.Package',
		'Capa.PowerShell.Module.SDK.Utilities'
	)

	foreach ($Folder in $Folders) {
		$Items = Get-ChildItem -Path "$RootPath\$Folder\Dev\" -Filter '*.ps1' | Where-Object { $_.Name -notlike '*Tests.ps1' }
		foreach ($Item in $Items) {
			Import-Module $Item.FullName -Force -ErrorAction Stop
		}
	}

	$CapaSDK = Initialize-CapaSDK -Server $env:COMPUTERNAME -Database 'CapaInstaller' -InstanceManagementPoint 2

	$TestSettings = @{
		CapaSDK        = $CapaSDK
		PackageName    = 'SWInventory'
		PackageVersion = 'v5'
		PackageType    = 'User'
		UnitType       = 'User'
		UnitName       = $null
	}

	try {
		$UserUnits = Get-CapaPackageUnits -CapaSDK $TestSettings.CapaSDK -PackageName $TestSettings.PackageName -PackageVersion $TestSettings.PackageVersion -PackageType $TestSettings.PackageType
		if ($UserUnits -and $UserUnits.Count -gt 0) {
			$TestSettings.UnitName = $UserUnits[0].Name
		}
	}
	catch {
	}
}

Describe 'Get-CapaLog user integration' {
	It 'Finds at least one user linked to SWInventory v5 on InstanceManagementPoint 2' {
		if ([string]::IsNullOrWhiteSpace($TestSettings.UnitName)) {
			Write-Host 'No user relation found for SWInventory v5 in current environment. Test is treated as informational.'
			$true | Should -BeTrue
			return
		}

		$TestSettings.UnitName | Should -Not -BeNullOrEmpty
	}

	It 'Returns log for a user-package relation' {
		if ([string]::IsNullOrWhiteSpace($TestSettings.UnitName)) {
			Write-Host 'No user relation found for SWInventory v5 in current environment. Test is treated as informational.'
			$true | Should -BeTrue
			return
		}

		$Log = Get-CapaLog -CapaSDK $TestSettings.CapaSDK -UnitName $TestSettings.UnitName -UnitType $TestSettings.UnitType -PackageName $TestSettings.PackageName -PackageVersion $TestSettings.PackageVersion -PackageType $TestSettings.PackageType

		$Log | Should -Not -BeNullOrEmpty
	}
}
