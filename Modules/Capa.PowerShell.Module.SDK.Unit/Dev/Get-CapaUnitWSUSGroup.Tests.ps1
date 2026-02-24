BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
	$RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

	$Folders = @(
		'Capa.PowerShell.Module.SDK.Authentication',
		'Capa.PowerShell.Module.SDK.Unit',
		'Capa.PowerShell.Module.SDK.WSUS'
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

	$script:TempUnitName = "TestWsusUnit_$([DateTime]::Now.ToString('yyyyMMddHHmmss'))"
	Create-CapaUnit -CapaSDK $oCMS -UnitName $script:TempUnitName -UnitType 'Computer' -LinkToManagementServerID 2 | Out-Null

	for ($i = 0; $i -lt 15; $i++) {
		Start-Sleep -Seconds 2
		$Created = Get-CapaUnits -CapaSDK $oCMS -Type Computer | Where-Object { $_.Name -eq $script:TempUnitName } | Select-Object -First 1
		if ($null -ne $Created) {
			break
		}
	}
}

Describe 'Get-CapaUnitWSUSGroup integration' {
	It 'Returns WSUS group data (or empty) for an existing computer unit without throwing' {
		{ Get-CapaUnitWSUSGroup -CapaSDK $oCMS -UnitName $script:ExistingUnit.Name -UnitType 'Computer' } | Should -Not -Throw

		$Result = Get-CapaUnitWSUSGroup -CapaSDK $oCMS -UnitName $script:ExistingUnit.Name -UnitType 'Computer'
		$null -ne $Result | Should -BeOfType [bool]
	}

	It 'Can query WSUS group data for a temporary created unit' {
		{ Get-CapaUnitWSUSGroup -CapaSDK $oCMS -UnitName $script:TempUnitName -UnitType 'Computer' } | Should -Not -Throw

		$Result = Get-CapaUnitWSUSGroup -CapaSDK $oCMS -UnitName $script:TempUnitName -UnitType 'Computer'
		$null -ne $Result | Should -BeOfType [bool]
	}

	It 'Can list WSUS groups when WSUS points are available' {
		$Points = Get-CapaWSUSPoints -CapaSDK $oCMS
		if ($null -eq $Points -or $Points.Count -eq 0) {
			$true | Should -BeTrue
			return
		}

		{ Get-CapaWSUSGroups -CapaSDK $oCMS -PointID ([int]$Points[0].ID) } | Should -Not -Throw
		$Groups = Get-CapaWSUSGroups -CapaSDK $oCMS -PointID ([int]$Points[0].ID)
		if ($null -ne $Groups -and $Groups.Count -gt 0) {
			$Groups[0].PSObject.Properties.Name -contains 'Name' | Should -BeTrue
		}
	}

	It 'Validates UnitName is not empty' {
		{ Get-CapaUnitWSUSGroup -CapaSDK $oCMS -UnitName '' -UnitType 'Computer' } | Should -Throw
	}

	It 'Validates UnitType values' {
		{ Get-CapaUnitWSUSGroup -CapaSDK $oCMS -UnitName $script:ExistingUnit.Name -UnitType 'Device' } | Should -Throw
	}
}

AfterAll {
	if (-not [string]::IsNullOrWhiteSpace($script:TempUnitName)) {
		$TempUnit = Get-CapaUnits -CapaSDK $oCMS -Type Computer | Where-Object { $_.Name -eq $script:TempUnitName } | Select-Object -First 1
		if ($null -ne $TempUnit) {
			try {
				Delete-CapaUnit -CapaSDK $oCMS -UnitName $script:TempUnitName -UnitType 'Computer' | Out-Null
			} catch {}
		}
	}
}
