BeforeAll {
	$script:SkipIntegration = $false
	$script:SkipReason = ''
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

	try { $oCMSDev = Initialize-CapaSDK -Server $env:COMPUTERNAME -Database 'CapaInstaller' -InstanceManagementPoint 1 } catch { $script:SkipIntegration = $true; $script:SkipReason = $_.Exception.Message; return }
	$oCMSProd = Initialize-CapaSDK -Server $env:COMPUTERNAME -Database 'CapaInstaller' -InstanceManagementPoint 2

	$script:TempUnitName = "TestPkgStatusUnit_$([DateTime]::Now.ToString('yyyyMMddHHmmss'))"
	$script:PackageName = "TestPkgStatus_$([DateTime]::Now.ToString('yyyyMMddHHmmss'))"
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

	$RelationFound = $false
	for ($i = 0; $i -lt 30; $i++) {
		Start-Sleep -Seconds 2
		$UnitPackages = Get-CapaUnitPackages -CapaSDK $oCMSProd -UnitName $script:TempUnitName -UnitType 'Computer'
		if ($null -ne ($UnitPackages | Where-Object { $_.Name -eq $script:PackageName -and $_.Version -eq $script:PackageVersion } | Select-Object -First 1)) {
			$RelationFound = $true
			break
		}
	}
	if (-not $RelationFound) {
		$script:SkipIntegration = $true
		$script:SkipReason = "Package relation for '$($script:PackageName) $($script:PackageVersion)' was not found on temp unit in allotted time."
		return
	}
}

Describe 'Get-CapaUnitPackageStatus integration' {
	It 'Returns status for package relation on temporary unit' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		$Status = Get-CapaUnitPackageStatus -CapaSDK $oCMSProd -UnitName $script:TempUnitName -UnitType 'Computer' -PackageName $script:PackageName -PackageVersion $script:PackageVersion
		$Status | Should -Not -BeNullOrEmpty
	}

	It 'Validates UnitName is not empty' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		{ Get-CapaUnitPackageStatus -CapaSDK $oCMSProd -UnitName '' -UnitType 'Computer' -PackageName $script:PackageName -PackageVersion $script:PackageVersion } | Should -Throw
	}

	It 'Validates PackageName is not empty' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		{ Get-CapaUnitPackageStatus -CapaSDK $oCMSProd -UnitName $script:TempUnitName -UnitType 'Computer' -PackageName '' -PackageVersion $script:PackageVersion } | Should -Throw
	}

	It 'Validates PackageVersion is not empty' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		{ Get-CapaUnitPackageStatus -CapaSDK $oCMSProd -UnitName $script:TempUnitName -UnitType 'Computer' -PackageName $script:PackageName -PackageVersion '' } | Should -Throw
	}

	It 'Validates UnitType values' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		{ Get-CapaUnitPackageStatus -CapaSDK $oCMSProd -UnitName $script:TempUnitName -UnitType 'Device' -PackageName $script:PackageName -PackageVersion $script:PackageVersion } | Should -Throw
	}
}

AfterAll {
	if ($script:SkipIntegration) { return }
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
