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

	$CandidateGroups = Get-CapaGroups -CapaSDK $oCMS | Where-Object {
		$_.UnitTypeName -eq 'Computer' -and $_.Type -in @('Static', 'Security', 'Department', 'Calendar', 'Reinstall')
	}
	$script:TargetGroup = $CandidateGroups | Select-Object -First 1
	if ($null -eq $script:TargetGroup) {
		throw 'No suitable computer group found for Remove-CapaUnitFromGroup integration test.'
	}

	$script:GroupName = $script:TargetGroup.Name
	$script:GroupType = $script:TargetGroup.Type

	function Test-UnitGroupRelation {
		param(
			[string]$UnitName,
			[string]$UnitType,
			[string]$GroupName,
			[string]$GroupType
		)
		$CurrentGroups = Get-CapaUnitGroups -CapaSDK $oCMS -UnitName $UnitName -UnitType $UnitType
		$Relation = $CurrentGroups | Where-Object { $_.Name -eq $GroupName -and $_.Type -eq $GroupType } | Select-Object -First 1
		return ($null -ne $Relation)
	}
	$script:TestUnitGroupRelation = ${function:Test-UnitGroupRelation}

	if (-not (& $script:TestUnitGroupRelation -UnitName $script:UnitName -UnitType $script:UnitType -GroupName $script:GroupName -GroupType $script:GroupType)) {
		$AddStatus = Add-CapaUnitToGroup -CapaSDK $oCMS -UnitName $script:UnitName -UnitType $script:UnitType -GroupName $script:GroupName -GroupType $script:GroupType
		$AddStatus | Should -Be $true
	}
}

Describe 'Remove-CapaUnitFromGroup integration' {
	It 'Removes existing unit relation from group' {
		$Result = Remove-CapaUnitFromGroup -CapaSDK $oCMS -UnitName $script:UnitName -UnitType $script:UnitType -GroupName $script:GroupName -GroupType $script:GroupType -Confirm:$false
		$Result | Should -Be $true

		$StillRelated = $true
		for ($i = 0; $i -lt 10; $i++) {
			Start-Sleep -Seconds 2
			$StillRelated = & $script:TestUnitGroupRelation -UnitName $script:UnitName -UnitType $script:UnitType -GroupName $script:GroupName -GroupType $script:GroupType
			if (-not $StillRelated) {
				break
			}
		}

		$StillRelated | Should -BeFalse
	}

	It 'Does not remove relation when using WhatIf' {
		if (-not (& $script:TestUnitGroupRelation -UnitName $script:UnitName -UnitType $script:UnitType -GroupName $script:GroupName -GroupType $script:GroupType)) {
			$AddStatus = Add-CapaUnitToGroup -CapaSDK $oCMS -UnitName $script:UnitName -UnitType $script:UnitType -GroupName $script:GroupName -GroupType $script:GroupType
			$AddStatus | Should -Be $true
		}

		$Result = Remove-CapaUnitFromGroup -CapaSDK $oCMS -UnitName $script:UnitName -UnitType $script:UnitType -GroupName $script:GroupName -GroupType $script:GroupType -WhatIf -Confirm:$false
		$Result | Should -BeNullOrEmpty

		$StillRelated = & $script:TestUnitGroupRelation -UnitName $script:UnitName -UnitType $script:UnitType -GroupName $script:GroupName -GroupType $script:GroupType
		$StillRelated | Should -BeTrue
	}

	It 'Validates UnitName is not empty' {
		{ Remove-CapaUnitFromGroup -CapaSDK $oCMS -UnitName '' -UnitType $script:UnitType -GroupName $script:GroupName -GroupType $script:GroupType -Confirm:$false } | Should -Throw
	}

	It 'Validates GroupName is not empty' {
		{ Remove-CapaUnitFromGroup -CapaSDK $oCMS -UnitName $script:UnitName -UnitType $script:UnitType -GroupName '' -GroupType $script:GroupType -Confirm:$false } | Should -Throw
	}

	It 'Validates UnitType values' {
		{ Remove-CapaUnitFromGroup -CapaSDK $oCMS -UnitName $script:UnitName -UnitType 'Device' -GroupName $script:GroupName -GroupType $script:GroupType -Confirm:$false } | Should -Throw
	}
}

AfterAll {
	if ($null -ne $script:UnitName -and $null -ne $script:GroupName -and $null -ne $script:GroupType) {
		$StillRelated = & $script:TestUnitGroupRelation -UnitName $script:UnitName -UnitType $script:UnitType -GroupName $script:GroupName -GroupType $script:GroupType
		if (-not $StillRelated) {
			try {
				Add-CapaUnitToGroup -CapaSDK $oCMS -UnitName $script:UnitName -UnitType $script:UnitType -GroupName $script:GroupName -GroupType $script:GroupType | Out-Null
			} catch {}
		}
	}
}
