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

	$script:UnitType = 'Computer'
	$script:BusinessUnitName = 'TestBU'
	$script:CreatedUnits = @()

	$businessUnits = Get-CapaBusinessUnits -CapaSDK $oCMS
	$script:HasTestBU = $null -ne ($businessUnits | Where-Object { $_.Name -eq $script:BusinessUnitName } | Select-Object -First 1)
}

Describe 'Create-CapaUnit integration' {
	It 'Creates a new unit and returns true' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		$unitName = "PesterCreateUnit_$([guid]::NewGuid().ToString('N').Substring(0, 8))"
		$result = Create-CapaUnit -CapaSDK $oCMS -UnitName $unitName -UnitType $script:UnitType -LinkToManagementServerID 2 -Confirm:$false
		$result | Should -BeTrue

		$script:CreatedUnits += $unitName

		$createdUnit = $null
		for ($i = 0; $i -lt 20; $i++) {
			Start-Sleep -Seconds 2
			$createdUnit = Get-CapaUnits -CapaSDK $oCMS -Type Computer | Where-Object { $_.Name -eq $unitName } | Select-Object -First 1
			if ($null -ne $createdUnit) {
				break
			}
		}

		$createdUnit | Should -Not -BeNullOrEmpty

		if ($script:HasTestBU) {
			try {
				$null = Add-CapaUnitToBusinessUnit -CapaSDK $oCMS -UnitName $unitName -UnitType $script:UnitType -BusinessUnit $script:BusinessUnitName -Confirm:$false
			}
			catch {
			}
		}
	}

	It 'Does not create when using WhatIf' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		$unitName = "PesterCreateUnitWhatIf_$([guid]::NewGuid().ToString('N').Substring(0, 8))"
		$result = Create-CapaUnit -CapaSDK $oCMS -UnitName $unitName -UnitType $script:UnitType -LinkToManagementServerID 2 -WhatIf -Confirm:$false
		$result | Should -BeNullOrEmpty

		$createdUnit = Get-CapaUnits -CapaSDK $oCMS -Type Computer | Where-Object { $_.Name -eq $unitName } | Select-Object -First 1
		$createdUnit | Should -BeNullOrEmpty
	}

	It 'Throws when CapaSDK method is missing' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		$mockSdk = [pscustomobject]@{}
		{
			Create-CapaUnit -CapaSDK $mockSdk -UnitName 'AnyUnit' -UnitType 'Computer' -LinkToManagementServerID 2 -Confirm:$false
		} | Should -Throw 'CapaSDK does not contain method CreateUnit.'
	}

	It 'Validates LinkToManagementServerID range' {
		if ($script:SkipIntegration) { Set-ItResult -Skipped -Because $script:SkipReason; return }
		{
			Create-CapaUnit -CapaSDK $oCMS -UnitName 'AnyUnit' -UnitType 'Computer' -LinkToManagementServerID 0 -Confirm:$false
		} | Should -Throw
	}
}

AfterAll {
	if ($script:SkipIntegration) { return }
	foreach ($unitName in $script:CreatedUnits) {
		if (-not [string]::IsNullOrWhiteSpace($unitName)) {
			if ($script:HasTestBU) {
				try {
					Remove-CapaUnitFromBusinessUnit -CapaSDK $oCMS -UnitName $unitName -UnitType $script:UnitType -Confirm:$false | Out-Null
				}
				catch {}
			}

			try {
				Delete-CapaUnit -CapaSDK $oCMS -UnitName $unitName -UnitType $script:UnitType -Confirm:$false | Out-Null
			}
			catch {}
		}
	}
}
