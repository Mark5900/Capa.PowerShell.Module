BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
	$RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

	$Folders = @(
		'Capa.PowerShell.Module.SDK.Authentication',
		'Capa.PowerShell.Module.SDK.Inventory',
		'Capa.PowerShell.Module.SDK.User'
	)
	foreach ($Folder in $Folders) {
		$Items = Get-ChildItem -Path "$RootPath\$Folder\Dev\" -Filter '*.ps1' | Where-Object { $_.Name -notlike '*Tests.ps1' }
		foreach ($Item in $Items) {
			Import-Module $Item.FullName -Force -ErrorAction Stop
		}
	}

	$oCMS = Initialize-CapaSDK -Server $env:COMPUTERNAME -Database 'CapaInstaller' -InstanceManagementPoint 2

	$Users = Get-CapaUsers -CapaSDK $oCMS
	if ($null -eq $Users -or $Users.Count -eq 0) {
		throw 'No users found. Cannot run Get-CapaUserInventory integration test.'
	}

	$script:TargetUser = $Users | Select-Object -First 1
}

Describe 'Get-CapaUserInventory' {
	It 'Returns user inventory for an existing user' {
		$Result = Get-CapaUserInventory -CapaSDK $oCMS -UserName $script:TargetUser.Name
		$Result | Should -Not -Be $null
	}

	It 'Throws when UserName is empty' {
		{ Get-CapaUserInventory -CapaSDK $oCMS -UserName '' } | Should -Throw
	}
}
