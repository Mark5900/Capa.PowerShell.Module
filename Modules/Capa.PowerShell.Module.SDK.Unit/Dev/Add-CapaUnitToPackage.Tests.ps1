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

	try { $script:oCMSDev = Initialize-CapaSDK -Server $env:COMPUTERNAME -Database 'CapaInstaller' -InstanceManagementPoint 1 } catch { $script:SkipIntegration = $true; $script:SkipReason = $_.Exception.Message; return }
	$script:oCMSProd = Initialize-CapaSDK -Server $env:COMPUTERNAME -Database 'CapaInstaller' -InstanceManagementPoint 2

	$script:UnitName = "PesterUnitPkgAdd_$([guid]::NewGuid().ToString('N').Substring(0, 8))"
	$script:PackageName = "TestAddUnitToPackage_$([DateTime]::Now.ToString('yyyyMMddHHmmss'))"
	$script:PackageVersion = 'v1.0'

	$null = Create-CapaUnit -CapaSDK $script:oCMSProd -UnitName $script:UnitName -UnitType 'Computer' -LinkToManagementServerID 2

	$PowerPackSplatting = @{
		CapaSDK           = $script:oCMSDev
		PackageName       = $script:PackageName
		PackageVersion    = $script:PackageVersion
		SqlServerInstance = $env:COMPUTERNAME
		Database          = 'CapaInstaller'
	}

	New-CapaPowerPack @PowerPackSplatting | Out-Null
	Start-Sleep -Seconds 5
	Initialize-CapaPackagePromote -CapaSDK $script:oCMSDev -PackageName $script:PackageName -PackageVersion $script:PackageVersion -PackageType 'Computer'
	Start-Sleep -Seconds 5
}

Describe 'Add-CapaUnitToPackage' {
	It 'Adds a unit to a package and returns true' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		$result = Add-CapaUnitToPackage -CapaSDK $script:oCMSProd -PackageType 'Computer' -PackageName $script:PackageName -PackageVersion $script:PackageVersion -UnitName $script:UnitName -UnitType 'Computer' -Confirm:$false
		$result | Should -BeTrue

		$relationFound = $false
		for ($i = 0; $i -lt 30; $i++) {
			Start-Sleep -Seconds 2
			$rawPackages = @($script:oCMSProd.GetUnitPackages($script:UnitName, 'Computer'))
			$relationFound = $rawPackages | Where-Object { $_ -like "$($script:PackageName);$($script:PackageVersion);*" } | Select-Object -First 1
			if ($relationFound) {
				break
			}
		}

		$relationFound | Should -BeTrue
	}

	It 'Supports -WhatIf and does not make changes' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		$newUnitName = "PesterUnitPkgWhatIf_$([guid]::NewGuid().ToString('N').Substring(0, 8))"
		$null = Create-CapaUnit -CapaSDK $script:oCMSProd -UnitName $newUnitName -UnitType 'Computer' -LinkToManagementServerID 2

		try {
			$whatIfResult = Add-CapaUnitToPackage -CapaSDK $script:oCMSProd -PackageType 'Computer' -PackageName $script:PackageName -PackageVersion $script:PackageVersion -UnitName $newUnitName -UnitType 'Computer' -WhatIf -Confirm:$false
			$whatIfResult | Should -BeNullOrEmpty

			$rawPackages = @($script:oCMSProd.GetUnitPackages($newUnitName, 'Computer'))
			$relationFound = $rawPackages | Where-Object { $_ -like "$($script:PackageName);$($script:PackageVersion);*" } | Select-Object -First 1
			$relationFound | Should -BeNullOrEmpty
		}
		finally {
			$null = Delete-CapaUnit -CapaSDK $script:oCMSProd -UnitName $newUnitName -UnitType 'Computer' -Confirm:$false
		}
	}

	It 'Throws when CapaSDK method is missing' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		$mockSdk = [pscustomobject]@{}
		{
			Add-CapaUnitToPackage -CapaSDK $mockSdk -PackageType 'Computer' -PackageName $script:PackageName -PackageVersion $script:PackageVersion -UnitName $script:UnitName -UnitType 'Computer'
		} | Should -Throw 'CapaSDK does not contain method AddUnitToPackage.'
	}

	It 'Validates PackageType values' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		{
			Add-CapaUnitToPackage -CapaSDK $script:oCMSProd -PackageType 'InvalidType' -PackageName $script:PackageName -PackageVersion $script:PackageVersion -UnitName $script:UnitName -UnitType 'Computer'
		} | Should -Throw
	}
}

AfterAll {
	if ($script:SkipIntegration) { return }
	if ($null -ne $script:PackageName -and $null -ne $script:PackageVersion) {
		$PackageSplatting = @{
			CapaSDK        = $script:oCMSProd
			PackageName    = $script:PackageName
			PackageVersion = $script:PackageVersion
			PackageType    = 'Computer'
			Force          = $true
		}

		try { Remove-CapaPackage @PackageSplatting | Out-Null } catch {}
		$PackageSplatting.CapaSDK = $script:oCMSDev
		try { Remove-CapaPackage @PackageSplatting | Out-Null } catch {}
	}

	if ($null -ne $script:UnitName) {
		try {
			$null = Delete-CapaUnit -CapaSDK $script:oCMSProd -UnitName $script:UnitName -UnitType 'Computer' -Confirm:$false
		}
		catch {}
	}
}
