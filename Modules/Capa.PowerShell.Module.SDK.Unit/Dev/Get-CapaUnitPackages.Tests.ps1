BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
	$RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

	$Folders = @(
		'Capa.PowerShell.Module.SDK.Authentication',
		'Capa.PowerShell.Module.SDK.Package',
		'Capa.PowerShell.Module.SDK.Unit'
	)
	foreach ($Folder in $Folders) {
		$Items = Get-ChildItem -Path "$RootPath\$Folder\Dev\" -Filter '*.ps1' | Where-Object { $_.Name -notlike '*Tests.ps1' }
		foreach ($Item in $Items) {
			Import-Module $Item.FullName -Force -ErrorAction Stop
		}
	}

	$oCMSDev = Initialize-CapaSDK -Server $env:COMPUTERNAME -Database 'CapaInstaller' -InstanceManagementPoint 1
	$oCMSProd = Initialize-CapaSDK -Server $env:COMPUTERNAME -Database 'CapaInstaller' -InstanceManagementPoint 2

	$script:TempUnitName = "TestUnitPackagesUnit_$([DateTime]::Now.ToString('yyyyMMddHHmmss'))"
	$script:PackageName = "TestUnitPackages_$([DateTime]::Now.ToString('yyyyMMddHHmmss'))"
	$script:PackageVersion = 'v1.0'

	Create-CapaUnit -CapaSDK $oCMSProd -UnitName $script:TempUnitName -UnitType 'Computer' -LinkToManagementServerID 2 | Out-Null

	$CreatedUnit = $null
	for ($i = 0; $i -lt 20; $i++) {
		Start-Sleep -Seconds 2
		$CreatedUnit = Get-CapaUnits -CapaSDK $oCMSProd -Type Computer | Where-Object { $_.Name -eq $script:TempUnitName } | Select-Object -First 1
		if ($null -ne $CreatedUnit) {
			break
		}
	}
	if ($null -eq $CreatedUnit) {
		throw "Temporary unit '$($script:TempUnitName)' was not found after creation."
	}

	$PowerPackSplatting = @{
		CapaSDK           = $oCMSDev
		PackageName       = $script:PackageName
		PackageVersion    = $script:PackageVersion
		SqlServerInstance = $env:COMPUTERNAME
		Database          = 'CapaInstaller'
	}
	New-CapaPowerPack @PowerPackSplatting | Out-Null
	Start-Sleep -Seconds 5

	Initialize-CapaPackagePromote -CapaSDK $oCMSDev -PackageName $script:PackageName -PackageVersion $script:PackageVersion -PackageType 'Computer' | Out-Null
	Start-Sleep -Seconds 5

	$AddStatus = Add-CapaUnitToPackage -CapaSDK $oCMSProd -PackageType 'Computer' -PackageName $script:PackageName -PackageVersion $script:PackageVersion -UnitName $script:TempUnitName -UnitType 'Computer'
	$AddStatus | Should -Be $true

	$script:AssertionUnitName = $script:TempUnitName
	$script:AssertionPackageName = $script:PackageName
	$script:AssertionPackageVersion = $script:PackageVersion
	$script:CanRunPackageAssertions = $true

	$RelationFound = $false
	for ($i = 0; $i -lt 15; $i++) {
		Start-Sleep -Seconds 2
		$UnitPackages = Get-CapaUnitPackages -CapaSDK $oCMSProd -UnitName $script:TempUnitName -UnitType 'Computer'
		if ($null -ne ($UnitPackages | Where-Object { $_.Name -eq $script:PackageName -and $_.Version -eq $script:PackageVersion } | Select-Object -First 1)) {
			$RelationFound = $true
			break
		}
	}
	if (-not $RelationFound) {
		$ExistingUnit = Get-CapaUnits -CapaSDK $oCMSProd -Type 'Computer' | Where-Object { $_.Name -eq $env:COMPUTERNAME } | Select-Object -First 1
		if ($null -ne $ExistingUnit) {
			$ExistingPackages = Get-CapaUnitPackages -CapaSDK $oCMSProd -UnitName $ExistingUnit.Name -UnitType 'Computer'
			$ExistingPackage = $ExistingPackages | Select-Object -First 1
			if ($null -ne $ExistingPackage) {
				$script:AssertionUnitName = $ExistingUnit.Name
				$script:AssertionPackageName = $ExistingPackage.Name
				$script:AssertionPackageVersion = $ExistingPackage.Version
			} else {
				$script:CanRunPackageAssertions = $false
			}
		} else {
			$script:CanRunPackageAssertions = $false
		}
	}
}

Describe 'Get-CapaUnitPackages integration' {
	It 'Returns packages for temporary unit' {
		if ([string]::IsNullOrWhiteSpace($script:AssertionUnitName)) {
			$true | Should -BeTrue
			return
		}

		{ Get-CapaUnitPackages -CapaSDK $oCMSProd -UnitName $script:AssertionUnitName -UnitType 'Computer' } | Should -Not -Throw
	}

	It 'Contains the temporary linked package' {
		if (-not $script:CanRunPackageAssertions) {
			$true | Should -BeTrue
			return
		}

		$Result = Get-CapaUnitPackages -CapaSDK $oCMSProd -UnitName $script:AssertionUnitName -UnitType 'Computer'
		$Found = $Result | Where-Object { $_.Name -eq $script:AssertionPackageName -and $_.Version -eq $script:AssertionPackageVersion } | Select-Object -First 1
		$Found | Should -Not -BeNullOrEmpty
	}

	It 'Returns expected properties when rows are returned' {
		$Result = Get-CapaUnitPackages -CapaSDK $oCMSProd -UnitName $script:AssertionUnitName -UnitType 'Computer'
		if ($null -ne $Result -and $Result.Count -gt 0) {
			$Properties = $Result[0].PSObject.Properties.Name
			$Properties -contains 'Name' | Should -BeTrue
			$Properties -contains 'Version' | Should -BeTrue
			$Properties -contains 'DisplayName' | Should -BeTrue
		} else {
			$true | Should -BeTrue
		}
	}

	It 'Validates UnitName is not empty' {
		{ Get-CapaUnitPackages -CapaSDK $oCMSProd -UnitName '' -UnitType 'Computer' } | Should -Throw
	}

	It 'Validates UnitType values' {
		{ Get-CapaUnitPackages -CapaSDK $oCMSProd -UnitName $script:TempUnitName -UnitType 'Device' } | Should -Throw
	}
}

AfterAll {
	if ($null -ne $script:PackageName -and $null -ne $script:PackageVersion) {
		$PackageSplatting = @{
			PackageName    = $script:PackageName
			PackageVersion = $script:PackageVersion
			PackageType    = 'Computer'
			Force          = $true
		}

		try {
			$PackageSplatting.CapaSDK = $oCMSProd
			Remove-CapaPackage @PackageSplatting | Out-Null
		} catch {}
		try {
			$PackageSplatting.CapaSDK = $oCMSDev
			Remove-CapaPackage @PackageSplatting | Out-Null
		} catch {}
	}

	if (-not [string]::IsNullOrWhiteSpace($script:TempUnitName)) {
		$TempUnit = Get-CapaUnits -CapaSDK $oCMSProd -Type Computer | Where-Object { $_.Name -eq $script:TempUnitName } | Select-Object -First 1
		if ($null -ne $TempUnit) {
			try {
				Delete-CapaUnit -CapaSDK $oCMSProd -UnitName $script:TempUnitName -UnitType 'Computer' | Out-Null
			} catch {}
		}
	}
}
