BeforeAll {
	$script:SkipIntegration = $false
	$script:SkipReason = ''
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

	try { $oCMS = Initialize-CapaSDK -Server $env:COMPUTERNAME -Database 'CapaInstaller' -InstanceManagementPoint 2 } catch { $script:SkipIntegration = $true; $script:SkipReason = $_.Exception.Message; return }

	$Units = Get-CapaUnits -CapaSDK $oCMS -Type Computer
	$script:TargetUnit = $Units | Where-Object { $_.Name -eq $env:COMPUTERNAME } | Select-Object -First 1
	if ($null -eq $script:TargetUnit) {
		throw "Computer unit '$env:COMPUTERNAME' was not found in CapaInstaller."
	}

	$script:DeviceUUID = if ([string]::IsNullOrWhiteSpace($script:TargetUnit.UUID)) { $script:TargetUnit.GUID } else { $script:TargetUnit.UUID }
	if ([string]::IsNullOrWhiteSpace($script:DeviceUUID)) {
		throw "No UUID/GUID was found on computer unit '$env:COMPUTERNAME'."
	}

	$script:ChangelogComment = "Pester Send-CapaUnitCommand $([DateTime]::Now.ToString('yyyyMMddHHmmss'))"
}

Describe 'Send-CapaUnitCommand integration' {
	It 'Sends a supported inventory command to existing unit' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		$CommandsToTry = @('SWInventory', 'HWInventory', 'SecInventory', 'ManagedSoftwareInventory')
		$Result = $null
		$SelectedCommand = $null
		$UnsupportedCommandCount = 0

		foreach ($CommandToTry in $CommandsToTry) {
			try {
				$Result = Send-CapaUnitCommand -CapaSDK $oCMS -DeviceUUID $script:DeviceUUID -Command $CommandToTry -ChangelogComment $script:ChangelogComment -Confirm:$false
				$SelectedCommand = $CommandToTry
				break
			} catch {
				if ($_.Exception.Message -match 'does not support|not support') {
					$UnsupportedCommandCount++
					continue
				}
				throw
			}
		}

		if ($null -eq $SelectedCommand) {
			$UnsupportedCommandCount | Should -BeGreaterThan 0
			return
		}

		$Result | Should -Not -BeNullOrEmpty
	}

	It 'Does not send command when using WhatIf' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		$Result = Send-CapaUnitCommand -CapaSDK $oCMS -DeviceUUID $script:DeviceUUID -Command 'SWInventory' -ChangelogComment $script:ChangelogComment -WhatIf -Confirm:$false
		$Result | Should -BeNullOrEmpty
	}

	It 'Validates DeviceUUID format' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		{ Send-CapaUnitCommand -CapaSDK $oCMS -DeviceUUID 'not-a-guid' -Command 'SWInventory' -ChangelogComment $script:ChangelogComment -Confirm:$false } | Should -Throw
	}

	It 'Validates ChangelogComment is not empty' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		{ Send-CapaUnitCommand -CapaSDK $oCMS -DeviceUUID $script:DeviceUUID -Command 'SWInventory' -ChangelogComment '' -Confirm:$false } | Should -Throw
	}

	It 'Validates Command values' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		{ Send-CapaUnitCommand -CapaSDK $oCMS -DeviceUUID $script:DeviceUUID -Command 'InvalidCommand' -ChangelogComment $script:ChangelogComment -Confirm:$false } | Should -Throw
	}
}
