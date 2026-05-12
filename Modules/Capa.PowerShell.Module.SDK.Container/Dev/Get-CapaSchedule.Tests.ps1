BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')
	$RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

	$Folders = @(
		'Capa.PowerShell.Module.SDK.Authentication'
	)
	foreach ($Folder in $Folders) {
		$Items = Get-ChildItem -Path "$RootPath\$Folder\Dev\" -Filter '*.ps1' | Where-Object { $_.Name -notlike '*Tests.ps1' }
		foreach ($Item in $Items) {
			Import-Module $Item.FullName -Force -ErrorAction Stop
		}
	}

	$oCMS = Initialize-CapaSDK -Server $env:COMPUTERNAME -Database 'CapaInstaller' -InstanceManagementPoint 2
}

Describe 'Get-CapaSchedule' {
	It 'Returns schedule objects when given a valid Id' {
		$Result = Get-CapaSchedule -CapaSDK $oCMS -Id '1'
		$Result | Should -Not -BeNullOrEmpty
	}

	It 'Throws when Id is empty' {
		{ Get-CapaSchedule -CapaSDK $oCMS -Id '' } | Should -Throw
	}
}
