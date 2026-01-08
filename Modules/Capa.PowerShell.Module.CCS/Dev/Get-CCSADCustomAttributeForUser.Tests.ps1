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

Describe 'Get-CCSADCustomAttributeForUser' -Tag 'Unit' {

	Context 'Parameter Validation' {

		It 'Should have mandatory UserName parameter' {
			(Get-Command Get-CCSADCustomAttributeForUser).Parameters['UserName'].Attributes.Mandatory | Should -Be $true
		}

		It 'Should have mandatory Attribute parameter' {
			(Get-Command Get-CCSADCustomAttributeForUser).Parameters['Attribute'].Attributes.Mandatory | Should -Be $true
		}

		It 'Should have mandatory Domain parameter' {
			(Get-Command Get-CCSADCustomAttributeForUser).Parameters['Domain'].Attributes.Mandatory | Should -Be $true
		}

		It 'Should have mandatory Url parameter' {
			(Get-Command Get-CCSADCustomAttributeForUser).Parameters['Url'].Attributes.Mandatory | Should -Be $true
		}

		It 'Should have mandatory CCSCredential parameter' {
			(Get-Command Get-CCSADCustomAttributeForUser).Parameters['CCSCredential'].Attributes.Mandatory | Should -Be $true
		}

		It 'Should have optional DomainCredential parameter' {
			(Get-Command Get-CCSADCustomAttributeForUser).Parameters['DomainCredential'].Attributes.Mandatory | Should -Be $false
		}

		It 'Should have optional DomainOUPath parameter' {
			(Get-Command Get-CCSADCustomAttributeForUser).Parameters['DomainOUPath'].Attributes.Mandatory | Should -Be $false
		}

		It 'Should accept array of usernames' {
			(Get-Command Get-CCSADCustomAttributeForUser).Parameters['UserName'].ParameterType.Name | Should -Be 'String[]'
		}

		It 'Should accept pipeline input for UserName' {
			(Get-Command Get-CCSADCustomAttributeForUser).Parameters['UserName'].Attributes.ValueFromPipeline | Should -Be $true
		}
	}

	Context 'Parameter Aliases' {

		It 'Should have alias "User" for UserName' {
			(Get-Command Get-CCSADCustomAttributeForUser).Parameters['UserName'].Aliases | Should -Contain 'User'
		}

		It 'Should have alias "SamAccountName" for UserName' {
			(Get-Command Get-CCSADCustomAttributeForUser).Parameters['UserName'].Aliases | Should -Contain 'SamAccountName'
		}

		It 'Should have alias "AttributeName" for Attribute' {
			(Get-Command Get-CCSADCustomAttributeForUser).Parameters['Attribute'].Aliases | Should -Contain 'AttributeName'
		}

		It 'Should have alias "OU" for DomainOUPath' {
			(Get-Command Get-CCSADCustomAttributeForUser).Parameters['DomainOUPath'].Aliases | Should -Contain 'OU'
		}

		It 'Should have alias "SearchBase" for DomainOUPath' {
			(Get-Command Get-CCSADCustomAttributeForUser).Parameters['DomainOUPath'].Aliases | Should -Contain 'SearchBase'
		}
	}

	Context 'CmdletBinding Attributes' {

		It 'Should be an advanced function' {
			(Get-Command Get-CCSADCustomAttributeForUser).CmdletBinding | Should -Be $true
		}

		It 'Should have OutputType defined' {
			(Get-Command Get-CCSADCustomAttributeForUser).OutputType.Name | Should -Contain 'System.String'
		}
	}
}

Describe 'Get-CCSADCustomAttributeForUser - Integration Tests' -Tag 'Integration' {

	Context 'DomainOUPath Validation' {

		It 'Should accept empty DomainOUPath' {
			{ Get-CCSADCustomAttributeForUser -UserName $env:USERNAME -Attribute 'department' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath '' -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should accept standard DN format' {
			{ Get-CCSADCustomAttributeForUser -UserName $env:USERNAME -Attribute 'department' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'OU=Users,DC=Firmax,DC=local' -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should accept DC-only format' {
			{ Get-CCSADCustomAttributeForUser -UserName $env:USERNAME -Attribute 'department' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'DC=Firmax,DC=local' -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should accept LDAP format' {
			{ Get-CCSADCustomAttributeForUser -UserName $env:USERNAME -Attribute 'department' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'LDAP://DC01.Firmax.local/OU=Users,DC=Firmax,DC=local' -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should reject invalid format' {
			{ Get-CCSADCustomAttributeForUser -UserName $env:USERNAME -Attribute 'department' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'InvalidPath' } | Should -Throw
		}
	}

	Context 'URL Validation' {

		It 'Should accept HTTPS URL' {
			{ Get-CCSADCustomAttributeForUser -UserName $env:USERNAME -Attribute 'department' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should reject HTTP URL (only HTTPS allowed)' {
			$httpUrl = $script:TestUrl -replace '^https:', 'http:'
			{ Get-CCSADCustomAttributeForUser -UserName $env:USERNAME -Attribute 'department' -Domain $script:TestDomain -Url $httpUrl -CCSCredential $script:TestCCSCredential } | Should -Throw
		}

		It 'Should reject URL without protocol' {
			{ Get-CCSADCustomAttributeForUser -UserName $env:USERNAME -Attribute 'department' -Domain $script:TestDomain -Url 'test.com/CCS.asmx' -CCSCredential $script:TestCCSCredential } | Should -Throw
		}
	}

	Context 'Domain Validation' {

		It 'Should accept valid domain format' {
			{ Get-CCSADCustomAttributeForUser -UserName $env:USERNAME -Attribute 'department' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should accept subdomain format' {
			{ Get-CCSADCustomAttributeForUser -UserName $env:USERNAME -Attribute 'department' -Domain 'sub.firmax.local' -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should reject invalid domain format' {
			{ Get-CCSADCustomAttributeForUser -UserName $env:USERNAME -Attribute 'department' -Domain 'invalid_domain' -Url $script:TestUrl -CCSCredential $script:TestCCSCredential } | Should -Throw
		}
	}

	Context 'Live CCS Web Service Operations' {

		It 'Should connect to CCS Web Service successfully' {
			{ Get-CCSADCustomAttributeForUser -UserName $env:USERNAME -Attribute 'department' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should retrieve attribute for current user' {
			$result = Get-CCSADCustomAttributeForUser -UserName $env:USERNAME -Attribute 'sAMAccountName' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
			$result | Should -Not -BeNullOrEmpty
		}

		It 'Should retrieve attribute with domain credentials' {
			$result = Get-CCSADCustomAttributeForUser -UserName $env:USERNAME -Attribute 'sAMAccountName' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
			$result | Should -Not -BeNullOrEmpty
		}

		It 'Should process multiple users via pipeline' {
			$users = @($env:USERNAME)
			$results = $users | Get-CCSADCustomAttributeForUser -Attribute 'name' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
			$results | Should -Not -BeNullOrEmpty
			$results.Count | Should -Be $users.Count
		}

		It 'Should handle LDAP format DomainOUPath' {
			$ldapPath = 'LDAP://DC01.Firmax.local/OU=Users,DC=Firmax,DC=local'
			{ Get-CCSADCustomAttributeForUser -UserName $env:USERNAME -Attribute 'department' -DomainOUPath $ldapPath -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}
	}

	Context 'Error Handling' {

		It 'Should handle non-existent user gracefully' {
			$result = Get-CCSADCustomAttributeForUser -UserName 'NonExistentUser999' -Attribute 'department' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
			$result | Should -BeNullOrEmpty
		}

		It 'Should handle invalid credentials gracefully' {
			$badCred = New-Object System.Management.Automation.PSCredential('baduser', (ConvertTo-SecureString 'badpass' -AsPlainText -Force))
			{ Get-CCSADCustomAttributeForUser -UserName $env:USERNAME -Attribute 'department' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $badCred -ErrorAction Stop } | Should -Throw
		}
	}
}

Describe 'Get-CCSADCustomAttributeForUser - Performance Tests' -Tag 'Performance' {

	Context 'Pipeline Performance' {

		It 'Should process pipeline input efficiently' {
			$users = @($env:USERNAME, $env:USERNAME, $env:USERNAME)
			$measure = Measure-Command {
				$results = $users | Get-CCSADCustomAttributeForUser -Attribute 'department' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
			}
			$measure.TotalSeconds | Should -BeLessThan 10
		}
	}
}
