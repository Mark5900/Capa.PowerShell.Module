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

	$script:GroupName = "TestSetGroupFolder_$([DateTime]::Now.ToString('yyyyMMddHHmmss'))"
	$script:CreatedGroup = $false
	try {
		Create-CapaGroup -CapaSDK $oCMS -GroupName $script:GroupName -GroupType Static -UnitType Computer -Confirm:$false | Out-Null
		$script:CreatedGroup = $true
	} catch {
		$script:CreatedGroup = $false
	}
}

Describe 'Set-CapaGroupFolder' {
	It 'Sets the folder structure on a group' {
		if (-not $script:CreatedGroup) {
			Set-ItResult -Skipped -Because 'Insufficient rights to create groups in this environment.'
			return
		}

		$Result = Set-CapaGroupFolder -CapaSDK $oCMS -GroupName $script:GroupName -GroupType Static -FolderStructure 'TestFolder' -Confirm:$false
		$Result | Should -Not -BeNullOrEmpty
	}

	It 'Throws when GroupName is empty' {
		{ Set-CapaGroupFolder -CapaSDK $oCMS -GroupName '' -GroupType Static -FolderStructure 'TestFolder' -Confirm:$false } | Should -Throw
	}

	It 'Throws when FolderStructure is empty' {
		{ Set-CapaGroupFolder -CapaSDK $oCMS -GroupName $script:GroupName -GroupType Static -FolderStructure '' -Confirm:$false } | Should -Throw
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
