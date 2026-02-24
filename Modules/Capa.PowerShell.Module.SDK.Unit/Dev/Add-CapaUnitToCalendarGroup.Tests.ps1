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

	$script:UnitType = 'Computer'
	$script:UnitName = "PesterCalUnit_$([guid]::NewGuid().ToString('N').Substring(0, 8))"
	$script:WhatIfUnitName = "PesterCalUnitWhatIf_$([guid]::NewGuid().ToString('N').Substring(0, 8))"
	$script:CalendarGroupName = "PesterCalGroup_$([guid]::NewGuid().ToString('N').Substring(0, 8))"

	Create-CapaUnit -CapaSDK $oCMS -UnitName $script:UnitName -UnitType $script:UnitType -LinkToManagementServerID 2 | Out-Null
	Create-CapaUnit -CapaSDK $oCMS -UnitName $script:WhatIfUnitName -UnitType $script:UnitType -LinkToManagementServerID 2 | Out-Null
	Create-CapaGroup -CapaSDK $oCMS -GroupName $script:CalendarGroupName -GroupType 'Calendar' -UnitType $script:UnitType | Out-Null
}

Describe 'Add-CapaUnitToCalendarGroup integration' {
	It 'Adds unit to calendar group and returns true' {
		$result = Add-CapaUnitToCalendarGroup -CapaSDK $oCMS -UnitName $script:UnitName -UnitType $script:UnitType -CalendarGroupName $script:CalendarGroupName -Confirm:$false
		$result | Should -BeTrue

		$relationFound = $false
		for ($i = 0; $i -lt 20; $i++) {
			Start-Sleep -Seconds 2
			$rawGroups = @($oCMS.GetUnitGroups($script:UnitName, $script:UnitType))
			$relationFound = [bool]($rawGroups | Where-Object { $_ -like "$($script:CalendarGroupName);Calendar;*" } | Select-Object -First 1)
			if ($relationFound) {
				break
			}
		}

		$relationFound | Should -BeTrue
	}

	It 'Does not add relation when using WhatIf' {
		$result = Add-CapaUnitToCalendarGroup -CapaSDK $oCMS -UnitName $script:WhatIfUnitName -UnitType $script:UnitType -CalendarGroupName $script:CalendarGroupName -WhatIf -Confirm:$false
		$result | Should -BeNullOrEmpty

		$rawGroups = @($oCMS.GetUnitGroups($script:WhatIfUnitName, $script:UnitType))
		$relationFound = $rawGroups | Where-Object { $_ -like "$($script:CalendarGroupName);Calendar;*" } | Select-Object -First 1
		$relationFound | Should -BeNullOrEmpty
	}

	It 'Throws when CapaSDK method is missing' {
		$mockSdk = [pscustomobject]@{}
		{
			Add-CapaUnitToCalendarGroup -CapaSDK $mockSdk -UnitName $script:UnitName -UnitType $script:UnitType -CalendarGroupName $script:CalendarGroupName -Confirm:$false
		} | Should -Throw 'CapaSDK does not contain method AddUnitToCalendarGroup.'
	}

	It 'Validates UnitType values' {
		{
			Add-CapaUnitToCalendarGroup -CapaSDK $oCMS -UnitName $script:UnitName -UnitType 'Device' -CalendarGroupName $script:CalendarGroupName -Confirm:$false
		} | Should -Throw
	}
}

AfterAll {
	if ($null -ne $script:UnitName -and $null -ne $script:CalendarGroupName) {
		try {
			$rawGroups = @($oCMS.GetUnitGroups($script:UnitName, $script:UnitType))
			$relationFound = $rawGroups | Where-Object { $_ -like "$($script:CalendarGroupName);Calendar;*" } | Select-Object -First 1
			if ($null -ne $relationFound) {
				Remove-CapaUnitFromCalendarGroup -CapaSDK $oCMS -UnitName $script:UnitName -UnitType $script:UnitType -CalendarGroupName $script:CalendarGroupName -Confirm:$false | Out-Null
			}
		}
		catch {}
	}

	if ($null -ne $script:CalendarGroupName) {
		try { Remove-CapaGroup -CapaSDK $oCMS -GroupName $script:CalendarGroupName -GroupType 'Calendar' -UnitType $script:UnitType | Out-Null } catch {}
	}

	if ($null -ne $script:UnitName) {
		try { Delete-CapaUnit -CapaSDK $oCMS -UnitName $script:UnitName -UnitType $script:UnitType -Confirm:$false | Out-Null } catch {}
	}

	if ($null -ne $script:WhatIfUnitName) {
		try { Delete-CapaUnit -CapaSDK $oCMS -UnitName $script:WhatIfUnitName -UnitType $script:UnitType -Confirm:$false | Out-Null } catch {}
	}
}
