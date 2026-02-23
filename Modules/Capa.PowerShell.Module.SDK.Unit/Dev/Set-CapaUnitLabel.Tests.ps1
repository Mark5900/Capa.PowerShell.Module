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
	$script:TestLabel = "LabelTest_$([DateTime]::Now.ToString('yyyyMMddHHmmss'))"

	$script:HasGetUnitLabel = $oCMS.PSObject.Methods.Name -contains 'GetUnitLabel'
	$script:OriginalLabel = $null
	if ($script:HasGetUnitLabel) {
		$script:OriginalLabel = $oCMS.GetUnitLabel($script:UnitName, 'Computer')
	}
}

Describe 'Set-CapaUnitLabel integration' {
	It 'Sets label on existing computer unit' {
		$Result = Set-CapaUnitLabel -CapaSDK $oCMS -UnitName $script:UnitName -UnitType 'Computer' -Label $script:TestLabel -Confirm:$false
		$Result | Should -Be $true

		if ($script:HasGetUnitLabel) {
			$ObservedLabel = $null
			for ($i = 0; $i -lt 10; $i++) {
				Start-Sleep -Seconds 2
				$ObservedLabel = $oCMS.GetUnitLabel($script:UnitName, 'Computer')
				if ($ObservedLabel -eq $script:TestLabel) {
					break
				}
			}
			$ObservedLabel | Should -Be $script:TestLabel
		}
	}

	It 'Does not set label when using WhatIf' {
		$Result = Set-CapaUnitLabel -CapaSDK $oCMS -UnitName $script:UnitName -UnitType 'Computer' -Label "$($script:TestLabel)_WHATIF" -WhatIf -Confirm:$false
		$Result | Should -BeNullOrEmpty
	}

	It 'Validates UnitName is not empty' {
		{ Set-CapaUnitLabel -CapaSDK $oCMS -UnitName '' -UnitType 'Computer' -Label 'AnyLabel' -Confirm:$false } | Should -Throw
	}

	It 'Validates Label is not empty' {
		{ Set-CapaUnitLabel -CapaSDK $oCMS -UnitName $script:UnitName -UnitType 'Computer' -Label '' -Confirm:$false } | Should -Throw
	}

	It 'Validates UnitType values' {
		{ Set-CapaUnitLabel -CapaSDK $oCMS -UnitName $script:UnitName -UnitType 'Device' -Label 'AnyLabel' -Confirm:$false } | Should -Throw
	}
}

AfterAll {
	if ($script:HasGetUnitLabel -and $null -ne $script:OriginalLabel -and $null -ne $script:UnitName) {
		Set-CapaUnitLabel -CapaSDK $oCMS -UnitName $script:UnitName -UnitType 'Computer' -Label $script:OriginalLabel -Confirm:$false | Out-Null
	}
}
