BeforeAll {
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

	$oCMS = Initialize-CapaSDK -Server $env:COMPUTERNAME -Database 'CapaInstaller' -InstanceManagementPoint 2

	$Units = Get-CapaUnits -CapaSDK $oCMS -Type Computer
	$script:ExistingComputer = $Units | Where-Object { $_.Name -eq $env:COMPUTERNAME } | Select-Object -First 1
	if ($null -eq $script:ExistingComputer) {
		throw "Computer unit '$env:COMPUTERNAME' was not found in CapaInstaller."
	}

	$script:TempComputerName = "TestLinkedUserComp_$([DateTime]::Now.ToString('yyyyMMddHHmmss'))"
	Create-CapaUnit -CapaSDK $oCMS -UnitName $script:TempComputerName -UnitType 'Computer' -LinkToManagementServerID 2 | Out-Null

	$CreatedUnit = $null
	for ($i = 0; $i -lt 20; $i++) {
		Start-Sleep -Seconds 2
		$CreatedUnit = Get-CapaUnits -CapaSDK $oCMS -Type Computer | Where-Object { $_.Name -eq $script:TempComputerName } | Select-Object -First 1
		if ($null -ne $CreatedUnit) {
			break
		}
	}
	if ($null -eq $CreatedUnit) {
		throw "Temporary computer unit '$($script:TempComputerName)' was not found after creation."
	}
}

Describe 'Get-CapaUnitLinkedUser integration' {
	It 'Queries linked users for existing computer without throwing' {
		{ Get-CapaUnitLinkedUser -CapaSDK $oCMS -ComputerName $script:ExistingComputer.Name } | Should -Not -Throw
	}

	It 'Queries linked users for temporary computer without throwing' {
		{ Get-CapaUnitLinkedUser -CapaSDK $oCMS -ComputerName $script:TempComputerName } | Should -Not -Throw
	}

	It 'Returns expected properties when linked users are returned' {
		$Result = Get-CapaUnitLinkedUser -CapaSDK $oCMS -ComputerName $script:ExistingComputer.Name
		if ($null -ne $Result -and $Result.Count -gt 0) {
			$Properties = $Result[0].PSObject.Properties.Name
			$Properties -contains 'Name' | Should -BeTrue
			$Properties -contains 'GUID' | Should -BeTrue
			$Properties -contains 'TypeName' | Should -BeTrue
		} else {
			$true | Should -BeTrue
		}
	}

	It 'Validates ComputerName is not empty' {
		{ Get-CapaUnitLinkedUser -CapaSDK $oCMS -ComputerName '' } | Should -Throw
	}
}

AfterAll {
	if (-not [string]::IsNullOrWhiteSpace($script:TempComputerName)) {
		$TempUnit = Get-CapaUnits -CapaSDK $oCMS -Type Computer | Where-Object { $_.Name -eq $script:TempComputerName } | Select-Object -First 1
		if ($null -ne $TempUnit) {
			try {
				Delete-CapaUnit -CapaSDK $oCMS -UnitName $script:TempComputerName -UnitType 'Computer' | Out-Null
			} catch {}
		}
	}
}
