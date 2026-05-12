BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
	$RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

	$Folders = @(
		'Capa.PowerShell.Module.SDK.Authentication',
		'Capa.PowerShell.Module.SDK.Inventory',
		'Capa.PowerShell.Module.SDK.Unit'
	)
	foreach ($Folder in $Folders) {
		$Items = Get-ChildItem -Path "$RootPath\$Folder\Dev\" -Filter '*.ps1' | Where-Object { $_.Name -notlike '*Tests.ps1' }
		foreach ($Item in $Items) {
			Import-Module $Item.FullName -Force -ErrorAction Stop
		}
	}

	$oCMS = Initialize-CapaSDK -Server $env:COMPUTERNAME -Database 'CapaInstaller' -InstanceManagementPoint 2

	$Units = Get-CapaUnits -CapaSDK $oCMS -Type Computer
	if ($null -eq $Units -or $Units.Count -eq 0) {
		throw 'No computer units found. Cannot run Get-CapaHardwareInventoryForUnit integration test.'
	}

	$script:TargetUnit = $Units | Where-Object { $_.Name -eq $env:COMPUTERNAME } | Select-Object -First 1
	if ($null -eq $script:TargetUnit) {
		$script:TargetUnit = $Units | Select-Object -First 1
	}
}

Describe 'Get-CapaHardwareInventoryForUnit' {
	It 'Returns hardware inventory for a computer unit' {
		$Result = Get-CapaHardwareInventoryForUnit -CapaSDK $oCMS -UnitName $script:TargetUnit.Name -UnitType Computer
		$Result | Should -Not -Be $null
	}

	It 'Throws when UnitName is empty' {
		{ Get-CapaHardwareInventoryForUnit -CapaSDK $oCMS -UnitName '' -UnitType Computer } | Should -Throw
	}
}
