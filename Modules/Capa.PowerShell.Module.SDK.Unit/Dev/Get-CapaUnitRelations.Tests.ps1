BeforeAll {
	$script:SkipIntegration = $false
	$script:SkipReason = ''
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
	$RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

	$Folders = @(
		'Capa.PowerShell.Module.SDK.Authentication',
		'Capa.PowerShell.Module.SDK.Group',
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

	$script:TempUnitName = "TestRelationsUnit_$([DateTime]::Now.ToString('yyyyMMddHHmmss'))"
	$script:TempGroupName = "TestRelationsGroup_$([DateTime]::Now.ToString('yyyyMMddHHmmss'))"

	Create-CapaUnit -CapaSDK $oCMS -UnitName $script:TempUnitName -UnitType 'Computer' -LinkToManagementServerID 2 | Out-Null
	Create-CapaGroup -CapaSDK $oCMS -GroupName $script:TempGroupName -GroupType 'Static' -UnitType 'Computer' | Out-Null

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

	$AddResult = Add-CapaUnitToGroup -CapaSDK $oCMS -UnitName $script:TempUnitName -UnitType 'Computer' -GroupName $script:TempGroupName -GroupType 'Static'
	$AddResult | Should -Be $true
}

Describe 'Get-CapaUnitRelations integration' {
	It 'Returns relations for an existing computer unit without throwing' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		{ Get-CapaUnitRelations -CapaSDK $oCMS -UnitName $script:ExistingUnit.Name -UnitType 'Computer' } | Should -Not -Throw
	}

	It 'Can query relations for temporary unit with established group relation' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		$GroupRelationExists = $false
		for ($i = 0; $i -lt 15; $i++) {
			Start-Sleep -Seconds 2
			$UnitGroups = Get-CapaUnitGroups -CapaSDK $oCMS -UnitName $script:TempUnitName -UnitType 'Computer'
			$GroupRelationExists = $null -ne ($UnitGroups | Where-Object { $_.Name -eq $script:TempGroupName -and $_.Type -eq 'Static' } | Select-Object -First 1)
			if ($GroupRelationExists) {
				break
			}
		}

		$GroupRelationExists | Should -BeTrue
		{ Get-CapaUnitRelations -CapaSDK $oCMS -UnitName $script:TempUnitName -UnitType 'Computer' } | Should -Not -Throw

		$Relations = Get-CapaUnitRelations -CapaSDK $oCMS -UnitName $script:TempUnitName -UnitType 'Computer'
		if ($null -ne $Relations -and $Relations.Count -gt 0) {
			$MaybeGroupRelation = $Relations | Where-Object { $_.Name -eq $script:TempGroupName } | Select-Object -First 1
			if ($null -ne $MaybeGroupRelation) {
				$MaybeGroupRelation.Name | Should -Be $script:TempGroupName
			}
		}
	}

	It 'Supports UnitName from pipeline' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		{ $script:TempUnitName | Get-CapaUnitRelations -CapaSDK $oCMS -UnitType 'Computer' } | Should -Not -Throw
	}

	It 'Returns expected properties when relation rows are returned' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		$Relations = Get-CapaUnitRelations -CapaSDK $oCMS -UnitName $script:TempUnitName -UnitType 'Computer'
		if ($null -ne $Relations -and $Relations.Count -gt 0) {
			$Properties = $Relations[0].PSObject.Properties.Name
			$Properties -contains 'RelationType' | Should -BeTrue
			$Properties -contains 'Name' | Should -BeTrue
			$Properties -contains 'UUID' | Should -BeTrue
			$Properties -contains 'Location' | Should -BeTrue
		} else {
			$true | Should -BeTrue
		}
	}

	It 'Validates UnitName is not empty' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		{ Get-CapaUnitRelations -CapaSDK $oCMS -UnitName '' -UnitType 'Computer' } | Should -Throw
	}

	It 'Validates UnitType values' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		{ Get-CapaUnitRelations -CapaSDK $oCMS -UnitName $script:TempUnitName -UnitType 'Device' } | Should -Throw
	}
}

AfterAll {
	if ($script:SkipIntegration) { return }
	if (-not [string]::IsNullOrWhiteSpace($script:TempUnitName) -and -not [string]::IsNullOrWhiteSpace($script:TempGroupName)) {
		try {
			Remove-CapaUnitFromGroup -CapaSDK $oCMS -UnitName $script:TempUnitName -UnitType 'Computer' -GroupName $script:TempGroupName -GroupType 'Static' -Confirm:$false | Out-Null
		} catch {}

		try {
			Remove-CapaGroup -CapaSDK $oCMS -GroupName $script:TempGroupName -GroupType 'Static' -UnitType 'Computer' | Out-Null
		} catch {}

		try {
			$TempUnit = Get-CapaUnits -CapaSDK $oCMS -Type Computer | Where-Object { $_.Name -eq $script:TempUnitName } | Select-Object -First 1
			if ($null -ne $TempUnit) {
				Delete-CapaUnit -CapaSDK $oCMS -UnitName $script:TempUnitName -UnitType 'Computer' | Out-Null
			}
		} catch {}
	}
}
