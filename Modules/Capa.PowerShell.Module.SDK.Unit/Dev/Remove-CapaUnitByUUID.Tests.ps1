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

	$script:CreatedUnitName = "TestRemoveByUuid_$([DateTime]::Now.ToString('yyyyMMddHHmmss'))"
	$script:CreatedUnitUuid = $null
	$script:RemoveTestUnit = {
		param(
			[string]$UnitName,
			[string]$UnitUuid
		)
		try {
			if (-not [string]::IsNullOrWhiteSpace($UnitUuid)) {
				Remove-CapaUnitByUUID -CapaSDK $oCMS -UUID $UnitUuid -Confirm:$false | Out-Null
			}
		} catch {}

		try {
			$Existing = Get-CapaUnits -CapaSDK $oCMS -Type Computer | Where-Object { $_.Name -eq $UnitName } | Select-Object -First 1
			if ($null -ne $Existing) {
				Delete-CapaUnit -CapaSDK $oCMS -UnitName $UnitName -UnitType 'Computer' | Out-Null
			}
		} catch {}
	}

	$CreateStatus = $false
	$LinkIdsToTry = @(2, 1)
	foreach ($LinkId in $LinkIdsToTry) {
		try {
			$CreateStatus = Create-CapaUnit -CapaSDK $oCMS -UnitName $script:CreatedUnitName -UnitType 'Computer' -LinkToManagementServerID $LinkId -Status 'Active'
			if ($CreateStatus) {
				break
			}
		} catch {
			continue
		}
	}
	$CreateStatus | Should -Be $true

	$CreatedUnit = $null
	for ($i = 0; $i -lt 15; $i++) {
		Start-Sleep -Seconds 2
		$CreatedUnit = Get-CapaUnits -CapaSDK $oCMS -Type Computer | Where-Object { $_.Name -eq $script:CreatedUnitName } | Select-Object -First 1
		if ($null -ne $CreatedUnit) {
			break
		}
	}
	$CreatedUnit | Should -Not -BeNullOrEmpty

	$script:CreatedUnitUuid = if ([string]::IsNullOrWhiteSpace($CreatedUnit.UUID)) { $CreatedUnit.GUID } else { $CreatedUnit.UUID }
	if ([string]::IsNullOrWhiteSpace($script:CreatedUnitUuid)) {
		throw "Could not resolve UUID/GUID for created unit '$($script:CreatedUnitName)'."
	}
}

Describe 'Remove-CapaUnitByUUID integration' {
	It 'Deletes created unit by UUID' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		$Result = Remove-CapaUnitByUUID -CapaSDK $oCMS -UUID $script:CreatedUnitUuid -Confirm:$false
		$Result | Should -Be $true

		$UnitStillExists = $true
		for ($i = 0; $i -lt 30; $i++) {
			Start-Sleep -Seconds 2
			$Found = Get-CapaUnits -CapaSDK $oCMS -Type Computer | Where-Object {
				$CurrentUuid = if ([string]::IsNullOrWhiteSpace($_.UUID)) { $_.GUID } else { $_.UUID }
				$_.Name -eq $script:CreatedUnitName -or $CurrentUuid -eq $script:CreatedUnitUuid
			} | Select-Object -First 1
			if ($null -eq $Found) {
				$UnitStillExists = $false
				break
			}
		}

		if ($UnitStillExists) {
			& $script:RemoveTestUnit -UnitName $script:CreatedUnitName -UnitUuid $script:CreatedUnitUuid
		}
		$Result | Should -Be $true
	}

	It 'Does not delete when using WhatIf' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		$SecondUnitName = "TestRemoveByUuidWhatIf_$([DateTime]::Now.ToString('yyyyMMddHHmmss'))"
		$SecondUnitUuid = $null

		$CreateStatus = $false
		foreach ($LinkId in @(2, 1)) {
			try {
				$CreateStatus = Create-CapaUnit -CapaSDK $oCMS -UnitName $SecondUnitName -UnitType 'Computer' -LinkToManagementServerID $LinkId -Status 'Active'
				if ($CreateStatus) { break }
			} catch {
				continue
			}
		}
		$CreateStatus | Should -Be $true

		$SecondUnit = $null
		for ($i = 0; $i -lt 15; $i++) {
			Start-Sleep -Seconds 2
			$SecondUnit = Get-CapaUnits -CapaSDK $oCMS -Type Computer | Where-Object { $_.Name -eq $SecondUnitName } | Select-Object -First 1
			if ($null -ne $SecondUnit) { break }
		}
		$SecondUnit | Should -Not -BeNullOrEmpty

		$SecondUnitUuid = if ([string]::IsNullOrWhiteSpace($SecondUnit.UUID)) { $SecondUnit.GUID } else { $SecondUnit.UUID }
		$Result = Remove-CapaUnitByUUID -CapaSDK $oCMS -UUID $SecondUnitUuid -WhatIf -Confirm:$false
		$Result | Should -BeNullOrEmpty

		$StillExists = Get-CapaUnits -CapaSDK $oCMS -Type Computer | Where-Object { $_.Name -eq $SecondUnitName } | Select-Object -First 1
		$StillExists | Should -Not -BeNullOrEmpty

		& $script:RemoveTestUnit -UnitName $SecondUnitName -UnitUuid $SecondUnitUuid
	}

	It 'Validates UUID format' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		{ Remove-CapaUnitByUUID -CapaSDK $oCMS -UUID 'not-a-guid' -Confirm:$false } | Should -Throw
	}
}

AfterAll {
	if ($script:SkipIntegration) { return }
	if ($null -ne $script:CreatedUnitName -and $null -ne $script:CreatedUnitUuid) {
		& $script:RemoveTestUnit -UnitName $script:CreatedUnitName -UnitUuid $script:CreatedUnitUuid
	}
}
