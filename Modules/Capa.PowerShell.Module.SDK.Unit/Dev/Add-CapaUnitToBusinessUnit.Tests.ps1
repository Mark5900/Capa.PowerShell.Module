BeforeAll {
	$script:SkipIntegration = $false
	$script:SkipReason = ''
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

	try { $oCMS = Initialize-CapaSDK -Server $env:COMPUTERNAME -Database 'CapaInstaller' -InstanceManagementPoint 2 } catch { $script:SkipIntegration = $true; $script:SkipReason = $_.Exception.Message; return }

	$script:BusinessUnitName = 'TestBU'
	$script:UnitType = 'Computer'
	$script:UnitName = "PesterBuUnit_$([guid]::NewGuid().ToString('N').Substring(0, 8))"
	$script:WhatIfUnitName = "PesterBuUnitWhatIf_$([guid]::NewGuid().ToString('N').Substring(0, 8))"

	$businessUnits = Get-CapaBusinessUnits -CapaSDK $oCMS
	$targetBu = $businessUnits | Where-Object { $_.Name -eq $script:BusinessUnitName } | Select-Object -First 1
	if ($null -eq $targetBu) {
		throw "Business unit '$($script:BusinessUnitName)' was not found."
	}

	Create-CapaUnit -CapaSDK $oCMS -UnitName $script:UnitName -UnitType $script:UnitType -LinkToManagementServerID 2 | Out-Null
	Create-CapaUnit -CapaSDK $oCMS -UnitName $script:WhatIfUnitName -UnitType $script:UnitType -LinkToManagementServerID 2 | Out-Null

	function Test-BusinessUnitRelation {
		param(
			[string]$UnitName,
			[string]$BusinessUnitName
		)

		$rows = $oCMS.GetUnitsOnBusinessUnit($BusinessUnitName, 'Computer')
		if ($null -eq $rows) {
			return $false
		}

		foreach ($row in $rows) {
			$columns = ([string]$row).Split(';')
			if ($columns.Count -gt 0 -and $columns[0] -eq $UnitName) {
				return $true
			}
		}

		return $false
	}
	$script:TestBusinessUnitRelation = ${function:Test-BusinessUnitRelation}
}

Describe 'Add-CapaUnitToBusinessUnit integration' {
	It 'Adds unit to business unit and returns true' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		$result = Add-CapaUnitToBusinessUnit -CapaSDK $oCMS -UnitName $script:UnitName -UnitType $script:UnitType -BusinessUnit $script:BusinessUnitName -Confirm:$false
		$result | Should -BeTrue

		$relationFound = $false
		for ($i = 0; $i -lt 20; $i++) {
			Start-Sleep -Seconds 2
			$relationFound = & $script:TestBusinessUnitRelation -UnitName $script:UnitName -BusinessUnitName $script:BusinessUnitName
			if ($relationFound) {
				break
			}
		}

		$relationFound | Should -BeTrue
	}

	It 'Does not add relation when using WhatIf' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		$result = Add-CapaUnitToBusinessUnit -CapaSDK $oCMS -UnitName $script:WhatIfUnitName -UnitType $script:UnitType -BusinessUnit $script:BusinessUnitName -WhatIf -Confirm:$false
		$result | Should -BeNullOrEmpty

		$relationFound = & $script:TestBusinessUnitRelation -UnitName $script:WhatIfUnitName -BusinessUnitName $script:BusinessUnitName
		$relationFound | Should -BeFalse
	}

	It 'Throws when CapaSDK method is missing' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		$mockSdk = [pscustomobject]@{}
		{
			Add-CapaUnitToBusinessUnit -CapaSDK $mockSdk -UnitName $script:UnitName -UnitType $script:UnitType -BusinessUnit $script:BusinessUnitName -Confirm:$false
		} | Should -Throw 'CapaSDK does not contain method AddUnitToBusinessUnit.'
	}

	It 'Validates UnitType values' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		{
			Add-CapaUnitToBusinessUnit -CapaSDK $oCMS -UnitName $script:UnitName -UnitType 'Device' -BusinessUnit $script:BusinessUnitName -Confirm:$false
		} | Should -Throw
	}
}

AfterAll {
	if ($script:SkipIntegration) { return }
	if ($null -ne $script:UnitName) {
		try {
			$relationFound = & $script:TestBusinessUnitRelation -UnitName $script:UnitName -BusinessUnitName $script:BusinessUnitName
			if ($relationFound) {
				Remove-CapaUnitFromBusinessUnit -CapaSDK $oCMS -UnitName $script:UnitName -UnitType $script:UnitType -Confirm:$false | Out-Null
			}
		}
		catch {}

		try {
			Delete-CapaUnit -CapaSDK $oCMS -UnitName $script:UnitName -UnitType $script:UnitType -Confirm:$false | Out-Null
		}
		catch {}
	}

	if ($null -ne $script:WhatIfUnitName) {
		try {
			$relationFound = & $script:TestBusinessUnitRelation -UnitName $script:WhatIfUnitName -BusinessUnitName $script:BusinessUnitName
			if ($relationFound) {
				Remove-CapaUnitFromBusinessUnit -CapaSDK $oCMS -UnitName $script:WhatIfUnitName -UnitType $script:UnitType -Confirm:$false | Out-Null
			}
		}
		catch {}

		try {
			Delete-CapaUnit -CapaSDK $oCMS -UnitName $script:WhatIfUnitName -UnitType $script:UnitType -Confirm:$false | Out-Null
		}
		catch {}
	}
}
