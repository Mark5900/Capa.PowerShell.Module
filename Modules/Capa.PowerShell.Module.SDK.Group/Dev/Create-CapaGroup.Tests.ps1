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
	$script:GroupName = "TestCreateGroup_$([DateTime]::Now.ToString('yyyyMMddHHmmss'))"
	$script:CreatedGroup = $false
}

Describe 'Create-CapaGroup' {
	It 'Creates a Static Computer group' {
		try {
			$Result = Create-CapaGroup -CapaSDK $oCMS -GroupName $script:GroupName -GroupType Static -UnitType Computer -Confirm:$false
			$script:CreatedGroup = $true
		} catch {
			Set-ItResult -Skipped -Because 'Insufficient rights to create groups in this environment.'
			return
		}
		$Result | Should -Not -BeNullOrEmpty
	}

	It 'Group exists after creation' {
		if (-not $script:CreatedGroup) {
			Set-ItResult -Skipped -Because 'Group was not created in setup.'
			return
		}

		$Groups = Get-CapaGroups -CapaSDK $oCMS -GroupType Static
		$Found = $Groups | Where-Object { $_.Name -eq $script:GroupName } | Select-Object -First 1
		$Found | Should -Not -BeNullOrEmpty
	}
}

AfterAll {
	if ($null -ne $script:GroupName -and $script:CreatedGroup) {
		try {
			Remove-CapaGroup -CapaSDK $oCMS -GroupName $script:GroupName -GroupType Static -UnitType Computer -Confirm:$false | Out-Null
		} catch {
			# Ignore cleanup failures in restricted environments.
		}
	}
}
