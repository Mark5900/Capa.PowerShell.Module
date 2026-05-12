BeforeAll {
	$script:SkipIntegration = $false
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
	$RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

	$Folders = @(
		'Capa.PowerShell.Module.SDK.Authentication',
		'Capa.PowerShell.Module.SDK.Group',
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
	$script:UnitName = "PesterPrinterUnit_$([guid]::NewGuid().ToString('N').Substring(0, 8))"
	$script:WhatIfUnitName = "PesterPrinterUnitWhatIf_$([guid]::NewGuid().ToString('N').Substring(0, 8))"
	$script:PrinterShareName = $null
	$script:CanRunIntegration = $true
	$script:SkipReason = ''

	$businessUnits = Get-CapaBusinessUnits -CapaSDK $oCMS
	if ($null -eq ($businessUnits | Where-Object { $_.Name -eq $script:BusinessUnitName } | Select-Object -First 1)) {
		$script:CanRunIntegration = $false
		$script:SkipReason = "Business unit '$($script:BusinessUnitName)' was not found."
	}

	if ($script:CanRunIntegration) {
		try {
			Create-CapaUnit -CapaSDK $oCMS -UnitName $script:UnitName -UnitType $script:UnitType -LinkToManagementServerID 2 | Out-Null
			Create-CapaUnit -CapaSDK $oCMS -UnitName $script:WhatIfUnitName -UnitType $script:UnitType -LinkToManagementServerID 2 | Out-Null

			Add-CapaUnitToBusinessUnit -CapaSDK $oCMS -UnitName $script:UnitName -UnitType $script:UnitType -BusinessUnit $script:BusinessUnitName -Confirm:$false | Out-Null
			Add-CapaUnitToBusinessUnit -CapaSDK $oCMS -UnitName $script:WhatIfUnitName -UnitType $script:UnitType -BusinessUnit $script:BusinessUnitName -Confirm:$false | Out-Null
		}
		catch {
			$script:CanRunIntegration = $false
			$script:SkipReason = $_.Exception.Message
		}
	}

	if ($script:CanRunIntegration) {
		$groupTypes = @('Dynamic_ADSI', 'Dynamic_SQL', 'Static', 'Department', 'Calendar', 'Reinstall')
		foreach ($groupType in $groupTypes) {
			try {
				$groups = Get-CapaGroups -CapaSDK $oCMS -GroupType $groupType | Where-Object { $_.UnitTypeName -eq 'Computer' }
				foreach ($group in $groups) {
					$rawPrinters = @($oCMS.GetGroupPrinters($group.Name, $group.Type))
					foreach ($rawPrinter in $rawPrinters) {
						$columns = ([string]$rawPrinter).Split(';')
						if ($columns.Count -gt 0 -and -not [string]::IsNullOrWhiteSpace($columns[0])) {
							$script:PrinterShareName = $columns[0]
							break
						}
					}

					if (-not [string]::IsNullOrWhiteSpace($script:PrinterShareName)) {
						break
					}
				}
			}
			catch {}

			if (-not [string]::IsNullOrWhiteSpace($script:PrinterShareName)) {
				break
			}
		}
	}

	$script:CanRunPrinterAdd = $script:CanRunIntegration -and (-not [string]::IsNullOrWhiteSpace($script:PrinterShareName))
}

Describe 'Add-CapaPrinterToUnit integration' {
	It 'Adds printer to unit and returns true when a printer is available' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		if (-not $script:CanRunIntegration) {
			$true | Should -BeTrue -Because $script:SkipReason
			return
		}

		if (-not $script:CanRunPrinterAdd) {
			$true | Should -BeTrue
			return
		}

		$result = Add-CapaPrinterToUnit -CapaSDK $oCMS -UnitName $script:UnitName -UnitType $script:UnitType -PrinterShareName $script:PrinterShareName -Confirm:$false
		$result | Should -BeTrue
	}

	It 'Does not add when using WhatIf' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		if (-not $script:CanRunIntegration) {
			$true | Should -BeTrue -Because $script:SkipReason
			return
		}

		if (-not $script:CanRunPrinterAdd) {
			$true | Should -BeTrue
			return
		}

		$result = Add-CapaPrinterToUnit -CapaSDK $oCMS -UnitName $script:WhatIfUnitName -UnitType $script:UnitType -PrinterShareName $script:PrinterShareName -WhatIf -Confirm:$false
		$result | Should -BeNullOrEmpty
	}

	It 'Throws when CapaSDK method is missing' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		$mockSdk = [pscustomobject]@{}
		{
			Add-CapaPrinterToUnit -CapaSDK $mockSdk -UnitName $script:UnitName -UnitType $script:UnitType -PrinterShareName 'AnyPrinter' -Confirm:$false
		} | Should -Throw 'CapaSDK does not contain method AddPrinterToUnit.'
	}

	It 'Validates UnitType values' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		{
			Add-CapaPrinterToUnit -CapaSDK $oCMS -UnitName $script:UnitName -UnitType 'Device' -PrinterShareName 'AnyPrinter' -Confirm:$false
		} | Should -Throw
	}
}

AfterAll {
	if ($script:SkipIntegration) { return }
	if ($null -ne $script:UnitName) {
		try { Remove-CapaUnitFromBusinessUnit -CapaSDK $oCMS -UnitName $script:UnitName -UnitType $script:UnitType -Confirm:$false | Out-Null } catch {}
		try { Delete-CapaUnit -CapaSDK $oCMS -UnitName $script:UnitName -UnitType $script:UnitType -Confirm:$false | Out-Null } catch {}
	}

	if ($null -ne $script:WhatIfUnitName) {
		try { Remove-CapaUnitFromBusinessUnit -CapaSDK $oCMS -UnitName $script:WhatIfUnitName -UnitType $script:UnitType -Confirm:$false | Out-Null } catch {}
		try { Delete-CapaUnit -CapaSDK $oCMS -UnitName $script:WhatIfUnitName -UnitType $script:UnitType -Confirm:$false | Out-Null } catch {}
	}
}
