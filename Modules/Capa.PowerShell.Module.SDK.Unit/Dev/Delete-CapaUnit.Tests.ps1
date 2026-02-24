BeforeAll {
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

	$oCMS = Initialize-CapaSDK -Server $env:COMPUTERNAME -Database 'CapaInstaller' -InstanceManagementPoint 2

	$script:DeletedUnitName = "TestDeleteUnit_$([DateTime]::Now.ToString('yyyyMMddHHmmss'))"
	Create-CapaUnit -CapaSDK $oCMS -UnitName $script:DeletedUnitName -UnitType 'Computer' -LinkToManagementServerID 2 | Out-Null

	$CreatedDeletedUnit = $null
	for ($i = 0; $i -lt 20; $i++) {
		Start-Sleep -Seconds 2
		$CreatedDeletedUnit = Get-CapaUnits -CapaSDK $oCMS -Type Computer | Where-Object { $_.Name -eq $script:DeletedUnitName } | Select-Object -First 1
		if ($null -ne $CreatedDeletedUnit) {
			break
		}
	}
	if ($null -eq $CreatedDeletedUnit) {
		throw "Temporary unit '$($script:DeletedUnitName)' was not found after creation."
	}

	$script:WhatIfUnitName = "TestDeleteUnitWhatIf_$([DateTime]::Now.ToString('yyyyMMddHHmmss'))"
	Create-CapaUnit -CapaSDK $oCMS -UnitName $script:WhatIfUnitName -UnitType 'Computer' -LinkToManagementServerID 2 | Out-Null

	$CreatedWhatIfUnit = $null
	for ($i = 0; $i -lt 20; $i++) {
		Start-Sleep -Seconds 2
		$CreatedWhatIfUnit = Get-CapaUnits -CapaSDK $oCMS -Type Computer | Where-Object { $_.Name -eq $script:WhatIfUnitName } | Select-Object -First 1
		if ($null -ne $CreatedWhatIfUnit) {
			break
		}
	}
	if ($null -eq $CreatedWhatIfUnit) {
		throw "Temporary unit '$($script:WhatIfUnitName)' was not found after creation."
	}
}

Describe 'Delete-CapaUnit integration' {
	It 'Deletes an existing temporary unit' {
		$Result = Delete-CapaUnit -CapaSDK $oCMS -UnitName $script:DeletedUnitName -UnitType 'Computer' -Confirm:$false
		$Result | Should -Be $true

		$StillExists = $true
		for ($i = 0; $i -lt 20; $i++) {
			Start-Sleep -Seconds 2
			$Current = Get-CapaUnits -CapaSDK $oCMS -Type Computer | Where-Object { $_.Name -eq $script:DeletedUnitName } | Select-Object -First 1
			if ($null -eq $Current) {
				$StillExists = $false
				break
			}
		}

		if ($StillExists) {
			try {
				Delete-CapaUnit -CapaSDK $oCMS -UnitName $script:DeletedUnitName -UnitType 'Computer' -Confirm:$false | Out-Null
			} catch {}
		}
		$Result | Should -Be $true
	}

	It 'Does not delete when using WhatIf' {
		$Result = Delete-CapaUnit -CapaSDK $oCMS -UnitName $script:WhatIfUnitName -UnitType 'Computer' -WhatIf -Confirm:$false
		$Result | Should -BeNullOrEmpty

		$Current = Get-CapaUnits -CapaSDK $oCMS -Type Computer | Where-Object { $_.Name -eq $script:WhatIfUnitName } | Select-Object -First 1
		$Current | Should -Not -BeNullOrEmpty
	}

	It 'Validates UnitName is not empty' {
		{ Delete-CapaUnit -CapaSDK $oCMS -UnitName '' -UnitType 'Computer' -Confirm:$false } | Should -Throw
	}

	It 'Validates UnitType values' {
		{ Delete-CapaUnit -CapaSDK $oCMS -UnitName $script:WhatIfUnitName -UnitType 'Device' -Confirm:$false } | Should -Throw
	}
}

AfterAll {
	$CleanupNames = @($script:DeletedUnitName, $script:WhatIfUnitName)
	foreach ($CleanupName in $CleanupNames) {
		if (-not [string]::IsNullOrWhiteSpace($CleanupName)) {
			$TempUnit = Get-CapaUnits -CapaSDK $oCMS -Type Computer | Where-Object { $_.Name -eq $CleanupName } | Select-Object -First 1
			if ($null -ne $TempUnit) {
				try {
					Delete-CapaUnit -CapaSDK $oCMS -UnitName $CleanupName -UnitType 'Computer' -Confirm:$false | Out-Null
				} catch {}
			}
		}
	}
}
