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

	$script:GroupName = "TestGroupPrinters_$([DateTime]::Now.ToString('yyyyMMddHHmmss'))"
	$script:CreatedGroup = $false
	try {
		Create-CapaGroup -CapaSDK $oCMS -GroupName $script:GroupName -GroupType Static -UnitType Computer -Confirm:$false | Out-Null
		$script:CreatedGroup = $true
	} catch {
		$script:CreatedGroup = $false
	}
}

Describe 'Get-CapaGroupPrinters' {
	It 'Returns an array (possibly empty) of printers for a group' {
		if (-not $script:CreatedGroup) {
			Set-ItResult -Skipped -Because 'Insufficient rights to create groups in this environment.'
			return
		}

		$Result = Get-CapaGroupPrinters -CapaSDK $oCMS -GroupName $script:GroupName -GroupType Static
		$Result | Should -Not -Be $null
	}

	It 'Throws when GroupName is empty' {
		{ Get-CapaGroupPrinters -CapaSDK $oCMS -GroupName '' -GroupType Static } | Should -Throw
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
