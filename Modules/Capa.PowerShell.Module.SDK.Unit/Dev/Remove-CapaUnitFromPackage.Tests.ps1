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

	$Units = Get-CapaUnits -CapaSDK $oCMSProd -Type Computer
	$script:TargetUnit = $Units | Where-Object { $_.Name -eq $env:COMPUTERNAME } | Select-Object -First 1
	if ($null -eq $script:TargetUnit) {
		throw "Computer unit '$env:COMPUTERNAME' was not found in CapaInstaller."
	}

	$script:UnitName = $script:TargetUnit.Name
	$script:PackageName = "TestRemoveUnitFromPackage_$([DateTime]::Now.ToString('yyyyMMddHHmmss'))"
	$script:PackageVersion = 'v1.0'

	$PowerPackSplatting = @{
		CapaSDK           = $oCMSDev
		PackageName       = $script:PackageName
		PackageVersion    = $script:PackageVersion
		SqlServerInstance = $env:COMPUTERNAME
		Database          = 'CapaInstaller'
	}

	New-CapaPowerPack @PowerPackSplatting | Out-Null
	Start-Sleep -Seconds 5
	Initialize-CapaPackagePromote -CapaSDK $oCMSDev -PackageName $script:PackageName -PackageVersion $script:PackageVersion -PackageType 'Computer'
	Start-Sleep -Seconds 5

	$AddStatus = Add-CapaUnitToPackage -CapaSDK $oCMSProd -PackageType 'Computer' -PackageName $script:PackageName -PackageVersion $script:PackageVersion -UnitName $script:UnitName -UnitType 'Computer'
	$AddStatus | Should -Be $true
}

Describe 'Remove-CapaUnitFromPackage integration' {
	It 'Removes package relation from existing unit' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		$Result = Remove-CapaUnitFromPackage -CapaSDK $oCMSProd -PackageName $script:PackageName -PackageVersion $script:PackageVersion -PackageType 'Computer' -UnitName $script:UnitName -UnitType 'Computer' -Confirm:$false
		$Result | Should -Be $true

		$RelationExists = $true
		for ($i = 0; $i -lt 10; $i++) {
			Start-Sleep -Seconds 2
			$UnitPackages = Get-CapaUnitPackages -CapaSDK $oCMSProd -UnitName $script:UnitName -UnitType 'Computer'
			$CurrentRelation = $UnitPackages | Where-Object { $_.Name -eq $script:PackageName -and $_.Version -eq $script:PackageVersion } | Select-Object -First 1
			if ($null -eq $CurrentRelation) {
				$RelationExists = $false
				break
			}
		}

		$RelationExists | Should -BeFalse
	}

	It 'Does not remove when using WhatIf' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		$Result = Remove-CapaUnitFromPackage -CapaSDK $oCMSProd -PackageName $script:PackageName -PackageVersion $script:PackageVersion -PackageType 'Computer' -UnitName $script:UnitName -UnitType 'Computer' -WhatIf -Confirm:$false
		$Result | Should -BeNullOrEmpty
	}

	It 'Validates PackageName is not empty' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		{ Remove-CapaUnitFromPackage -CapaSDK $oCMSProd -PackageName '' -PackageVersion $script:PackageVersion -PackageType 'Computer' -UnitName $script:UnitName -UnitType 'Computer' -Confirm:$false } | Should -Throw
	}

	It 'Validates UnitName is not empty' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		{ Remove-CapaUnitFromPackage -CapaSDK $oCMSProd -PackageName $script:PackageName -PackageVersion $script:PackageVersion -PackageType 'Computer' -UnitName '' -UnitType 'Computer' -Confirm:$false } | Should -Throw
	}

	It 'Validates UnitType values' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		{ Remove-CapaUnitFromPackage -CapaSDK $oCMSProd -PackageName $script:PackageName -PackageVersion $script:PackageVersion -PackageType 'Computer' -UnitName $script:UnitName -UnitType 'Device' -Confirm:$false } | Should -Throw
	}
}

AfterAll {
	if ($script:SkipIntegration) { return }
	if ($null -ne $script:PackageName -and $null -ne $script:PackageVersion) {
		$PackageSplatting = @{
			CapaSDK        = $oCMSProd
			PackageName    = $script:PackageName
			PackageVersion = $script:PackageVersion
			PackageType    = 'Computer'
			Force          = $true
		}

		try { Remove-CapaPackage @PackageSplatting | Out-Null } catch {}
		$PackageSplatting.CapaSDK = $oCMSDev
		try { Remove-CapaPackage @PackageSplatting | Out-Null } catch {}
	}
}
