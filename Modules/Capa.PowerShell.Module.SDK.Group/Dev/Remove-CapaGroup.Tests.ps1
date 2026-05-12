BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
	$RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

	$Folders = @(
		'Capa.PowerShell.Module.SDK.Authentication',
		'Capa.PowerShell.Module.SDK.Group'
	)
	foreach ($Folder in $Folders) {
		$Items = Get-ChildItem -Path "$RootPath\$Folder\Dev\" -Filter '*.ps1' | Where-Object { $_.Name -notlike '*Tests.ps1' }
		foreach ($Item in $Items) {
			Import-Module $Item.FullName -Force -ErrorAction Stop
		}
	}

	$oCMS = Initialize-CapaSDK -Server $env:COMPUTERNAME -Database 'CapaInstaller' -InstanceManagementPoint 2

	$script:GroupName = "TestRemoveGroup_$([DateTime]::Now.ToString('yyyyMMddHHmmss'))"
	$script:CanManageGroups = $true
	try {
		Create-CapaGroup -CapaSDK $oCMS -GroupName $script:GroupName -GroupType Static -UnitType Computer -Confirm:$false | Out-Null
	} catch {
		$script:CanManageGroups = $false
	}
}

Describe 'Remove-CapaGroup' {
	It 'Removes an existing Static Computer group' {
		if (-not $script:CanManageGroups) {
			Set-ItResult -Skipped -Because 'Insufficient rights to create/remove groups in this environment.'
			return
		}

		$Result = Remove-CapaGroup -CapaSDK $oCMS -GroupName $script:GroupName -GroupType Static -UnitType Computer -Confirm:$false
		$Result | Should -Not -BeNullOrEmpty
	}

	It 'Group no longer exists after removal' {
		if (-not $script:CanManageGroups) {
			Set-ItResult -Skipped -Because 'Insufficient rights to create/remove groups in this environment.'
			return
		}

		$Groups = Get-CapaGroups -CapaSDK $oCMS -GroupType Static
		$Found = $Groups | Where-Object { $_.Name -eq $script:GroupName } | Select-Object -First 1
		$Found | Should -BeNullOrEmpty
	}
}
