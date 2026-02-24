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
	$script:ExistingUnit = $Units | Where-Object { $_.Name -eq $env:COMPUTERNAME } | Select-Object -First 1
	if ($null -eq $script:ExistingUnit) {
		throw "Computer unit '$env:COMPUTERNAME' was not found in CapaInstaller."
	}

	$script:TempUnitName = "TestExistOnMP_$([DateTime]::Now.ToString('yyyyMMddHHmmss'))"
	Create-CapaUnit -CapaSDK $oCMS -UnitName $script:TempUnitName -UnitType 'Computer' -LinkToManagementServerID 2 | Out-Null

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

	$script:CMPID = 2
	try {
		$MPValue = Get-CapaUnitManagementPoint -CapaSDK $oCMS -UnitName $script:ExistingUnit.Name -UnitType 'Computer'
		if ($null -ne $MPValue -and [int]::TryParse([string]$MPValue, [ref]$null)) {
			$script:CMPID = [int]$MPValue
		}
	} catch {}
}

Describe 'Exist-CapaUnitOnManagementPoint integration' {
	It 'Checks existing unit on resolved management point' {
		$Result = Exist-CapaUnitOnManagementPoint -CapaSDK $oCMS -UnitName $script:ExistingUnit.Name -UnitType 'Computer' -CMPID $script:CMPID
		$Result | Should -Not -BeNull
	}

	It 'Checks temporary unit on resolved management point' {
		$Result = Exist-CapaUnitOnManagementPoint -CapaSDK $oCMS -UnitName $script:TempUnitName -UnitType 'Computer' -CMPID $script:CMPID
		$Result | Should -Not -BeNull
	}

	It 'Validates UnitName is not empty' {
		{ Exist-CapaUnitOnManagementPoint -CapaSDK $oCMS -UnitName '' -UnitType 'Computer' -CMPID $script:CMPID } | Should -Throw
	}

	It 'Validates UnitType values' {
		{ Exist-CapaUnitOnManagementPoint -CapaSDK $oCMS -UnitName $script:ExistingUnit.Name -UnitType 'Device' -CMPID $script:CMPID } | Should -Throw
	}

	It 'Validates CMPID range' {
		{ Exist-CapaUnitOnManagementPoint -CapaSDK $oCMS -UnitName $script:ExistingUnit.Name -UnitType 'Computer' -CMPID 0 } | Should -Throw
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
