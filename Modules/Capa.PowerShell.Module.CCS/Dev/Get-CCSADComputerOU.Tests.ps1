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

Describe 'Get-CCSADComputerOU' -Tag 'Unit' {

	Context 'Parameter Validation' {

		It 'Should have mandatory ComputerName parameter' {
			(Get-Command Get-CCSADComputerOU).Parameters['ComputerName'].Attributes.Mandatory | Should -Be $true
		}

		It 'Should have mandatory Domain parameter' {
			(Get-Command Get-CCSADComputerOU).Parameters['Domain'].Attributes.Mandatory | Should -Be $true
		}

		It 'Should have mandatory Url parameter' {
			(Get-Command Get-CCSADComputerOU).Parameters['Url'].Attributes.Mandatory | Should -Be $true
		}

		It 'Should have mandatory CCSCredential parameter' {
			(Get-Command Get-CCSADComputerOU).Parameters['CCSCredential'].Attributes.Mandatory | Should -Be $true
		}

		It 'Should have optional DomainCredential parameter' {
			(Get-Command Get-CCSADComputerOU).Parameters['DomainCredential'].Attributes.Mandatory | Should -Be $false
		}

		It 'Should have optional DomainOUPath parameter' {
			(Get-Command Get-CCSADComputerOU).Parameters['DomainOUPath'].Attributes.Mandatory | Should -Be $false
		}

		It 'Should accept array of computer names' {
			(Get-Command Get-CCSADComputerOU).Parameters['ComputerName'].ParameterType.Name | Should -Be 'String[]'
		}

		It 'Should accept pipeline input for ComputerName' {
			(Get-Command Get-CCSADComputerOU).Parameters['ComputerName'].Attributes.ValueFromPipeline | Should -Be $true
		}
	}

	Context 'Parameter Aliases' {

		It 'Should have alias "Name" for ComputerName' {
			(Get-Command Get-CCSADComputerOU).Parameters['ComputerName'].Aliases | Should -Contain 'Name'
		}

		It 'Should have alias "Computer" for ComputerName' {
			(Get-Command Get-CCSADComputerOU).Parameters['ComputerName'].Aliases | Should -Contain 'Computer'
		}

		It 'Should have alias "OU" for DomainOUPath' {
			(Get-Command Get-CCSADComputerOU).Parameters['DomainOUPath'].Aliases | Should -Contain 'OU'
		}

		It 'Should have alias "SearchBase" for DomainOUPath' {
			(Get-Command Get-CCSADComputerOU).Parameters['DomainOUPath'].Aliases | Should -Contain 'SearchBase'
		}
	}

	Context 'CmdletBinding Attributes' {

		It 'Should be an advanced function' {
			(Get-Command Get-CCSADComputerOU).CmdletBinding | Should -Be $true
		}

		It 'Should have OutputType defined' {
			(Get-Command Get-CCSADComputerOU).OutputType.Name | Should -Contain 'System.String'
		}
	}
}

Describe 'Get-CCSADComputerOU - Integration Tests' -Tag 'Integration' {

	Context 'DomainOUPath Validation' {

		It 'Should accept empty DomainOUPath' {
			{ Get-CCSADComputerOU -ComputerName $env:COMPUTERNAME -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath '' -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should accept standard DN format' {
			{ Get-CCSADComputerOU -ComputerName $env:COMPUTERNAME -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'OU=Computers,DC=Firmax,DC=local' -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should accept DC-only format' {
			{ Get-CCSADComputerOU -ComputerName $env:COMPUTERNAME -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'DC=Firmax,DC=local' -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should accept LDAP format' {
			{ Get-CCSADComputerOU -ComputerName $env:COMPUTERNAME -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'LDAP://DC01.Firmax.local/OU=Computers,DC=Firmax,DC=local' -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should reject invalid format' {
			{ Get-CCSADComputerOU -ComputerName $env:COMPUTERNAME -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'InvalidPath' } | Should -Throw
		}
	}

	Context 'URL Validation' {

		It 'Should accept HTTPS URL' {
			{ Get-CCSADComputerOU -ComputerName $env:COMPUTERNAME -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should reject HTTP URL (only HTTPS allowed)' {
			$httpUrl = $script:TestUrl -replace '^https:', 'http:'
			{ Get-CCSADComputerOU -ComputerName $env:COMPUTERNAME -Domain $script:TestDomain -Url $httpUrl -CCSCredential $script:TestCCSCredential } | Should -Throw
		}

		It 'Should reject URL without protocol' {
			{ Get-CCSADComputerOU -ComputerName $env:COMPUTERNAME -Domain $script:TestDomain -Url 'test.com/CCS.asmx' -CCSCredential $script:TestCCSCredential } | Should -Throw
		}
	}

	Context 'Domain Validation' {

		It 'Should accept valid domain format' {
			{ Get-CCSADComputerOU -ComputerName $env:COMPUTERNAME -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should accept subdomain format' {
			{ Get-CCSADComputerOU -ComputerName $env:COMPUTERNAME -Domain 'sub.firmax.local' -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should reject invalid domain format' {
			{ Get-CCSADComputerOU -ComputerName $env:COMPUTERNAME -Domain 'invalid_domain' -Url $script:TestUrl -CCSCredential $script:TestCCSCredential } | Should -Throw
		}
	}

	Context 'Live CCS Web Service Operations' {

		It 'Should connect to CCS Web Service successfully' {
			{ Get-CCSADComputerOU -ComputerName $env:COMPUTERNAME -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should retrieve OU path for local computer' {
			$result = Get-CCSADComputerOU -ComputerName $env:COMPUTERNAME -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
			$result | Should -Not -BeNullOrEmpty
			# Should match either LDAP format or standard DN format
			$result | Should -Match '(^LDAP://.*|(^(OU=.*,)?(DC=.+)(,DC=.+)*$))'
		}

		It 'Should retrieve OU path with domain credentials' {
			$result = Get-CCSADComputerOU -ComputerName $env:COMPUTERNAME -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
			$result | Should -Not -BeNullOrEmpty
		}

		It 'Should process multiple computers via pipeline' {
			$computers = @($env:COMPUTERNAME)
			$results = $computers | Get-CCSADComputerOU -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
			$results | Should -Not -BeNullOrEmpty
			$results.Count | Should -Be $computers.Count
		}

		It 'Should handle LDAP format DomainOUPath' {
			$ldapPath = 'LDAP://DC01.Firmax.local/OU=Computers,DC=Firmax,DC=local'
			{ Get-CCSADComputerOU -ComputerName $env:COMPUTERNAME -DomainOUPath $ldapPath -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}
	}

	Context 'Error Handling' {

		It 'Should handle non-existent computer gracefully' {
			$result = Get-CCSADComputerOU -ComputerName 'NonExistentPC999' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
			$result | Should -BeNullOrEmpty
		}

		It 'Should handle invalid credentials gracefully' {
			$badCred = New-Object System.Management.Automation.PSCredential('baduser', (ConvertTo-SecureString 'badpass' -AsPlainText -Force))
			{ Get-CCSADComputerOU -ComputerName $env:COMPUTERNAME -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $badCred -ErrorAction Stop } | Should -Throw
		}
	}
}

Describe 'Get-CCSADComputerOU - Performance Tests' -Tag 'Performance' {

	Context 'Pipeline Performance' {

		It 'Should process pipeline input efficiently' {
			$computers = @($env:COMPUTERNAME, $env:COMPUTERNAME, $env:COMPUTERNAME)
			$measure = Measure-Command {
				$results = $computers | Get-CCSADComputerOU -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
			}
			$measure.TotalSeconds | Should -BeLessThan 10
		}
	}
}
