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

	$script:UnitName = "PesterUnitFolderAdd_$([guid]::NewGuid().ToString('N').Substring(0, 8))"
	$script:WhatIfUnitName = "PesterUnitFolderWhatIf_$([guid]::NewGuid().ToString('N').Substring(0, 8))"
	$script:UnitType = 'Computer'
	$script:FolderStructure = "Pester\Unit\$([guid]::NewGuid().ToString('N').Substring(0, 8))"
	$script:WhatIfFolderStructure = "Pester\Unit\$([guid]::NewGuid().ToString('N').Substring(0, 8))"

	Create-CapaUnit -CapaSDK $oCMS -UnitName $script:UnitName -UnitType $script:UnitType -LinkToManagementServerID 2 | Out-Null
	Create-CapaUnit -CapaSDK $oCMS -UnitName $script:WhatIfUnitName -UnitType $script:UnitType -LinkToManagementServerID 2 | Out-Null

	$unitVisible = $false
	for ($i = 0; $i -lt 20; $i++) {
		Start-Sleep -Seconds 2
		$current = Get-CapaUnits -CapaSDK $oCMS -Type Computer
		$firstExists = $null -ne ($current | Where-Object { $_.Name -eq $script:UnitName } | Select-Object -First 1)
		$secondExists = $null -ne ($current | Where-Object { $_.Name -eq $script:WhatIfUnitName } | Select-Object -First 1)
		if ($firstExists -and $secondExists) {
			$unitVisible = $true
			break
		}
	}

	if (-not $unitVisible) {
		throw 'Temporary units were not visible after creation.'
	}
}

Describe 'Add-CapaUnitToFolder integration' {
	It 'Adds unit to target folder and returns true' {
		$result = Add-CapaUnitToFolder -CapaSDK $oCMS -UnitName $script:UnitName -UnitType $script:UnitType -FolderStructure $script:FolderStructure -CreateFolder 'true' -Confirm:$false
		$result | Should -BeTrue

		$normalizedTarget = ([string]$script:FolderStructure).Replace('\\', '\').TrimEnd('\\')
		$folderMatched = $false
		for ($i = 0; $i -lt 60; $i++) {
			Start-Sleep -Seconds 2
			$currentFolder = [string]$oCMS.GetUnitFolder($script:UnitName, $script:UnitType)
			$normalizedCurrent = ([string]$currentFolder).Replace('\\', '\').TrimEnd('\\')
			if (-not [string]::IsNullOrWhiteSpace($normalizedCurrent) -and $normalizedCurrent.EndsWith($normalizedTarget, [System.StringComparison]::OrdinalIgnoreCase)) {
				$folderMatched = $true
				break
			}
		}

		$folderMatched | Should -BeTrue -Because "Last observed folder was '$currentFolder' and target was '$($script:FolderStructure)'"
	}

	It 'Does not add when using WhatIf' {
		$originalFolder = [string](Get-CapaUnitFolder -CapaSDK $oCMS -UnitName $script:WhatIfUnitName -UnitType $script:UnitType)

		$result = Add-CapaUnitToFolder -CapaSDK $oCMS -UnitName $script:WhatIfUnitName -UnitType $script:UnitType -FolderStructure $script:WhatIfFolderStructure -CreateFolder 'true' -WhatIf -Confirm:$false
		$result | Should -BeNullOrEmpty

		$folderAfterWhatIf = [string](Get-CapaUnitFolder -CapaSDK $oCMS -UnitName $script:WhatIfUnitName -UnitType $script:UnitType)
		$folderAfterWhatIf | Should -Be $originalFolder
	}

	It 'Throws when CapaSDK method is missing' {
		$mockSdk = [pscustomobject]@{}
		{
			Add-CapaUnitToFolder -CapaSDK $mockSdk -UnitName $script:UnitName -UnitType $script:UnitType -FolderStructure $script:FolderStructure -CreateFolder 'true' -Confirm:$false
		} | Should -Throw 'CapaSDK does not contain method AddUnitToFolder.'
	}

	It 'Validates UnitType values' {
		{
			Add-CapaUnitToFolder -CapaSDK $oCMS -UnitName $script:UnitName -UnitType 'Device' -FolderStructure $script:FolderStructure -CreateFolder 'true' -Confirm:$false
		} | Should -Throw
	}
}

AfterAll {
	if (-not [string]::IsNullOrWhiteSpace($script:UnitName)) {
		try {
			Delete-CapaUnit -CapaSDK $oCMS -UnitName $script:UnitName -UnitType $script:UnitType -Confirm:$false | Out-Null
		}
		catch {}
	}

	if (-not [string]::IsNullOrWhiteSpace($script:WhatIfUnitName)) {
		try {
			Delete-CapaUnit -CapaSDK $oCMS -UnitName $script:WhatIfUnitName -UnitType $script:UnitType -Confirm:$false | Out-Null
		}
		catch {}
	}
}
