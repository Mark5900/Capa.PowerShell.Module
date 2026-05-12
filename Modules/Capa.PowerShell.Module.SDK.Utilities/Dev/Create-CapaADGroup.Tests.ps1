BeforeAll {
	$RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

	$Folders = @(
		'Capa.PowerShell.Module.SDK.Authentication',
		'Capa.PowerShell.Module.SDK.Utilities',
		'Capa.PowerShell.Module.SDK.Group'
	)

	foreach ($Folder in $Folders) {
		$Items = Get-ChildItem -Path "$RootPath\$Folder\Dev\" -Filter '*.ps1' | Where-Object { $_.Name -notlike '*Tests.ps1' }
		foreach ($Item in $Items) {
			Import-Module $Item.FullName -Force -ErrorAction Stop
		}
	}

	$CapaSDK = Initialize-CapaSDK -Server $env:COMPUTERNAME -Database 'CapaInstaller' -InstanceManagementPoint 1

	$DefaultNamingContext = ([ADSI]'LDAP://RootDSE').defaultNamingContext
	$LdapPath = "LDAP://$DefaultNamingContext"

	$TestSettings = @{
		CapaSDK    = $CapaSDK
		GroupName  = "TestADGroup_$([guid]::NewGuid().ToString('N').Substring(0,8))"
		UnitType   = 'Computer'
		LDAPPath   = $LdapPath
		recursive  = 'true'
		GroupType  = 'Dynamic_ADSI'
	}

	$script:GroupWasCreated = $false
}

Describe 'Create-CapaADGroup integration' {
	It 'Creates AD group successfully' {
		try {
			$Status = Create-CapaADGroup -CapaSDK $TestSettings.CapaSDK -GroupName $TestSettings.GroupName -UnitType $TestSettings.UnitType -LDAPPath $TestSettings.LDAPPath -recursive $TestSettings.recursive
			$Status | Should -Be $true
			$script:GroupWasCreated = $true
		}
		catch {
			if ($_.Exception.Message -match 'appropriate Security Level') {
				Set-ItResult -Skipped -Because 'Insufficient rights to create AD groups in current environment.'
				return
			}

			throw
		}
	}

	It 'Can find the created group using Get-CapaGroups' {
		if (-not $script:GroupWasCreated) {
			Set-ItResult -Skipped -Because 'Group was not created in previous test.'
			return
		}

		$Groups = Get-CapaGroups -CapaSDK $TestSettings.CapaSDK -GroupType $TestSettings.GroupType
		$Group = $Groups | Where-Object { $_.Name -eq $TestSettings.GroupName } | Select-Object -First 1

		$Group | Should -Not -BeNullOrEmpty
		$Group.Type | Should -Be $TestSettings.GroupType
		$Group.UnitTypeName | Should -Be $TestSettings.UnitType
	}
}

AfterAll {
	if ($null -ne $TestSettings -and $null -ne $TestSettings.CapaSDK) {
		if (-not $script:GroupWasCreated) {
			return
		}

		$Groups = Get-CapaGroups -CapaSDK $TestSettings.CapaSDK -GroupType $TestSettings.GroupType
		$GroupExists = $Groups | Where-Object { $_.Name -eq $TestSettings.GroupName } | Select-Object -First 1

		if ($GroupExists) {
			Remove-CapaGroup -CapaSDK $TestSettings.CapaSDK -GroupName $TestSettings.GroupName -GroupType $TestSettings.GroupType -UnitType $TestSettings.UnitType | Out-Null
		}
	}
}
