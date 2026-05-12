BeforeAll {
	$script:SkipIntegration = $false
	$script:SkipReason = ''
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
	$RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

	$Folders = @(
		'Capa.PowerShell.Module.SDK.Authentication',
		'Capa.PowerShell.Module.SDK.Unit'
	)
	foreach ($Folder in $Folders) {
		$Items = Get-ChildItem -Path "$RootPath\$Folder\Dev\" -Filter '*.ps1' | Where-Object { $_.Name -notlike '*Tests.ps1' }
		foreach ($Item in $Items) {
			Import-Module $Item.FullName -Force -ErrorAction Stop
		}
	}

	try { $oCMS = Initialize-CapaSDK -Server $env:COMPUTERNAME -Database 'CapaInstaller' -InstanceManagementPoint 2 } catch { $script:SkipIntegration = $true; $script:SkipReason = $_.Exception.Message; return }

	$Units = Get-CapaUnits -CapaSDK $oCMS -Type Computer
	$script:ExistingUnit = $Units | Where-Object { $_.Name -eq $env:COMPUTERNAME } | Select-Object -First 1
	if ($null -eq $script:ExistingUnit) {
		throw "Computer unit '$env:COMPUTERNAME' was not found in CapaInstaller."
	}

	$script:TempUnitName = "TestLinkedUnitsComp_$([DateTime]::Now.ToString('yyyyMMddHHmmss'))"
	Create-CapaUnit -CapaSDK $oCMS -UnitName $script:TempUnitName -UnitType 'Computer' -LinkToManagementServerID 2 | Out-Null

	$CreatedUnit = $null
	for ($i = 0; $i -lt 20; $i++) {
		Start-Sleep -Seconds 2
		$CreatedUnit = Get-CapaUnits -CapaSDK $oCMS -Type Computer | Where-Object { $_.Name -eq $script:TempUnitName } | Select-Object -First 1
		if ($null -ne $CreatedUnit) {
			break
		}
	}
	if ($null -eq $CreatedUnit) {
		throw "Temporary computer unit '$($script:TempUnitName)' was not found after creation."
	}
}

Describe 'Get-CapaUnitLinkedUnits integration' {
	It 'Queries linked units for existing unit without throwing' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		{ Get-CapaUnitLinkedUnits -CapaSDK $oCMS -UnitName $script:ExistingUnit.Name -UnitType 'Computer' } | Should -Not -Throw
	}

	It 'Queries linked units for temporary unit without throwing' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		{ Get-CapaUnitLinkedUnits -CapaSDK $oCMS -UnitName $script:TempUnitName -UnitType 'Computer' } | Should -Not -Throw
	}

	It 'Returns expected properties when linked units are returned' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		$Result = Get-CapaUnitLinkedUnits -CapaSDK $oCMS -UnitName $script:ExistingUnit.Name -UnitType 'Computer'
		if ($null -ne $Result -and $Result.Count -gt 0) {
			$Properties = $Result[0].PSObject.Properties.Name
			$Properties -contains 'Name' | Should -BeTrue
			$Properties -contains 'GUID' | Should -BeTrue
			$Properties -contains 'TypeName' | Should -BeTrue
		} else {
			$true | Should -BeTrue
		}
	}

	It 'Validates UnitName is not empty' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		{ Get-CapaUnitLinkedUnits -CapaSDK $oCMS -UnitName '' -UnitType 'Computer' } | Should -Throw
	}

	It 'Validates UnitType values' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		{ Get-CapaUnitLinkedUnits -CapaSDK $oCMS -UnitName $script:ExistingUnit.Name -UnitType 'Device' } | Should -Throw
	}
}

AfterAll {
	if ($script:SkipIntegration) { return }
	if (-not [string]::IsNullOrWhiteSpace($script:TempUnitName)) {
		$TempUnit = Get-CapaUnits -CapaSDK $oCMS -Type Computer | Where-Object { $_.Name -eq $script:TempUnitName } | Select-Object -First 1
		if ($null -ne $TempUnit) {
			try {
				Delete-CapaUnit -CapaSDK $oCMS -UnitName $script:TempUnitName -UnitType 'Computer' | Out-Null
			} catch {}
		}
	}
}
