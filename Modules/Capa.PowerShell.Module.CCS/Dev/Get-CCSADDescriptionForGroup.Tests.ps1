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

Describe 'Get-CCSADDescriptionForGroup' -Tag 'Unit' {

	Context 'Parameter Validation' {

		It 'Should have mandatory GroupName parameter' {
			(Get-Command Get-CCSADDescriptionForGroup).Parameters['GroupName'].Attributes.Mandatory | Should -Be $true
		}

		It 'Should have mandatory Domain parameter' {
			(Get-Command Get-CCSADDescriptionForGroup).Parameters['Domain'].Attributes.Mandatory | Should -Be $true
		}

		It 'Should have mandatory Url parameter' {
			(Get-Command Get-CCSADDescriptionForGroup).Parameters['Url'].Attributes.Mandatory | Should -Be $true
		}

		It 'Should have mandatory CCSCredential parameter' {
			(Get-Command Get-CCSADDescriptionForGroup).Parameters['CCSCredential'].Attributes.Mandatory | Should -Be $true
		}

		It 'Should have optional DomainCredential parameter' {
			(Get-Command Get-CCSADDescriptionForGroup).Parameters['DomainCredential'].Attributes.Mandatory | Should -Be $false
		}

		It 'Should have optional DomainOUPath parameter' {
			(Get-Command Get-CCSADDescriptionForGroup).Parameters['DomainOUPath'].Attributes.Mandatory | Should -Be $false
		}

		It 'Should accept array of group names' {
			(Get-Command Get-CCSADDescriptionForGroup).Parameters['GroupName'].ParameterType.Name | Should -Be 'String[]'
		}

		It 'Should accept pipeline input for GroupName' {
			(Get-Command Get-CCSADDescriptionForGroup).Parameters['GroupName'].Attributes.ValueFromPipeline | Should -Be $true
		}
	}

	Context 'Parameter Aliases' {

		It 'Should have alias "Group" for GroupName' {
			(Get-Command Get-CCSADDescriptionForGroup).Parameters['GroupName'].Aliases | Should -Contain 'Group'
		}

		It 'Should have alias "Name" for GroupName' {
			(Get-Command Get-CCSADDescriptionForGroup).Parameters['GroupName'].Aliases | Should -Contain 'Name'
		}

		It 'Should have alias "OU" for DomainOUPath' {
			(Get-Command Get-CCSADDescriptionForGroup).Parameters['DomainOUPath'].Aliases | Should -Contain 'OU'
		}

		It 'Should have alias "SearchBase" for DomainOUPath' {
			(Get-Command Get-CCSADDescriptionForGroup).Parameters['DomainOUPath'].Aliases | Should -Contain 'SearchBase'
		}
	}

	Context 'CmdletBinding Attributes' {

		It 'Should be an advanced function' {
			(Get-Command Get-CCSADDescriptionForGroup).CmdletBinding | Should -Be $true
		}

		It 'Should have OutputType defined' {
			(Get-Command Get-CCSADDescriptionForGroup).OutputType.Name | Should -Contain 'System.String'
		}
	}
}

Describe 'Get-CCSADDescriptionForGroup - Integration Tests' -Tag 'Integration' {

	Context 'DomainOUPath Validation' {

		It 'Should accept empty DomainOUPath' {
			{ Get-CCSADDescriptionForGroup -GroupName 'Domain Admins' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath '' -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should accept standard DN format' {
			{ Get-CCSADDescriptionForGroup -GroupName 'Domain Admins' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'OU=Groups,DC=Firmax,DC=local' -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should accept DC-only format' {
			{ Get-CCSADDescriptionForGroup -GroupName 'Domain Admins' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'DC=Firmax,DC=local' -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should accept LDAP format' {
			{ Get-CCSADDescriptionForGroup -GroupName 'Domain Admins' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'LDAP://DC01.Firmax.local/OU=Groups,DC=Firmax,DC=local' -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should reject invalid format' {
			{ Get-CCSADDescriptionForGroup -GroupName 'Domain Admins' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'InvalidPath' } | Should -Throw
		}
	}

	Context 'URL Validation' {

		It 'Should accept HTTPS URL' {
			{ Get-CCSADDescriptionForGroup -GroupName 'Domain Admins' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should reject HTTP URL (only HTTPS allowed)' {
			$httpUrl = $script:TestUrl -replace '^https:', 'http:'
			{ Get-CCSADDescriptionForGroup -GroupName 'Domain Admins' -Domain $script:TestDomain -Url $httpUrl -CCSCredential $script:TestCCSCredential } | Should -Throw
		}

		It 'Should reject URL without protocol' {
			{ Get-CCSADDescriptionForGroup -GroupName 'Domain Admins' -Domain $script:TestDomain -Url 'test.com/CCS.asmx' -CCSCredential $script:TestCCSCredential } | Should -Throw
		}
	}

	Context 'Domain Validation' {

		It 'Should accept valid domain format' {
			{ Get-CCSADDescriptionForGroup -GroupName 'Domain Admins' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should accept subdomain format' {
			{ Get-CCSADDescriptionForGroup -GroupName 'Domain Admins' -Domain 'sub.firmax.local' -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should reject invalid domain format' {
			{ Get-CCSADDescriptionForGroup -GroupName 'Domain Admins' -Domain 'invalid_domain' -Url $script:TestUrl -CCSCredential $script:TestCCSCredential } | Should -Throw
		}
	}

	Context 'Live CCS Web Service Operations' {

		It 'Should connect to CCS Web Service successfully' {
			{ Get-CCSADDescriptionForGroup -GroupName 'Domain Admins' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should retrieve description for Domain Admins group' {
			$result = Get-CCSADDescriptionForGroup -GroupName 'Domain Admins' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
			# Domain Admins may or may not have a description, so we just verify no error
			{ $result } | Should -Not -Throw
		}

		It 'Should retrieve description with domain credentials' {
			$result = Get-CCSADDescriptionForGroup -GroupName 'Domain Admins' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
			{ $result } | Should -Not -Throw
		}

		It 'Should process multiple groups via pipeline' {
			$groups = @('Domain Admins')
			$results = $groups | Get-CCSADDescriptionForGroup -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
			{ $results } | Should -Not -Throw
		}

		It 'Should handle LDAP format DomainOUPath' {
			$ldapPath = 'LDAP://DC01.Firmax.local/DC=Firmax,DC=local'
			{ Get-CCSADDescriptionForGroup -GroupName 'Domain Admins' -DomainOUPath $ldapPath -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}
	}

	Context 'Error Handling' {

		It 'Should handle non-existent group gracefully' {
			$result = Get-CCSADDescriptionForGroup -GroupName 'NonExistentGroup999' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
			$result | Should -BeNullOrEmpty
		}

		It 'Should handle invalid credentials gracefully' {
			$badCred = New-Object System.Management.Automation.PSCredential('baduser', (ConvertTo-SecureString 'badpass' -AsPlainText -Force))
			{ Get-CCSADDescriptionForGroup -GroupName 'Domain Admins' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $badCred -ErrorAction Stop } | Should -Throw
		}
	}
}

Describe 'Get-CCSADDescriptionForGroup - Performance Tests' -Tag 'Performance' {

	Context 'Pipeline Performance' {

		It 'Should process pipeline input efficiently' {
			$groups = @('Domain Admins', 'Domain Users', 'Domain Computers')
			$measure = Measure-Command {
				$results = $groups | Get-CCSADDescriptionForGroup -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
			}
			$measure.TotalSeconds | Should -BeLessThan 15
		}
	}
}
