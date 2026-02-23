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
	if ($null -eq $Units -or $Units.Count -eq 0) {
		throw 'No computer units found in CapaInstaller. Cannot run Set-CapaUnitStatus integration test.'
	}

	$script:TargetUnit = $Units | Where-Object { $_.Name -eq $env:COMPUTERNAME } | Select-Object -First 1
	if ($null -eq $script:TargetUnit) {
		throw "Computer unit '$env:COMPUTERNAME' was not found in CapaInstaller."
	}

	$script:UnitName = $script:TargetUnit.Name
	if ($script:TargetUnit.Status -eq 'Inactive') {
		$script:OriginalStatus = 'Inactive'
	} else {
		$script:OriginalStatus = 'Active'
	}
}

Describe 'Set-CapaUnitStatus integration' {
	It 'Sets status on an existing computer unit' {
		$DesiredStatus = if ($script:OriginalStatus -eq 'Active') { 'Inactive' } else { 'Active' }

		$Result = Set-CapaUnitStatus -CapaSDK $oCMS -UnitName $script:UnitName -Status $DesiredStatus -Confirm:$false
		$Result | Should -Not -Be 'No Unit Returned.'
		$Result | Should -Not -BeNullOrEmpty

		$ObservedStatus = $null
		for ($i = 0; $i -lt 10; $i++) {
			Start-Sleep -Seconds 2
			$CurrentUnit = Get-CapaUnits -CapaSDK $oCMS -Type Computer | Where-Object { $_.Name -eq $script:UnitName } | Select-Object -First 1
			if ($null -ne $CurrentUnit) {
				$ObservedStatus = $CurrentUnit.Status
				if ($ObservedStatus -eq $DesiredStatus) {
					break
				}
			}
		}

		$ObservedStatus | Should -Be $DesiredStatus
	}
}

AfterAll {
	if ($null -ne $script:UnitName -and $null -ne $script:OriginalStatus) {
		Set-CapaUnitStatus -CapaSDK $oCMS -UnitName $script:UnitName -Status $script:OriginalStatus -Confirm:$false | Out-Null
	}
}
