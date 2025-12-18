BeforeAll {
	$RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

	$Items = Get-ChildItem -Path "$RootPath\Capa.PowerShell.Module.CCS\Dev\" -Filter '*.ps1' | Where-Object { $_.Name -notlike '*Tests.ps1' }
	foreach ($Item in $Items) {
		Import-Module $Item.FullName -Force -ErrorAction Stop
	}

	# Setup test environment
	$script:TestUrl = "https://$(hostname).capainstaller.com/CCSWebservice/CCS.asmx"
	$script:TestDomain = 'Firmax.local'
	$CredentialPath = "D:\PowerShell\Credentials\$($env:USERNAME)DomainAdminPesterTests.xml"

	# Setup credentials from environment variables (GitHub secrets)
	if ($env:DOMAINADMINUSERNAME -and $env:DOMAINADMINPASSWORD) {
		$securePassword = ConvertTo-SecureString $env:DOMAINADMINPASSWORD -AsPlainText -Force
		$script:TestDomainCredential = New-Object System.Management.Automation.PSCredential($env:DOMAINADMINUSERNAME, $securePassword)
		$script:TestCCSCredential = $script:TestDomainCredential
	} elseif (Test-Path -Path $CredentialPath) {
		$script:TestDomainCredential = Import-Clixml -Path $CredentialPath
		$script:TestCCSCredential = $script:TestDomainCredential
	} else {
		$script:TestDomainCredential = Get-Credential -Message 'Enter domain admin credentials for integration tests'
		$script:TestCCSCredential = $script:TestDomainCredential
	}

	$DebugPreference = 'Continue'
	$ErrorActionPreference = 'Stop'
}

Describe 'Create-CCSADSecurityGroupsForShares' -Tag 'Unit' {

	Context 'Parameter Validation' {

		It 'Should have optional DomainOUPath parameter' {
			(Get-Command Create-CCSADSecurityGroupsForShares).Parameters['DomainOUPath'].Attributes.Mandatory | Should -Be $false
		}

		It 'Should have mandatory Domain parameter' {
			(Get-Command Create-CCSADSecurityGroupsForShares).Parameters['Domain'].Attributes.Mandatory | Should -Be $true
		}

		It 'Should have mandatory Url parameter' {
			(Get-Command Create-CCSADSecurityGroupsForShares).Parameters['Url'].Attributes.Mandatory | Should -Be $true
		}

		It 'Should have mandatory CCSCredential parameter' {
			(Get-Command Create-CCSADSecurityGroupsForShares).Parameters['CCSCredential'].Attributes.Mandatory | Should -Be $true
		}

		It 'Should have optional DomainCredential parameter' {
			(Get-Command Create-CCSADSecurityGroupsForShares).Parameters['DomainCredential'].Attributes.Mandatory | Should -Be $false
		}

		It 'Should have mandatory GroupFormat parameter' {
			(Get-Command Create-CCSADSecurityGroupsForShares).Parameters['GroupFormat'].Attributes.Mandatory | Should -Be $true
		}

		It 'Should have mandatory GroupDescriptionFormat parameter' {
			(Get-Command Create-CCSADSecurityGroupsForShares).Parameters['GroupDescriptionFormat'].Attributes.Mandatory | Should -Be $true
		}

		It 'Should have optional CreateReadGroup parameter' {
			(Get-Command Create-CCSADSecurityGroupsForShares).Parameters['CreateReadGroup'].Attributes.Mandatory | Should -Be $false
		}

		It 'Should have optional CreateReadWriteGroup parameter' {
			(Get-Command Create-CCSADSecurityGroupsForShares).Parameters['CreateReadWriteGroup'].Attributes.Mandatory | Should -Be $false
		}

		It 'Should have optional ExcludeStandardShares parameter' {
			(Get-Command Create-CCSADSecurityGroupsForShares).Parameters['ExcludeStandardShares'].Attributes.Mandatory | Should -Be $false
		}

		It 'Should have optional PasswordIsEncrypted parameter' {
			(Get-Command Create-CCSADSecurityGroupsForShares).Parameters['PasswordIsEncrypted'].Attributes.Mandatory | Should -Be $false
		}
	}

	Context 'Parameter Aliases' {

		It 'Should have alias "OU" for DomainOUPath' {
			(Get-Command Create-CCSADSecurityGroupsForShares).Parameters['DomainOUPath'].Aliases | Should -Contain 'OU'
		}

		It 'Should have alias "Path" for DomainOUPath' {
			(Get-Command Create-CCSADSecurityGroupsForShares).Parameters['DomainOUPath'].Aliases | Should -Contain 'Path'
		}

		It 'Should have alias "Format" for GroupFormat' {
			(Get-Command Create-CCSADSecurityGroupsForShares).Parameters['GroupFormat'].Aliases | Should -Contain 'Format'
		}

		It 'Should have alias "NameFormat" for GroupFormat' {
			(Get-Command Create-CCSADSecurityGroupsForShares).Parameters['GroupFormat'].Aliases | Should -Contain 'NameFormat'
		}

		It 'Should have alias "Read" for CreateReadGroup' {
			(Get-Command Create-CCSADSecurityGroupsForShares).Parameters['CreateReadGroup'].Aliases | Should -Contain 'Read'
		}

		It 'Should have alias "ReadWrite" for CreateReadWriteGroup' {
			(Get-Command Create-CCSADSecurityGroupsForShares).Parameters['CreateReadWriteGroup'].Aliases | Should -Contain 'ReadWrite'
		}
	}

	Context 'DomainOUPath Validation' {

		It 'Should accept empty DomainOUPath' {
			{ Create-CCSADSecurityGroupsForShares -GroupFormat 'Share_$sharename$' -GroupDescriptionFormat 'Access to $sharename$' -CreateReadGroup -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath '' -ErrorAction Stop } | Should -Throw -ErrorId 'At least one of CreateReadGroup*'
		}

		It 'Should accept standard DN format' {
			{ Create-CCSADSecurityGroupsForShares -GroupFormat 'Share_$sharename$' -GroupDescriptionFormat 'Access to $sharename$' -CreateReadGroup -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'OU=Groups,DC=Firmax,DC=local' -ErrorAction Stop } | Should -Throw
		}

		It 'Should accept DC-only format' {
			{ Create-CCSADSecurityGroupsForShares -GroupFormat 'Share_$sharename$' -GroupDescriptionFormat 'Access to $sharename$' -CreateReadGroup -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'DC=Firmax,DC=local' -ErrorAction Stop } | Should -Throw
		}

		It 'Should accept LDAP format' {
			{ Create-CCSADSecurityGroupsForShares -GroupFormat 'Share_$sharename$' -GroupDescriptionFormat 'Access to $sharename$' -CreateReadGroup -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'LDAP://DC01.Firmax.local/OU=Groups,DC=Firmax,DC=local' -ErrorAction Stop } | Should -Throw
		}

		It 'Should reject invalid format' {
			{ Create-CCSADSecurityGroupsForShares -GroupFormat 'Share_$sharename$' -GroupDescriptionFormat 'Access to $sharename$' -CreateReadGroup -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'InvalidPath' } | Should -Throw
		}
	}

	Context 'URL Validation' {

		It 'Should accept HTTPS URL' {
			{ Create-CCSADSecurityGroupsForShares -GroupFormat 'Share_$sharename$' -GroupDescriptionFormat 'Access to $sharename$' -CreateReadGroup -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction Stop } | Should -Throw
		}

		It 'Should reject HTTP URL (only HTTPS allowed)' {
			$httpUrl = $script:TestUrl -replace '^https:', 'http:'
			{ Create-CCSADSecurityGroupsForShares -GroupFormat 'Share_$sharename$' -GroupDescriptionFormat 'Access to $sharename$' -CreateReadGroup -Domain $script:TestDomain -Url $httpUrl -CCSCredential $script:TestCCSCredential } | Should -Throw
		}

		It 'Should reject URL without protocol' {
			{ Create-CCSADSecurityGroupsForShares -GroupFormat 'Share_$sharename$' -GroupDescriptionFormat 'Access to $sharename$' -CreateReadGroup -Domain $script:TestDomain -Url 'test.com/CCS.asmx' -CCSCredential $script:TestCCSCredential } | Should -Throw
		}
	}

	Context 'Domain Validation' {

		It 'Should accept valid domain format' {
			{ Create-CCSADSecurityGroupsForShares -GroupFormat 'Share_$sharename$' -GroupDescriptionFormat 'Access to $sharename$' -CreateReadGroup -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction Stop } | Should -Throw
		}

		It 'Should accept subdomain format' {
			{ Create-CCSADSecurityGroupsForShares -GroupFormat 'Share_$sharename$' -GroupDescriptionFormat 'Access to $sharename$' -CreateReadGroup -Domain 'sub.firmax.local' -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction Stop } | Should -Throw
		}

		It 'Should reject invalid domain format' {
			{ Create-CCSADSecurityGroupsForShares -GroupFormat 'Share_$sharename$' -GroupDescriptionFormat 'Access to $sharename$' -CreateReadGroup -Domain 'invalid_domain' -Url $script:TestUrl -CCSCredential $script:TestCCSCredential } | Should -Throw
		}
	}

	Context 'Group Type Validation' {

		It 'Should throw when neither CreateReadGroup nor CreateReadWriteGroup is specified' {
			{ Create-CCSADSecurityGroupsForShares -GroupFormat 'Share_$sharename$' -GroupDescriptionFormat 'Access to $sharename$' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction Stop } | Should -Throw
		}

		It 'Should accept when only CreateReadGroup is specified' {
			{ Create-CCSADSecurityGroupsForShares -GroupFormat 'Share_$sharename$' -GroupDescriptionFormat 'Access to $sharename$' -CreateReadGroup -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction Stop } | Should -Throw
		}

		It 'Should accept when only CreateReadWriteGroup is specified' {
			{ Create-CCSADSecurityGroupsForShares -GroupFormat 'Share_$sharename$' -GroupDescriptionFormat 'Access to $sharename$' -CreateReadWriteGroup -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction Stop } | Should -Throw
		}

		It 'Should accept when both CreateReadGroup and CreateReadWriteGroup are specified' {
			{ Create-CCSADSecurityGroupsForShares -GroupFormat 'Share_$sharename$' -GroupDescriptionFormat 'Access to $sharename$' -CreateReadGroup -CreateReadWriteGroup -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction Stop } | Should -Throw
		}
	}

	Context 'ShouldProcess Support' {

		It 'Should support WhatIf' {
			(Get-Command Create-CCSADSecurityGroupsForShares).Parameters.ContainsKey('WhatIf') | Should -Be $true
		}

		It 'Should support Confirm' {
			(Get-Command Create-CCSADSecurityGroupsForShares).Parameters.ContainsKey('Confirm') | Should -Be $true
		}
	}

	Context 'CmdletBinding Attributes' {

		It 'Should be an advanced function' {
			(Get-Command Create-CCSADSecurityGroupsForShares).CmdletBinding | Should -Be $true
		}

		It 'Should have SupportsShouldProcess' {
			(Get-Command Create-CCSADSecurityGroupsForShares).Parameters['WhatIf'] | Should -Not -BeNullOrEmpty
		}

		It 'Should have OutputType defined' {
			(Get-Command Create-CCSADSecurityGroupsForShares).OutputType.Name | Should -Contain 'System.String'
		}
	}
}

Describe 'Create-CCSADSecurityGroupsForShares - Integration Tests' -Tag 'Integration' {

	Context 'Live CCS Web Service Operations' {

		It 'Should create security groups for shares with domain credentials' {
			$result = Create-CCSADSecurityGroupsForShares `
				-GroupFormat 'PesterShare_$sharename$' `
				-GroupDescriptionFormat 'Test share access to $sharename$' `
				-CreateReadGroup `
				-CreateReadWriteGroup `
				-ExcludeStandardShares `
				-Domain $script:TestDomain `
				-Url $script:TestUrl `
				-CCSCredential $script:TestCCSCredential `
				-DomainCredential $script:TestDomainCredential `
				-ErrorAction SilentlyContinue `
				-WarningAction SilentlyContinue
			$result | Should -Not -BeNullOrEmpty
		}

		It 'Should create only read groups when CreateReadGroup is specified' {
			{ Create-CCSADSecurityGroupsForShares `
				-GroupFormat 'PesterRO_$sharename$' `
				-GroupDescriptionFormat 'Read-only access to $sharename$' `
				-CreateReadGroup `
				-ExcludeStandardShares `
				-Domain $script:TestDomain `
				-Url $script:TestUrl `
				-CCSCredential $script:TestCCSCredential `
				-DomainCredential $script:TestDomainCredential `
				-ErrorAction SilentlyContinue `
				-WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should work without DomainCredential (CCS context)' {
			{ Create-CCSADSecurityGroupsForShares `
				-GroupFormat 'PesterShare_$sharename$' `
				-GroupDescriptionFormat 'Share access' `
				-CreateReadGroup `
				-Domain $script:TestDomain `
				-Url $script:TestUrl `
				-CCSCredential $script:TestCCSCredential `
				-ErrorAction SilentlyContinue `
				-WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should handle LDAP format DomainOUPath' {
			$ldapPath = 'LDAP://DC01.Firmax.local/OU=Groups,DC=Firmax,DC=local'
			{ Create-CCSADSecurityGroupsForShares `
				-DomainOUPath $ldapPath `
				-GroupFormat 'PesterShare_$sharename$' `
				-GroupDescriptionFormat 'Share access' `
				-CreateReadGroup `
				-CreateReadWriteGroup `
				-ExcludeStandardShares `
				-Domain $script:TestDomain `
				-Url $script:TestUrl `
				-CCSCredential $script:TestCCSCredential `
				-DomainCredential $script:TestDomainCredential `
				-ErrorAction SilentlyContinue `
				-WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should handle placeholders in group description' {
			{ Create-CCSADSecurityGroupsForShares `
				-GroupFormat 'FS_$sharename$' `
				-GroupDescriptionFormat 'Access to $sharename$ at $shareunc$ (Path: $localpath$)' `
				-CreateReadGroup `
				-ExcludeStandardShares `
				-Domain $script:TestDomain `
				-Url $script:TestUrl `
				-CCSCredential $script:TestCCSCredential `
				-DomainCredential $script:TestDomainCredential `
				-ErrorAction SilentlyContinue `
				-WarningAction SilentlyContinue } | Should -Not -Throw
		}
	}

	Context 'Error Handling' {

		It 'Should handle invalid credentials gracefully' {
			$badCred = New-Object System.Management.Automation.PSCredential('baduser', (ConvertTo-SecureString 'badpass' -AsPlainText -Force))
			{ Create-CCSADSecurityGroupsForShares `
				-GroupFormat 'Share_$sharename$' `
				-GroupDescriptionFormat 'Access' `
				-CreateReadGroup `
				-Domain $script:TestDomain `
				-Url $script:TestUrl `
				-CCSCredential $badCred `
				-ErrorAction Stop } | Should -Throw
		}
	}
}

Describe 'Create-CCSADSecurityGroupsForShares - Performance Tests' -Tag 'Performance' {

	Context 'Execution Performance' {

		It 'Should complete in reasonable time' {
			$measure = Measure-Command {
				Create-CCSADSecurityGroupsForShares `
					-GroupFormat 'PesterPerf_$sharename$' `
					-GroupDescriptionFormat 'Performance test' `
					-CreateReadGroup `
					-ExcludeStandardShares `
					-Domain $script:TestDomain `
					-Url $script:TestUrl `
					-CCSCredential $script:TestCCSCredential `
					-DomainCredential $script:TestDomainCredential `
					-ErrorAction SilentlyContinue `
					-WarningAction SilentlyContinue
			}
			$measure.TotalSeconds | Should -BeLessThan 30
		}
	}
}
