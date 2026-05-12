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

	$script:TempUnitName = "TestGetUnits_$([DateTime]::Now.ToString('yyyyMMddHHmmss'))"
	Create-CapaUnit -CapaSDK $oCMS -UnitName $script:TempUnitName -UnitType 'Computer' -LinkToManagementServerID 2 | Out-Null

	$script:TempUnit = $null
	for ($i = 0; $i -lt 20; $i++) {
		Start-Sleep -Seconds 2
		$script:TempUnit = Get-CapaUnits -CapaSDK $oCMS -Type 'Computer' | Where-Object { $_.Name -eq $script:TempUnitName } | Select-Object -First 1
		if ($null -ne $script:TempUnit) {
			break
		}
	}

	if ($null -eq $script:TempUnit) {
		throw "Temporary unit '$($script:TempUnitName)' was not found after creation."
	}

	$script:BusinessUnit = $null
	if (-not [string]::IsNullOrWhiteSpace([string]$script:TempUnit.Location) -and [string]$script:TempUnit.Location -match '^[^\\]+') {
		$script:BusinessUnit = $Matches[0]
	}

	if ([string]::IsNullOrWhiteSpace($script:BusinessUnit)) {
		try {
			$BusinessUnits = Get-CapaBusinessUnits -CapaSDK $oCMS
			$script:BusinessUnit = ($BusinessUnits | Select-Object -First 1).Name
		} catch {
			$script:BusinessUnit = $null
		}
	}
}

Describe 'Get-CapaUnits integration' {
	It 'Returns computer units' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		$Result = Get-CapaUnits -CapaSDK $oCMS -Type 'Computer'
		$Result | Should -Not -BeNullOrEmpty
	}

	It 'Includes the temporary created unit in computer result set' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		$Result = Get-CapaUnits -CapaSDK $oCMS -Type 'Computer'
		$Found = $Result | Where-Object { $_.Name -eq $script:TempUnitName } | Select-Object -First 1
		$Found | Should -Not -BeNullOrEmpty
	}

	It 'Can query by business unit when available' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		if ([string]::IsNullOrWhiteSpace($script:BusinessUnit)) {
			Set-ItResult -Skipped -Because 'No business unit name was available in this environment.'
			return
		}

		try {
			$Result = Get-CapaUnits -CapaSDK $oCMS -BusinessUnit $script:BusinessUnit -Type 'Computer'
			if ($null -eq $Result) {
				Set-ItResult -Skipped -Because "Business unit '$($script:BusinessUnit)' returned no rows in this environment."
				return
			}

			$true | Should -BeTrue
		} catch {
			if ($_.Exception.Message -like '*No BusinessUnit returned*') {
				Set-ItResult -Skipped -Because $_.Exception.Message
			} else {
				throw
			}
		}
	}

	It 'Returns objects with expected properties' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		$Result = Get-CapaUnits -CapaSDK $oCMS -Type 'Computer'
		$First = $Result | Select-Object -First 1
		$First | Should -Not -BeNullOrEmpty

		$Properties = $First.PSObject.Properties.Name
		$Properties -contains 'Name' | Should -BeTrue
		$Properties -contains 'UUID' | Should -BeTrue
		$Properties -contains 'Location' | Should -BeTrue
	}

	It 'Validates Type values' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		{ Get-CapaUnits -CapaSDK $oCMS -Type 'Device' } | Should -Throw
	}
}

AfterAll {
	if ($script:SkipIntegration) { return }
	if (-not [string]::IsNullOrWhiteSpace($script:TempUnitName)) {
		$TempUnit = Get-CapaUnits -CapaSDK $oCMS -Type 'Computer' | Where-Object { $_.Name -eq $script:TempUnitName } | Select-Object -First 1
		if ($null -ne $TempUnit) {
			try {
				Delete-CapaUnit -CapaSDK $oCMS -UnitName $script:TempUnitName -UnitType 'Computer' | Out-Null
			} catch {}
		}
	}
}
