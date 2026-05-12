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

	$script:GroupName = "TestGetGroups_$([DateTime]::Now.ToString('yyyyMMddHHmmss'))"
	$script:CanManageGroups = $true
	try {
		Create-CapaGroup -CapaSDK $oCMS -GroupName $script:GroupName -GroupType Static -UnitType Computer -Confirm:$false | Out-Null
	} catch {
		$script:CanManageGroups = $false
	}
}

Describe 'Get-CapaGroups' {
	It 'Returns groups without filtering' {
		$Result = Get-CapaGroups -CapaSDK $oCMS
		$Result | Should -Not -BeNullOrEmpty
	}

	It 'Returns Static groups' {
		$Result = Get-CapaGroups -CapaSDK $oCMS -GroupType Static
		$Result | Should -Not -BeNullOrEmpty
	}

	It 'Includes the temporary test group in Static results' {
		if (-not $script:CanManageGroups) {
			Set-ItResult -Skipped -Because 'Insufficient rights to create groups in this environment.'
			return
		}

		$Result = Get-CapaGroups -CapaSDK $oCMS -GroupType Static
		$Found = $Result | Where-Object { $_.Name -eq $script:GroupName } | Select-Object -First 1
		$Found | Should -Not -BeNullOrEmpty
	}
}

AfterAll {
	if ($null -ne $script:GroupName -and $script:CanManageGroups) {
		try {
			Remove-CapaGroup -CapaSDK $oCMS -GroupName $script:GroupName -GroupType Static -UnitType Computer -Confirm:$false | Out-Null
		} catch {
			# Ignore cleanup failures in restricted environments.
		}
	}
}
