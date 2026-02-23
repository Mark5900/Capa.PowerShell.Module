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

	$script:UnitName = $script:TargetUnit.Name
	$script:TestDescription = "DescriptionTest_$([DateTime]::Now.ToString('yyyyMMddHHmmss'))"
	$script:OriginalDescription = Get-CapaUnitDescription -CapaSDK $oCMS -UnitName $script:UnitName -UnitType 'Computer'
}

Describe 'Set-CapaUnitDescription integration' {
	It 'Sets description on existing computer unit' {
		$Result = Set-CapaUnitDescription -CapaSDK $oCMS -UnitName $script:UnitName -UnitType 'Computer' -Description $script:TestDescription -Confirm:$false
		$Result | Should -Be $true

		$ObservedDescription = $null
		for ($i = 0; $i -lt 10; $i++) {
			Start-Sleep -Seconds 2
			$ObservedDescription = Get-CapaUnitDescription -CapaSDK $oCMS -UnitName $script:UnitName -UnitType 'Computer'
			if ($ObservedDescription -eq $script:TestDescription) {
				break
			}
		}

		$ObservedDescription | Should -Be $script:TestDescription
	}

	It 'Does not set description when using WhatIf' {
		$DescriptionBefore = Get-CapaUnitDescription -CapaSDK $oCMS -UnitName $script:UnitName -UnitType 'Computer'
		$Result = Set-CapaUnitDescription -CapaSDK $oCMS -UnitName $script:UnitName -UnitType 'Computer' -Description "$($script:TestDescription)_WHATIF" -WhatIf -Confirm:$false
		$Result | Should -BeNullOrEmpty

		$DescriptionAfter = Get-CapaUnitDescription -CapaSDK $oCMS -UnitName $script:UnitName -UnitType 'Computer'
		$DescriptionAfter | Should -Be $DescriptionBefore
	}

	It 'Validates UnitName is not empty' {
		{ Set-CapaUnitDescription -CapaSDK $oCMS -UnitName '' -UnitType 'Computer' -Description 'AnyDescription' -Confirm:$false } | Should -Throw
	}

	It 'Validates UnitType values' {
		{ Set-CapaUnitDescription -CapaSDK $oCMS -UnitName $script:UnitName -UnitType 'Device' -Description 'AnyDescription' -Confirm:$false } | Should -Throw
	}
}

AfterAll {
	if ($null -ne $script:UnitName) {
		$RollbackDescription = if ($null -eq $script:OriginalDescription) { '' } else { [string]$script:OriginalDescription }
		Set-CapaUnitDescription -CapaSDK $oCMS -UnitName $script:UnitName -UnitType 'Computer' -Description $RollbackDescription -Confirm:$false | Out-Null
	}
}
