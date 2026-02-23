BeforeAll {
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

	$oCMS = Initialize-CapaSDK -Server $env:COMPUTERNAME -Database 'CapaInstaller' -InstanceManagementPoint 2

	$Units = Get-CapaUnits -CapaSDK $oCMS -Type Computer
	$script:ExistingUnit = $Units | Where-Object { $_.Name -eq $env:COMPUTERNAME } | Select-Object -First 1
	if ($null -eq $script:ExistingUnit) {
		throw "Computer unit '$env:COMPUTERNAME' was not found in CapaInstaller."
	}

	$script:TempUnitName = "TestUnitGroupsUnit_$([DateTime]::Now.ToString('yyyyMMddHHmmss'))"
	$script:TempGroupName = "TestUnitGroupsGroup_$([DateTime]::Now.ToString('yyyyMMddHHmmss'))"

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

	$AddStatus = Add-CapaUnitToGroup -CapaSDK $oCMS -UnitName $script:TempUnitName -UnitType 'Computer' -GroupName $script:TempGroupName -GroupType 'Static'
	$AddStatus | Should -Be $true
}

Describe 'Get-CapaUnitGroups integration' {
	It 'Queries unit groups for existing unit without throwing' {
		{ Get-CapaUnitGroups -CapaSDK $oCMS -UnitName $script:ExistingUnit.Name -UnitType 'Computer' } | Should -Not -Throw
	}

	It 'Contains temporary static group for temporary unit' {
		$Found = $null
		for ($i = 0; $i -lt 15; $i++) {
			Start-Sleep -Seconds 2
			$Groups = Get-CapaUnitGroups -CapaSDK $oCMS -UnitName $script:TempUnitName -UnitType 'Computer'
			$Found = $Groups | Where-Object { $_.Name -eq $script:TempGroupName -and $_.Type -eq 'Static' } | Select-Object -First 1
			if ($null -ne $Found) {
				break
			}
		}
		$Found | Should -Not -BeNullOrEmpty
	}

	It 'Returns expected properties when groups are returned' {
		$Groups = Get-CapaUnitGroups -CapaSDK $oCMS -UnitName $script:TempUnitName -UnitType 'Computer'
		if ($null -ne $Groups -and $Groups.Count -gt 0) {
			$Properties = $Groups[0].PSObject.Properties.Name
			$Properties -contains 'Name' | Should -BeTrue
			$Properties -contains 'Type' | Should -BeTrue
			$Properties -contains 'GUID' | Should -BeTrue
		} else {
			$true | Should -BeTrue
		}
	}

	It 'Validates UnitName is not empty' {
		{ Get-CapaUnitGroups -CapaSDK $oCMS -UnitName '' -UnitType 'Computer' } | Should -Throw
	}

	It 'Validates UnitType values' {
		{ Get-CapaUnitGroups -CapaSDK $oCMS -UnitName $script:TempUnitName -UnitType 'Device' } | Should -Throw
	}
}

AfterAll {
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
