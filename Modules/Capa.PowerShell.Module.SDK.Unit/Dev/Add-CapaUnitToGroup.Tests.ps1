BeforeAll {
	$script:SkipIntegration = $false
	$script:SkipReason = ''
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

	try { $oCMS = Initialize-CapaSDK -Server $env:COMPUTERNAME -Database 'CapaInstaller' -InstanceManagementPoint 2 } catch { $script:SkipIntegration = $true; $script:SkipReason = $_.Exception.Message; return }

	$script:UnitName = "PesterUnitGroupAdd_$([guid]::NewGuid().ToString('N').Substring(0, 8))"
	$script:WhatIfUnitName = "PesterUnitGroupWhatIf_$([guid]::NewGuid().ToString('N').Substring(0, 8))"
	$script:GroupName = "PesterGroupAdd_$([guid]::NewGuid().ToString('N').Substring(0, 8))"
	$script:UnitType = 'Computer'
	$script:GroupType = 'Static'

	$null = Create-CapaUnit -CapaSDK $oCMS -UnitName $script:UnitName -UnitType $script:UnitType -LinkToManagementServerID 2
	$null = Create-CapaUnit -CapaSDK $oCMS -UnitName $script:WhatIfUnitName -UnitType $script:UnitType -LinkToManagementServerID 2
	$null = Create-CapaGroup -CapaSDK $oCMS -GroupName $script:GroupName -GroupType $script:GroupType -UnitType $script:UnitType
}

Describe 'Add-CapaUnitToGroup integration' {
	It 'Adds a unit to a group and returns true' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		$result = Add-CapaUnitToGroup -CapaSDK $oCMS -UnitName $script:UnitName -UnitType $script:UnitType -GroupName $script:GroupName -GroupType $script:GroupType -Confirm:$false
		$result | Should -BeTrue

		$relationFound = $false
		for ($i = 0; $i -lt 20; $i++) {
			Start-Sleep -Seconds 2
			$rawGroups = @($oCMS.GetUnitGroups($script:UnitName, $script:UnitType))
			$relationFound = [bool]($rawGroups | Where-Object { $_ -like "$($script:GroupName);$($script:GroupType);*" } | Select-Object -First 1)
			if ($relationFound) {
				break
			}
		}

		$relationFound | Should -BeTrue
	}

	It 'Does not add relation when using WhatIf' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		$result = Add-CapaUnitToGroup -CapaSDK $oCMS -UnitName $script:WhatIfUnitName -UnitType $script:UnitType -GroupName $script:GroupName -GroupType $script:GroupType -WhatIf -Confirm:$false
		$result | Should -BeNullOrEmpty

		$rawGroups = @($oCMS.GetUnitGroups($script:WhatIfUnitName, $script:UnitType))
		$relationFound = $rawGroups | Where-Object { $_ -like "$($script:GroupName);$($script:GroupType);*" } | Select-Object -First 1
		$relationFound | Should -BeNullOrEmpty
	}

	It 'Throws when GroupType requires Printer unit type' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		{
			Add-CapaUnitToGroup -CapaSDK $oCMS -UnitName $script:UnitName -UnitType 'Computer' -GroupName $script:GroupName -GroupType 'Dynamic_SQL' -Confirm:$false
		} | Should -Throw "GroupType 'Dynamic_SQL' only supports UnitType 'Printer'."
	}

	It 'Throws when CapaSDK method is missing' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		$mockSdk = [pscustomobject]@{}
		{
			Add-CapaUnitToGroup -CapaSDK $mockSdk -UnitName $script:UnitName -UnitType $script:UnitType -GroupName $script:GroupName -GroupType $script:GroupType -Confirm:$false
		} | Should -Throw 'CapaSDK does not contain method AddUnitToGroup.'
	}
}

AfterAll {
	if ($script:SkipIntegration) { return }
	if ($null -ne $script:UnitName -and $null -ne $script:GroupName -and $null -ne $script:GroupType) {
		try {
			$rawGroups = @($oCMS.GetUnitGroups($script:UnitName, $script:UnitType))
			$relationFound = $rawGroups | Where-Object { $_ -like "$($script:GroupName);$($script:GroupType);*" } | Select-Object -First 1
			if ($null -ne $relationFound) {
				Remove-CapaUnitFromGroup -CapaSDK $oCMS -UnitName $script:UnitName -UnitType $script:UnitType -GroupName $script:GroupName -GroupType $script:GroupType -Confirm:$false | Out-Null
			}
		}
		catch {}
	}

	if ($null -ne $script:GroupName) {
		try { Remove-CapaGroup -CapaSDK $oCMS -GroupName $script:GroupName -GroupType $script:GroupType -UnitType $script:UnitType | Out-Null } catch {}
	}

	if ($null -ne $script:UnitName) {
		try { Delete-CapaUnit -CapaSDK $oCMS -UnitName $script:UnitName -UnitType $script:UnitType -Confirm:$false | Out-Null } catch {}
	}

	if ($null -ne $script:WhatIfUnitName) {
		try { Delete-CapaUnit -CapaSDK $oCMS -UnitName $script:WhatIfUnitName -UnitType $script:UnitType -Confirm:$false | Out-Null } catch {}
	}
}
