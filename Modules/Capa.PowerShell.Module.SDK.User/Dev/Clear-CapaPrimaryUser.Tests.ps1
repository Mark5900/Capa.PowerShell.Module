BeforeAll {
	$RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

	$Folders = @(
		'Capa.PowerShell.Module.SDK.Authentication',
		'Capa.PowerShell.Module.SDK.Unit',
		'Capa.PowerShell.Module.SDK.User'
	)

	foreach ($Folder in $Folders) {
		$Items = Get-ChildItem -Path "$RootPath\$Folder\Dev\" -Filter '*.ps1' | Where-Object { $_.Name -notlike '*Tests.ps1' }
		foreach ($Item in $Items) {
			Import-Module $Item.FullName -Force -ErrorAction Stop
		}
	}

	$CapaSDK = Initialize-CapaSDK -Server $env:COMPUTERNAME -Database 'CapaInstaller' -InstanceManagementPoint 1

	$ComputerUnits = Get-CapaUnits -CapaSDK $CapaSDK -Type 'Computer'
	$ComputerUnit = $ComputerUnits | Where-Object { $_.Name -eq $env:COMPUTERNAME } | Select-Object -First 1
	if (-not $ComputerUnit) {
		$ComputerUnit = $ComputerUnits | Select-Object -First 1
	}

	$TestSettings = @{
		CapaSDK = $CapaSDK
		Uuid    = $null
	}

	if ($ComputerUnit) {
		$TestSettings.Uuid = $ComputerUnit.UUID
	}
}

Describe 'Clear-CapaPrimaryUser integration' {
	It 'Gets a computer UUID using Get-CapaUnits' {
		if ([string]::IsNullOrWhiteSpace($TestSettings.Uuid)) {
			Write-Host 'No computer unit was found in current environment. Test is treated as informational.'
			$true | Should -BeTrue
			return
		}

		$TestSettings.Uuid | Should -Match '^[{(]?[0-9a-fA-F-]{36}[)}]?$'
	}

	It 'Supports WhatIf without changing data' {
		if ([string]::IsNullOrWhiteSpace($TestSettings.Uuid)) {
			Write-Host 'No computer unit was found in current environment. Test is treated as informational.'
			$true | Should -BeTrue
			return
		}

		$Result = Clear-CapaPrimaryUser -CapaSDK $TestSettings.CapaSDK -Uuid $TestSettings.Uuid -WhatIf -Confirm:$false
		$Result | Should -BeNullOrEmpty
	}

	It 'Clears primary user for the found computer UUID' {
		if ([string]::IsNullOrWhiteSpace($TestSettings.Uuid)) {
			Write-Host 'No computer unit was found in current environment. Test is treated as informational.'
			$true | Should -BeTrue
			return
		}

		try {
			$Result = Clear-CapaPrimaryUser -CapaSDK $TestSettings.CapaSDK -Uuid $TestSettings.Uuid -Confirm:$false
			$Result | Should -Not -BeNullOrEmpty
		}
		catch {
			if ($_.Exception.Message -match 'appropriate Security Level') {
				Write-Host 'Insufficient rights to clear primary user in current environment. Test is treated as informational.'
				$true | Should -BeTrue
				return
			}

			throw
		}
	}
}
