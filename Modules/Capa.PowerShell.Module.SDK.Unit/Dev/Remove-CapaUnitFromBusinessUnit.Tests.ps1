BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
	$RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

	$Folders = @(
		'Capa.PowerShell.Module.SDK.Authentication',
		'Capa.PowerShell.Module.SDK.SystemSdk',
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
	$script:AddedByTest = $false

	$BusinessUnits = Get-CapaBusinessUnits -CapaSDK $oCMS
	$script:CanRunIntegration = $null -ne $BusinessUnits -and $BusinessUnits.Count -gt 0
	if (-not $script:CanRunIntegration) {
		$script:TargetBusinessUnitName = 'NoBusinessUnitFound'
		$script:TestBusinessUnitRelation = { return $false }
		$script:OriginalBusinessUnits = @()
		$script:AddedByTest = $false
		return
	}

	function Test-BusinessUnitRelation {
		param(
			[string]$UnitName,
			[string]$BusinessUnitName
		)
		$Rows = $oCMS.GetUnitsOnBusinessUnit($BusinessUnitName, 'Computer')
		if ($null -eq $Rows) { return $false }
		foreach ($Row in $Rows) {
			$Columns = ([string]$Row).Split(';')
			if ($Columns.Count -gt 0 -and $Columns[0] -eq $UnitName) {
				return $true
			}
		}
		return $false
	}
	$script:TestBusinessUnitRelation = ${function:Test-BusinessUnitRelation}

	$script:OriginalBusinessUnits = @()
	foreach ($BusinessUnit in $BusinessUnits) {
		if (& $script:TestBusinessUnitRelation -UnitName $script:UnitName -BusinessUnitName $BusinessUnit.Name) {
			$script:OriginalBusinessUnits += $BusinessUnit.Name
		}
	}

	$script:TargetBusinessUnit = $BusinessUnits | Where-Object { $_.Name -notin $script:OriginalBusinessUnits } | Select-Object -First 1
	if ($null -eq $script:TargetBusinessUnit) {
		$script:TargetBusinessUnit = $BusinessUnits | Select-Object -First 1
	}
	$script:TargetBusinessUnitName = $script:TargetBusinessUnit.Name

	$IsRelated = & $script:TestBusinessUnitRelation -UnitName $script:UnitName -BusinessUnitName $script:TargetBusinessUnitName
	if (-not $IsRelated) {
		$AddStatus = Add-CapaUnitToBusinessUnit -CapaSDK $oCMS -UnitName $script:UnitName -UnitType $script:UnitType -BusinessUnit $script:TargetBusinessUnitName
		$AddStatus | Should -Be $true
		$script:AddedByTest = $true
	}
}

Describe 'Remove-CapaUnitFromBusinessUnit integration' {
	It 'Removes unit from business unit relation' {
		if (-not $script:CanRunIntegration) {
			$true | Should -BeTrue
			return
		}

		$Result = Remove-CapaUnitFromBusinessUnit -CapaSDK $oCMS -UnitName $script:UnitName -UnitType $script:UnitType -Confirm:$false
		$Result | Should -Be $true

		$StillRelated = $true
		for ($i = 0; $i -lt 10; $i++) {
			Start-Sleep -Seconds 2
			$StillRelated = & $script:TestBusinessUnitRelation -UnitName $script:UnitName -BusinessUnitName $script:TargetBusinessUnitName
			if (-not $StillRelated) {
				break
			}
		}

		$StillRelated | Should -BeFalse
	}

	It 'Does not remove when using WhatIf' {
		if (-not $script:CanRunIntegration) {
			$true | Should -BeTrue
			return
		}

		if (-not (& $script:TestBusinessUnitRelation -UnitName $script:UnitName -BusinessUnitName $script:TargetBusinessUnitName)) {
			$AddStatus = Add-CapaUnitToBusinessUnit -CapaSDK $oCMS -UnitName $script:UnitName -UnitType $script:UnitType -BusinessUnit $script:TargetBusinessUnitName
			$AddStatus | Should -Be $true
		}

		$Result = Remove-CapaUnitFromBusinessUnit -CapaSDK $oCMS -UnitName $script:UnitName -UnitType $script:UnitType -WhatIf -Confirm:$false
		$Result | Should -BeNullOrEmpty

		$StillRelated = & $script:TestBusinessUnitRelation -UnitName $script:UnitName -BusinessUnitName $script:TargetBusinessUnitName
		$StillRelated | Should -BeTrue
	}

	It 'Validates UnitName is not empty' {
		{ Remove-CapaUnitFromBusinessUnit -CapaSDK $oCMS -UnitName '' -UnitType $script:UnitType -Confirm:$false } | Should -Throw
	}

	It 'Validates UnitType values' {
		{ Remove-CapaUnitFromBusinessUnit -CapaSDK $oCMS -UnitName $script:UnitName -UnitType 'Device' -Confirm:$false } | Should -Throw
	}
}

AfterAll {
	if ($script:CanRunIntegration -and $null -ne $script:UnitName -and $null -ne $script:TargetBusinessUnitName) {
		$StillRelated = & $script:TestBusinessUnitRelation -UnitName $script:UnitName -BusinessUnitName $script:TargetBusinessUnitName

		if ($script:AddedByTest) {
			if ($StillRelated) {
				try {
					Remove-CapaUnitFromBusinessUnit -CapaSDK $oCMS -UnitName $script:UnitName -UnitType $script:UnitType -Confirm:$false | Out-Null
				} catch {}
			}
		} else {
			if (-not $StillRelated) {
				try {
					Add-CapaUnitToBusinessUnit -CapaSDK $oCMS -UnitName $script:UnitName -UnitType $script:UnitType -BusinessUnit $script:TargetBusinessUnitName | Out-Null
				} catch {}
			}
		}
	}
}
