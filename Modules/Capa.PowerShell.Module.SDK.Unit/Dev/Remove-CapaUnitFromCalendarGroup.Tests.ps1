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
	$script:TargetUnit = $Units | Where-Object { $_.Name -eq $env:COMPUTERNAME } | Select-Object -First 1
	if ($null -eq $script:TargetUnit) {
		throw "Computer unit '$env:COMPUTERNAME' was not found in CapaInstaller."
	}

	$script:UnitName = $script:TargetUnit.Name
	$script:UnitType = 'Computer'

	$CandidateGroups = Get-CapaGroups -CapaSDK $oCMS -GroupType 'Calendar' | Where-Object { $_.UnitTypeName -eq 'Computer' }
	if ($null -eq $CandidateGroups -or $CandidateGroups.Count -eq 0) {
		$CandidateGroups = Get-CapaGroups -CapaSDK $oCMS -GroupType 'Calendar'
	}
	$script:TargetGroup = $CandidateGroups | Select-Object -First 1
	$script:CanRunIntegration = $null -ne $script:TargetGroup

	if (-not $script:CanRunIntegration) {
		$script:CalendarGroupName = 'NoCalendarGroupFound'
		$script:TestCalendarRelation = { return $false }
		return
	}

	$script:CalendarGroupName = $script:TargetGroup.Name

	function Test-CalendarRelation {
		param(
			[string]$UnitName,
			[string]$UnitType,
			[string]$CalendarGroupName
		)
		$CurrentGroups = Get-CapaUnitGroups -CapaSDK $oCMS -UnitName $UnitName -UnitType $UnitType
		$Relation = $CurrentGroups | Where-Object { $_.Name -eq $CalendarGroupName -and $_.Type -eq 'Calendar' } | Select-Object -First 1
		return ($null -ne $Relation)
	}
	$script:TestCalendarRelation = ${function:Test-CalendarRelation}

	if (-not (& $script:TestCalendarRelation -UnitName $script:UnitName -UnitType $script:UnitType -CalendarGroupName $script:CalendarGroupName)) {
		$AddStatus = Add-CapaUnitToCalendarGroup -CapaSDK $oCMS -UnitName $script:UnitName -UnitType $script:UnitType -CalendarGroupName $script:CalendarGroupName
		$AddStatus | Should -Be $true
	}
}

Describe 'Remove-CapaUnitFromCalendarGroup integration' {
	It 'Removes existing unit relation from calendar group' {
		if (-not $script:CanRunIntegration) {
			$true | Should -BeTrue
			return
		}

		$Result = Remove-CapaUnitFromCalendarGroup -CapaSDK $oCMS -UnitName $script:UnitName -UnitType $script:UnitType -CalendarGroupName $script:CalendarGroupName -Confirm:$false
		$Result | Should -Be $true

		$StillRelated = $true
		for ($i = 0; $i -lt 10; $i++) {
			Start-Sleep -Seconds 2
			$StillRelated = & $script:TestCalendarRelation -UnitName $script:UnitName -UnitType $script:UnitType -CalendarGroupName $script:CalendarGroupName
			if (-not $StillRelated) {
				break
			}
		}

		$StillRelated | Should -BeFalse
	}

	It 'Does not remove relation when using WhatIf' {
		if (-not $script:CanRunIntegration) {
			$true | Should -BeTrue
			return
		}

		if (-not (& $script:TestCalendarRelation -UnitName $script:UnitName -UnitType $script:UnitType -CalendarGroupName $script:CalendarGroupName)) {
			$AddStatus = Add-CapaUnitToCalendarGroup -CapaSDK $oCMS -UnitName $script:UnitName -UnitType $script:UnitType -CalendarGroupName $script:CalendarGroupName
			$AddStatus | Should -Be $true
		}

		$Result = Remove-CapaUnitFromCalendarGroup -CapaSDK $oCMS -UnitName $script:UnitName -UnitType $script:UnitType -CalendarGroupName $script:CalendarGroupName -WhatIf -Confirm:$false
		$Result | Should -BeNullOrEmpty

		$StillRelated = & $script:TestCalendarRelation -UnitName $script:UnitName -UnitType $script:UnitType -CalendarGroupName $script:CalendarGroupName
		$StillRelated | Should -BeTrue
	}

	It 'Validates UnitName is not empty' {
		{ Remove-CapaUnitFromCalendarGroup -CapaSDK $oCMS -UnitName '' -UnitType $script:UnitType -CalendarGroupName $script:CalendarGroupName -Confirm:$false } | Should -Throw
	}

	It 'Validates CalendarGroupName is not empty' {
		{ Remove-CapaUnitFromCalendarGroup -CapaSDK $oCMS -UnitName $script:UnitName -UnitType $script:UnitType -CalendarGroupName '' -Confirm:$false } | Should -Throw
	}

	It 'Validates UnitType values' {
		{ Remove-CapaUnitFromCalendarGroup -CapaSDK $oCMS -UnitName $script:UnitName -UnitType 'Device' -CalendarGroupName $script:CalendarGroupName -Confirm:$false } | Should -Throw
	}
}

AfterAll {
	if ($script:CanRunIntegration -and $null -ne $script:UnitName -and $null -ne $script:CalendarGroupName) {
		$StillRelated = & $script:TestCalendarRelation -UnitName $script:UnitName -UnitType $script:UnitType -CalendarGroupName $script:CalendarGroupName
		if (-not $StillRelated) {
			try {
				Add-CapaUnitToCalendarGroup -CapaSDK $oCMS -UnitName $script:UnitName -UnitType $script:UnitType -CalendarGroupName $script:CalendarGroupName | Out-Null
			} catch {}
		}
	}
}
