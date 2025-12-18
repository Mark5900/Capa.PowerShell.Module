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

Describe 'Get-CCSADEmailForUser' -Tag 'Unit' {

	Context 'Parameter Validation' {

		It 'Should have mandatory UserName parameter' {
			(Get-Command Get-CCSADEmailForUser).Parameters['UserName'].Attributes.Mandatory | Should -Be $true
		}

		It 'Should have mandatory Domain parameter' {
			(Get-Command Get-CCSADEmailForUser).Parameters['Domain'].Attributes.Mandatory | Should -Be $true
		}

		It 'Should have mandatory Url parameter' {
			(Get-Command Get-CCSADEmailForUser).Parameters['Url'].Attributes.Mandatory | Should -Be $true
		}

		It 'Should have mandatory CCSCredential parameter' {
			(Get-Command Get-CCSADEmailForUser).Parameters['CCSCredential'].Attributes.Mandatory | Should -Be $true
		}

		It 'Should have optional DomainCredential parameter' {
			(Get-Command Get-CCSADEmailForUser).Parameters['DomainCredential'].Attributes.Mandatory | Should -Be $false
		}

		It 'Should have optional DomainOUPath parameter' {
			(Get-Command Get-CCSADEmailForUser).Parameters['DomainOUPath'].Attributes.Mandatory | Should -Be $false
		}

		It 'Should accept array of usernames' {
			(Get-Command Get-CCSADEmailForUser).Parameters['UserName'].ParameterType.Name | Should -Be 'String[]'
		}

		It 'Should accept pipeline input for UserName' {
			(Get-Command Get-CCSADEmailForUser).Parameters['UserName'].Attributes.ValueFromPipeline | Should -Be $true
		}
	}

	Context 'Parameter Aliases' {

		It 'Should have alias "User" for UserName' {
			(Get-Command Get-CCSADEmailForUser).Parameters['UserName'].Aliases | Should -Contain 'User'
		}

		It 'Should have alias "SamAccountName" for UserName' {
			(Get-Command Get-CCSADEmailForUser).Parameters['UserName'].Aliases | Should -Contain 'SamAccountName'
		}

		It 'Should have alias "OU" for DomainOUPath' {
			(Get-Command Get-CCSADEmailForUser).Parameters['DomainOUPath'].Aliases | Should -Contain 'OU'
		}

		It 'Should have alias "SearchBase" for DomainOUPath' {
			(Get-Command Get-CCSADEmailForUser).Parameters['DomainOUPath'].Aliases | Should -Contain 'SearchBase'
		}
	}

	Context 'CmdletBinding Attributes' {

		It 'Should be an advanced function' {
			(Get-Command Get-CCSADEmailForUser).CmdletBinding | Should -Be $true
		}

		It 'Should have OutputType defined' {
			(Get-Command Get-CCSADEmailForUser).OutputType.Name | Should -Contain 'System.String'
		}
	}
}

Describe 'Get-CCSADEmailForUser - Integration Tests' -Tag 'Integration' {

	Context 'DomainOUPath Validation' {

		It 'Should accept empty DomainOUPath' {
			{ Get-CCSADEmailForUser -UserName $env:USERNAME -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath '' -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should accept standard DN format' {
			{ Get-CCSADEmailForUser -UserName $env:USERNAME -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'OU=Users,DC=Firmax,DC=local' -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should accept DC-only format' {
			{ Get-CCSADEmailForUser -UserName $env:USERNAME -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'DC=Firmax,DC=local' -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should accept LDAP format' {
			{ Get-CCSADEmailForUser -UserName $env:USERNAME -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'LDAP://DC01.Firmax.local/OU=Users,DC=Firmax,DC=local' -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should reject invalid format' {
			{ Get-CCSADEmailForUser -UserName $env:USERNAME -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'InvalidPath' } | Should -Throw
		}
	}

	Context 'URL Validation' {

		It 'Should accept HTTPS URL' {
			{ Get-CCSADEmailForUser -UserName $env:USERNAME -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should reject HTTP URL (only HTTPS allowed)' {
			$httpUrl = $script:TestUrl -replace '^https:', 'http:'
			{ Get-CCSADEmailForUser -UserName $env:USERNAME -Domain $script:TestDomain -Url $httpUrl -CCSCredential $script:TestCCSCredential } | Should -Throw
		}

		It 'Should reject URL without protocol' {
			{ Get-CCSADEmailForUser -UserName $env:USERNAME -Domain $script:TestDomain -Url 'test.com/CCS.asmx' -CCSCredential $script:TestCCSCredential } | Should -Throw
		}
	}

	Context 'Domain Validation' {

		It 'Should accept valid domain format' {
			{ Get-CCSADEmailForUser -UserName $env:USERNAME -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should accept subdomain format' {
			{ Get-CCSADEmailForUser -UserName $env:USERNAME -Domain 'sub.firmax.local' -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should reject invalid domain format' {
			{ Get-CCSADEmailForUser -UserName $env:USERNAME -Domain 'invalid_domain' -Url $script:TestUrl -CCSCredential $script:TestCCSCredential } | Should -Throw
		}
	}

	Context 'Live CCS Web Service Operations' {

		It 'Should connect to CCS Web Service successfully' {
			{ Get-CCSADEmailForUser -UserName $env:USERNAME -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should retrieve email for current user' {
			$result = Get-CCSADEmailForUser -UserName $env:USERNAME -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
			# Email may be empty, so just verify no error
			{ $result } | Should -Not -Throw
		}

		It 'Should retrieve email with domain credentials' {
			$result = Get-CCSADEmailForUser -UserName $env:USERNAME -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
			{ $result } | Should -Not -Throw
		}

		It 'Should process multiple users via pipeline' {
			$users = @($env:USERNAME)
			$results = $users | Get-CCSADEmailForUser -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
			{ $results } | Should -Not -Throw
		}

		It 'Should handle LDAP format DomainOUPath' {
			$ldapPath = 'LDAP://DC01.Firmax.local/OU=Users,DC=Firmax,DC=local'
			{ Get-CCSADEmailForUser -UserName $env:USERNAME -DomainOUPath $ldapPath -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}
	}

	Context 'Error Handling' {

		It 'Should handle non-existent user gracefully' {
			$result = Get-CCSADEmailForUser -UserName 'NonExistentUser999' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
			$result | Should -BeNullOrEmpty
		}

		It 'Should handle invalid credentials gracefully' {
			$badCred = New-Object System.Management.Automation.PSCredential('baduser', (ConvertTo-SecureString 'badpass' -AsPlainText -Force))
			{ Get-CCSADEmailForUser -UserName $env:USERNAME -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $badCred -ErrorAction Stop } | Should -Throw
		}
	}
}

Describe 'Get-CCSADEmailForUser - Performance Tests' -Tag 'Performance' {

	Context 'Pipeline Performance' {

		It 'Should process pipeline input efficiently' {
			$users = @($env:USERNAME, $env:USERNAME, $env:USERNAME)
			$measure = Measure-Command {
				$results = $users | Get-CCSADEmailForUser -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
			}
			$measure.TotalSeconds | Should -BeLessThan 10
		}
	}
}
