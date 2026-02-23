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

	$Units = Get-CapaUnits -CapaSDK $oCMS -Type Computer
	$script:TargetUnit = $Units | Where-Object { $_.Name -eq $env:COMPUTERNAME } | Select-Object -First 1
	if ($null -eq $script:TargetUnit) {
		throw "Computer unit '$env:COMPUTERNAME' was not found in CapaInstaller."
	}

	$script:OriginalUnitName = $script:TargetUnit.Name
	$script:RenamedUnitName = "$($script:OriginalUnitName)-TEST"
	if ($script:RenamedUnitName.Length -gt 50) {
		$script:RenamedUnitName = $script:RenamedUnitName.Substring(0, 50)
	}
}

Describe 'Set-CapaUnitName' {
	It 'Renames an existing unit and can rename it back' {
		$Result = Set-CapaUnitName -CapaSDK $oCMS -UnitName $script:OriginalUnitName -UnitType 'Computer' -Name $script:RenamedUnitName -Confirm:$false
		$Result | Should -Be $true

		$RenamedUnit = $null
		for ($i = 0; $i -lt 10; $i++) {
			Start-Sleep -Seconds 2
			$RenamedUnit = Get-CapaUnits -CapaSDK $oCMS -Type Computer | Where-Object { $_.Name -eq $script:RenamedUnitName } | Select-Object -First 1
			if ($null -ne $RenamedUnit) {
				break
			}
		}
		$RenamedUnit | Should -Not -BeNullOrEmpty

		$RollbackResult = Set-CapaUnitName -CapaSDK $oCMS -UnitName $script:RenamedUnitName -UnitType 'Computer' -Name $script:OriginalUnitName -Confirm:$false
		$RollbackResult | Should -Be $true

		$RestoredUnit = $null
		for ($i = 0; $i -lt 10; $i++) {
			Start-Sleep -Seconds 2
			$RestoredUnit = Get-CapaUnits -CapaSDK $oCMS -Type Computer | Where-Object { $_.Name -eq $script:OriginalUnitName } | Select-Object -First 1
			if ($null -ne $RestoredUnit) {
				break
			}
		}
		$RestoredUnit | Should -Not -BeNullOrEmpty
	}

	It 'Does not rename when using WhatIf' {
		$Result = Set-CapaUnitName -CapaSDK $oCMS -UnitName $script:OriginalUnitName -UnitType 'Computer' -Name $script:RenamedUnitName -WhatIf -Confirm:$false
		$Result | Should -BeNullOrEmpty

		$UnitAfterWhatIf = Get-CapaUnits -CapaSDK $oCMS -Type Computer | Where-Object { $_.Name -eq $script:OriginalUnitName } | Select-Object -First 1
		$UnitAfterWhatIf | Should -Not -BeNullOrEmpty
	}

	It 'Validates UnitName is not empty' {
		{ Set-CapaUnitName -CapaSDK $oCMS -UnitName '' -UnitType 'Computer' -Name 'AnyValue' -Confirm:$false } | Should -Throw
	}

	It 'Validates Name is not empty' {
		{ Set-CapaUnitName -CapaSDK $oCMS -UnitName $script:OriginalUnitName -UnitType 'Computer' -Name '' -Confirm:$false } | Should -Throw
	}

	It 'Validates UnitType values' {
		{ Set-CapaUnitName -CapaSDK $oCMS -UnitName $script:OriginalUnitName -UnitType 'Device' -Name 'AnyValue' -Confirm:$false } | Should -Throw
	}
}


AfterAll {
	if ($null -ne $script:OriginalUnitName -and $null -ne $script:RenamedUnitName) {
		$CurrentRenamed = Get-CapaUnits -CapaSDK $oCMS -Type Computer | Where-Object { $_.Name -eq $script:RenamedUnitName } | Select-Object -First 1
		if ($null -ne $CurrentRenamed) {
			Set-CapaUnitName -CapaSDK $oCMS -UnitName $script:RenamedUnitName -UnitType 'Computer' -Name $script:OriginalUnitName -Confirm:$false | Out-Null
		}
	}
	}
