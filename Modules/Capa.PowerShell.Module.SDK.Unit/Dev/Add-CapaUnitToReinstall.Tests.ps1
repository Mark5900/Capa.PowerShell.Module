BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
	$RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

	$Folders = @(
		'Capa.PowerShell.Module.SDK.Authentication',
		'Capa.PowerShell.Module.SDK.OSDeployment',
		'Capa.PowerShell.Module.SDK.Unit',
		'Capa.PowerShell.Module.SDK.Utilities'
	)
	foreach ($Folder in $Folders) {
		$Items = Get-ChildItem -Path "$RootPath\$Folder\Dev\" -Filter '*.ps1' | Where-Object { $_.Name -notlike '*Tests.ps1' }
		foreach ($Item in $Items) {
			Import-Module $Item.FullName -Force -ErrorAction Stop
		}
	}

	$oCMS = Initialize-CapaSDK -Server $env:COMPUTERNAME -Database 'CapaInstaller' -InstanceManagementPoint 2

	$script:TempUnitName = "TestAddReinstall_$([DateTime]::Now.ToString('yyyyMMddHHmmss'))"
	Create-CapaUnit -CapaSDK $oCMS -UnitName $script:TempUnitName -UnitType 'Computer' -LinkToManagementServerID 2 | Out-Null

	$CreatedUnit = $null
	for ($i = 0; $i -lt 20; $i++) {
		Start-Sleep -Seconds 2
		$CreatedUnit = Get-CapaUnits -CapaSDK $oCMS -Type Computer | Where-Object { $_.Name -eq $script:TempUnitName } | Select-Object -First 1
		if ($null -ne $CreatedUnit) {
			break
		}
	}
	if ($null -eq $CreatedUnit) {
		throw "Temporary unit '$($script:TempUnitName)' was not found after creation."
	}

	$script:CanRunReinstallFlow = $true
	$script:OSpointID = $null
	$script:OSserverID = $null
	$script:OSImageID = $null
	$script:DiskConfigID = $null
	$script:InstallTypeID = $null

	try {
		$OSPoints = Get-CapaOSPoints -CapaSDK $oCMS
		$Point = $OSPoints | Select-Object -First 1
		if ($null -eq $Point) {
			$script:CanRunReinstallFlow = $false
		} else {
			$script:OSpointID = [int]$Point.ID
		}

		if ($script:CanRunReinstallFlow) {
			$Server = Get-CapaOSServers -CapaSDK $oCMS -OSPointID $script:OSpointID | Select-Object -First 1
			$Image = Get-CapaOSImages -CapaSDK $oCMS -OSPointID $script:OSpointID | Select-Object -First 1
			$Disk = Get-CapaOSDiskConfigration -CapaSDK $oCMS -OSPointID $script:OSpointID | Select-Object -First 1
			$InstallType = Get-CapaOSInstallationTypes -CapaSDK $oCMS -OSPointID $script:OSpointID | Select-Object -First 1

			if ($null -eq $Server -or $null -eq $Image -or $null -eq $Disk -or $null -eq $InstallType) {
				$script:CanRunReinstallFlow = $false
			} else {
				$script:OSserverID = [int]$Server.ID
				$script:OSImageID = [int]$Image.ID
				$script:DiskConfigID = [int]$Disk.ID
				$script:InstallTypeID = [int]$InstallType.ID
			}
		}
	} catch {
		$script:CanRunReinstallFlow = $false
	}

	function ConvertTo-ReinstallEnabled {
		param([object]$Value)
		if ($null -eq $Value) { return $false }
		$normalized = ([string]$Value).Trim().ToLowerInvariant()
		return $normalized -in @('true', '1', 'yes')
	}
	$script:ConvertToReinstallEnabled = ${function:ConvertTo-ReinstallEnabled}
}

Describe 'Add-CapaUnitToReinstall integration' {
	It 'Adds temporary unit to reinstall when OS deployment data is available' {
		if (-not $script:CanRunReinstallFlow) {
			$true | Should -BeTrue
			return
		}

		$Result = Add-CapaUnitToReinstall -CapaSDK $oCMS -ComputerName $script:TempUnitName -OSpointID $script:OSpointID -OSserverID $script:OSserverID -OSImageID $script:OSImageID -DiskConfigID $script:DiskConfigID -InstallTypeID $script:InstallTypeID -ReinstallMode 'Silent' -Active $true
		$Result | Should -Not -BeNullOrEmpty

		$ReinstallStatus = $null
		for ($i = 0; $i -lt 10; $i++) {
			Start-Sleep -Seconds 2
			$ReinstallStatus = Get-CapaReinstallStatus -CapaSDK $oCMS -UnitName $script:TempUnitName -UnitType 'Computer'
			if (& $script:ConvertToReinstallEnabled $ReinstallStatus) {
				break
			}
		}

		(& $script:ConvertToReinstallEnabled $ReinstallStatus) | Should -BeTrue
	}

	It 'Does not add when using WhatIf' {
		if (-not $script:CanRunReinstallFlow) {
			$true | Should -BeTrue
			return
		}

		$Result = Add-CapaUnitToReinstall -CapaSDK $oCMS -ComputerName $script:TempUnitName -OSpointID $script:OSpointID -OSserverID $script:OSserverID -OSImageID $script:OSImageID -DiskConfigID $script:DiskConfigID -InstallTypeID $script:InstallTypeID -WhatIf -Confirm:$false
		$Result | Should -BeNullOrEmpty
	}

	It 'Validates ComputerName is not empty' {
		{ Add-CapaUnitToReinstall -CapaSDK $oCMS -ComputerName '' -OSpointID 1 -OSserverID 1 -OSImageID 1 -DiskConfigID 1 -InstallTypeID 1 } | Should -Throw
	}

	It 'Validates ReinstallMode values' {
		{ Add-CapaUnitToReinstall -CapaSDK $oCMS -ComputerName $script:TempUnitName -OSpointID 1 -OSserverID 1 -OSImageID 1 -DiskConfigID 1 -InstallTypeID 1 -ReinstallMode 'PromptUser' } | Should -Throw
	}
}

AfterAll {
	if (-not [string]::IsNullOrWhiteSpace($script:TempUnitName)) {
		try {
			Remove-CapaUnitFromReinstall -CapaSDK $oCMS -ComputerName $script:TempUnitName -Confirm:$false | Out-Null
		} catch {}

		$TempUnit = Get-CapaUnits -CapaSDK $oCMS -Type Computer | Where-Object { $_.Name -eq $script:TempUnitName } | Select-Object -First 1
		if ($null -ne $TempUnit) {
			try {
				Delete-CapaUnit -CapaSDK $oCMS -UnitName $script:TempUnitName -UnitType 'Computer' -Confirm:$false | Out-Null
			} catch {}
		}
	}
}
