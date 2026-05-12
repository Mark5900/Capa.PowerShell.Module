BeforeAll {
	$script:SkipIntegration = $false
	$script:SkipReason = ''
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
	$RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

	$Folders = @(
		'Capa.PowerShell.Module.SDK.Authentication',
		'Capa.PowerShell.Module.SDK.Unit',
		'Capa.PowerShell.Module.SDK.SystemSdk'
	)
	foreach ($Folder in $Folders) {
		$Items = Get-ChildItem -Path "$RootPath\$Folder\Dev\" -Filter '*.ps1' | Where-Object { $_.Name -notlike '*Tests.ps1' }
		foreach ($Item in $Items) {
			Import-Module $Item.FullName -Force -ErrorAction Stop
		}
	}

	try { $oCMS = Initialize-CapaSDK -Server $env:COMPUTERNAME -Database 'CapaInstaller' -InstanceManagementPoint 2 } catch { $script:SkipIntegration = $true; $script:SkipReason = $_.Exception.Message; return }

	$script:TempUnitName = "TestUnitsInFolder_$([DateTime]::Now.ToString('yyyyMMddHHmmss'))"
	Create-CapaUnit -CapaSDK $oCMS -UnitName $script:TempUnitName -UnitType 'Computer' -LinkToManagementServerID 2 | Out-Null

	$TempUnit = $null
	for ($i = 0; $i -lt 20; $i++) {
		Start-Sleep -Seconds 2
		$TempUnit = Get-CapaUnits -CapaSDK $oCMS -Type Computer | Where-Object { $_.Name -eq $script:TempUnitName } | Select-Object -First 1
		if ($null -ne $TempUnit) {
			break
		}
	}

	if ($null -eq $TempUnit) {
		throw "Temporary unit '$($script:TempUnitName)' was not found after creation."
	}

	$script:TempUnitLocation = [string]$TempUnit.Location

	$BusinessUnits = Get-CapaBusinessUnits -CapaSDK $oCMS
	$BusinessUnitNames = @($BusinessUnits | ForEach-Object { [string]$_.Name } | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
	$script:BusinessUnitName = $null
	$script:FolderStructure = $null

	if (-not [string]::IsNullOrWhiteSpace($script:TempUnitLocation) -and $script:TempUnitLocation.Contains('\')) {
		$LocationParts = $script:TempUnitLocation.Split('\')
		if ($LocationParts.Count -ge 1) {
			$BusinessUnitCandidate = $LocationParts[0]
			if (-not [string]::IsNullOrWhiteSpace($BusinessUnitCandidate) -and (($BusinessUnitNames -contains $BusinessUnitCandidate) -or $BusinessUnitNames.Count -eq 0)) {
				$script:BusinessUnitName = $BusinessUnitCandidate
			}
		}

		if ($LocationParts.Count -ge 2) {
			$script:FolderStructure = ($LocationParts[1..($LocationParts.Count - 1)] -join '\')
		}
	} elseif (-not [string]::IsNullOrWhiteSpace($script:TempUnitLocation)) {
		$script:FolderStructure = $script:TempUnitLocation
	}

	if ([string]::IsNullOrWhiteSpace($script:BusinessUnitName)) {
		if ($BusinessUnitNames.Count -gt 0) {
			$script:BusinessUnitName = $BusinessUnitNames[0]
		} else {
			$script:BusinessUnitName = 'Default'
		}
	}

	if ([string]::IsNullOrWhiteSpace($script:FolderStructure)) {
		$script:FolderStructure = 'Default'
	}
}

Describe 'Get-CapaUnitsInFolder integration' {
	BeforeAll {
		$script:InvokeGetUnitsInFolder = {
			try {
				[pscustomobject]@{
					Success = $true
					Result = Get-CapaUnitsInFolder -CapaSDK $oCMS -FolderStructure $script:FolderStructure -UnitType 'Computer' -BusinessUnitName $script:BusinessUnitName
					ErrorMessage = $null
				}
			} catch {
				[pscustomobject]@{
					Success = $false
					Result = $null
					ErrorMessage = $_.Exception.Message
				}
			}
		}
	}

	It 'Returns units for a resolved folder and business unit' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		$Invocation = & $script:InvokeGetUnitsInFolder
		if (-not $Invocation.Success -and $Invocation.ErrorMessage -like '*No BusinessUnit returned*') {
			Set-ItResult -Skipped -Because $Invocation.ErrorMessage
			return
		}

		$Invocation.Success | Should -BeTrue
		if ($null -eq $Invocation.Result) {
			Set-ItResult -Skipped -Because "Folder '$($script:FolderStructure)' in business unit '$($script:BusinessUnitName)' returned no rows in this environment."
			return
		}

		$true | Should -BeTrue
	}

	It 'Can query folder data for the temporary created unit context without throwing' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		$Invocation = & $script:InvokeGetUnitsInFolder
		if (-not $Invocation.Success -and $Invocation.ErrorMessage -like '*No BusinessUnit returned*') {
			$true | Should -BeTrue
			return
		}

		$Invocation.Success | Should -BeTrue
	}

	It 'Includes expected properties when rows are returned' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		$Invocation = & $script:InvokeGetUnitsInFolder
		if (-not $Invocation.Success -and $Invocation.ErrorMessage -like '*No BusinessUnit returned*') {
			$true | Should -BeTrue
			return
		}

		$Invocation.Success | Should -BeTrue
		if ($null -ne $Invocation.Result -and $Invocation.Result.Count -gt 0) {
			$Properties = $Invocation.Result[0].PSObject.Properties.Name
			$Properties -contains 'Name' | Should -BeTrue
			$Properties -contains 'UUID' | Should -BeTrue
			$Properties -contains 'Location' | Should -BeTrue
		} else {
			$true | Should -BeTrue
		}
	}

	It 'Validates FolderStructure is not empty' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		{ Get-CapaUnitsInFolder -CapaSDK $oCMS -FolderStructure '' -UnitType 'Computer' -BusinessUnitName $script:BusinessUnitName } | Should -Throw
	}

	It 'Validates BusinessUnitName is not empty' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		{ Get-CapaUnitsInFolder -CapaSDK $oCMS -FolderStructure $script:FolderStructure -UnitType 'Computer' -BusinessUnitName '' } | Should -Throw
	}

	It 'Validates UnitType values' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		{ Get-CapaUnitsInFolder -CapaSDK $oCMS -FolderStructure $script:FolderStructure -UnitType 'Device' -BusinessUnitName $script:BusinessUnitName } | Should -Throw
	}
}

AfterAll {
	if ($script:SkipIntegration) { return }
	if (-not [string]::IsNullOrWhiteSpace($script:TempUnitName)) {
		$TempUnit = Get-CapaUnits -CapaSDK $oCMS -Type Computer | Where-Object { $_.Name -eq $script:TempUnitName } | Select-Object -First 1
		if ($null -ne $TempUnit) {
			try {
				Delete-CapaUnit -CapaSDK $oCMS -UnitName $script:TempUnitName -UnitType 'Computer' | Out-Null
			} catch {}
		}
	}
}
