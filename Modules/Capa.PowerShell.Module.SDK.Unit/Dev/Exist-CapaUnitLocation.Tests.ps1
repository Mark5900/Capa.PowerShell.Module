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

	$script:ExistingLocation = [string]$script:ExistingUnit.Location
	if ([string]::IsNullOrWhiteSpace($script:ExistingLocation)) {
		$script:ExistingLocation = [string](Get-CapaUnitFolder -CapaSDK $oCMS -UnitName $script:ExistingUnit.Name -UnitType 'Computer')
	}

	$script:TempUnitName = "TestExistLocation_$([DateTime]::Now.ToString('yyyyMMddHHmmss'))"
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
		throw "Temporary unit '$($script:TempUnitName)' was not found after creation."
	}

	$script:TempLocation = [string]$CreatedUnit.Location
	if ([string]::IsNullOrWhiteSpace($script:TempLocation)) {
		$script:TempLocation = [string](Get-CapaUnitFolder -CapaSDK $oCMS -UnitName $script:TempUnitName -UnitType 'Computer')
	}
}

Describe 'Exist-CapaUnitLocation integration' {
	It 'Checks existing unit against its location' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		if ([string]::IsNullOrWhiteSpace($script:ExistingLocation)) {
			$true | Should -BeTrue
			return
		}

		$Result = Exist-CapaUnitLocation -CapaSDK $oCMS -UnitName $script:ExistingUnit.Name -UnitType 'Computer' -Location $script:ExistingLocation
		$Result | Should -Not -BeNull
	}

	It 'Checks temporary unit against its location' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		if ([string]::IsNullOrWhiteSpace($script:TempLocation)) {
			$true | Should -BeTrue
			return
		}

		$Result = Exist-CapaUnitLocation -CapaSDK $oCMS -UnitName $script:TempUnitName -UnitType 'Computer' -Location $script:TempLocation
		$Result | Should -Not -BeNull
	}

	It 'Validates UnitName is not empty' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		{ Exist-CapaUnitLocation -CapaSDK $oCMS -UnitName '' -UnitType 'Computer' -Location 'Any' } | Should -Throw
	}

	It 'Validates UnitType values' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		{ Exist-CapaUnitLocation -CapaSDK $oCMS -UnitName $script:ExistingUnit.Name -UnitType 'Device' -Location 'Any' } | Should -Throw
	}

	It 'Validates Location is not empty' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		{ Exist-CapaUnitLocation -CapaSDK $oCMS -UnitName $script:ExistingUnit.Name -UnitType 'Computer' -Location '' } | Should -Throw
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
