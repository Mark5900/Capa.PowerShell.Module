BeforeAll {
	$script:SkipIntegration = $false
	$script:SkipReason = ''
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
	$RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

	$Folders = @(
		'Capa.PowerShell.Module.SDK.Authentication',
		'Capa.PowerShell.Module.SDK.Unit',
		'Capa.PowerShell.Module.SDK.Utilities'
	)
	foreach ($Folder in $Folders) {
		$Items = Get-ChildItem -Path "$RootPath\$Folder\Dev\" -Filter '*.ps1' | Where-Object { $_.Name -notlike '*Tests.ps1' }
		foreach ($Item in $Items) {
			Import-Module $Item.FullName -Force -ErrorAction Stop
		}
	}

	try { $oCMS = Initialize-CapaSDK -Server $env:COMPUTERNAME -Database 'CapaInstaller' -InstanceManagementPoint 2 } catch { $script:SkipIntegration = $true; $script:SkipReason = $_.Exception.Message; return }

	$Units = Get-CapaUnits -CapaSDK $oCMS -Type Computer
	$script:TargetUnit = $Units | Where-Object { $_.Name -eq $env:COMPUTERNAME } | Select-Object -First 1
	if ($null -eq $script:TargetUnit) {
		throw "Computer unit '$env:COMPUTERNAME' was not found in CapaInstaller."
	}

	$script:ComputerName = $script:TargetUnit.Name

	function ConvertTo-ReinstallEnabled {
		param([object]$Value)
		if ($null -eq $Value) { return $false }
		$normalized = ([string]$Value).Trim().ToLowerInvariant()
		return $normalized -in @('true', '1', 'yes')
	}

	$script:ConvertToReinstallEnabled = ${function:ConvertTo-ReinstallEnabled}
}

Describe 'Remove-CapaUnitFromReinstall integration' {
	It 'Removes computer from reinstall (idempotent)' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		{ Remove-CapaUnitFromReinstall -CapaSDK $oCMS -ComputerName $script:ComputerName -Confirm:$false } | Should -Not -Throw

		$ReinstallStatus = $null
		for ($i = 0; $i -lt 10; $i++) {
			Start-Sleep -Seconds 2
			$ReinstallStatus = Get-CapaReinstallStatus -CapaSDK $oCMS -UnitName $script:ComputerName -UnitType 'Computer'
			if (-not (& $script:ConvertToReinstallEnabled $ReinstallStatus)) {
				break
			}
		}

		(& $script:ConvertToReinstallEnabled $ReinstallStatus) | Should -BeFalse
	}

	It 'Does not remove when using WhatIf' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		$Result = Remove-CapaUnitFromReinstall -CapaSDK $oCMS -ComputerName $script:ComputerName -WhatIf -Confirm:$false
		$Result | Should -BeNullOrEmpty
	}

	It 'Validates ComputerName is not empty' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		{ Remove-CapaUnitFromReinstall -CapaSDK $oCMS -ComputerName '' -Confirm:$false } | Should -Throw
	}
}
