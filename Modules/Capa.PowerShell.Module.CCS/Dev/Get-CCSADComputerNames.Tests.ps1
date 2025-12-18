
BeforeAll {
	$RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

	$Items = Get-ChildItem -Path "$RootPath\Capa.PowerShell.Module.CCS\Dev\" -Filter '*.ps1' | Where-Object { $_.Name -notlike '*Tests.ps1' }
	foreach ($Item in $Items) {
		Import-Module $Item.FullName -Force -ErrorAction Stop
	}

	$script:TestUrl = "https://$(hostname).capainstaller.com/CCSWebservice/CCS.asmx"
	$script:TestDomain = 'Firmax.local'
	$CredentialPath = "D:\PowerShell\Credentials\$($env:USERNAME)DomainAdminPesterTests.xml"

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

Describe 'Get-CCSADComputerNames' -Tag 'Unit' {

	Context 'Parameter Validation' {
		It 'Should have mandatory Domain parameter' {
			(Get-Command Get-CCSADComputerNames).Parameters['Domain'].Attributes.Mandatory | Should -Be $true
		}
		It 'Should have mandatory Url parameter' {
			(Get-Command Get-CCSADComputerNames).Parameters['Url'].Attributes.Mandatory | Should -Be $true
		}
		It 'Should have mandatory CCSCredential parameter' {
			(Get-Command Get-CCSADComputerNames).Parameters['CCSCredential'].Attributes.Mandatory | Should -Be $true
		}
		It 'Should have optional DomainCredential parameter' {
			(Get-Command Get-CCSADComputerNames).Parameters['DomainCredential'].Attributes.Mandatory | Should -Be $false
		}
		It 'Should have optional DomainOUPath parameter' {
			(Get-Command Get-CCSADComputerNames).Parameters['DomainOUPath'].Attributes.Mandatory | Should -Be $false
		}
	}

	Context 'Parameter Aliases' {
		It 'Should have alias "OU" for DomainOUPath' {
			(Get-Command Get-CCSADComputerNames).Parameters['DomainOUPath'].Aliases | Should -Contain 'OU'
		}
		It 'Should have alias "Path" for DomainOUPath' {
			(Get-Command Get-CCSADComputerNames).Parameters['DomainOUPath'].Aliases | Should -Contain 'Path'
		}
		It 'Should have alias "WebServiceUrl" for Url' {
			(Get-Command Get-CCSADComputerNames).Parameters['Url'].Aliases | Should -Contain 'WebServiceUrl'
		}
		It 'Should have alias "Credential" for CCSCredential' {
			(Get-Command Get-CCSADComputerNames).Parameters['CCSCredential'].Aliases | Should -Contain 'Credential'
		}
	}

	Context 'DomainOUPath Validation' {
		It 'Should accept empty DomainOUPath' {
			{ Get-CCSADComputerNames -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath '' -WhatIf } | Should -Not -Throw
		}
		It 'Should accept standard DN format' {
			{ Get-CCSADComputerNames -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'OU=Computers,DC=Firmax,DC=local' -WhatIf } | Should -Not -Throw
		}
		It 'Should accept DC-only format' {
			{ Get-CCSADComputerNames -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'DC=Firmax,DC=local' -WhatIf } | Should -Not -Throw
		}
		It 'Should accept LDAP format' {
			{ Get-CCSADComputerNames -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'LDAP://DC01.Firmax.local/OU=Computers,DC=Firmax,DC=local' -WhatIf } | Should -Not -Throw
		}
		It 'Should reject invalid format' {
			{ Get-CCSADComputerNames -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'InvalidPath' -WhatIf } | Should -Throw
		}
	}

	Context 'URL Validation' {
		It 'Should accept HTTPS URL' {
			{ Get-CCSADComputerNames -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Not -Throw
		}
		It 'Should reject HTTP URL (only HTTPS allowed)' {
			$httpUrl = $script:TestUrl -replace '^https:', 'http:'
			{ Get-CCSADComputerNames -Domain $script:TestDomain -Url $httpUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Throw
		}
		It 'Should reject URL without protocol' {
			{ Get-CCSADComputerNames -Domain $script:TestDomain -Url 'test.com/CCS.asmx' -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Throw
		}
	}

	Context 'Domain Validation' {
		It 'Should accept valid domain format' {
			{ Get-CCSADComputerNames -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Not -Throw
		}
		It 'Should accept subdomain format' {
			{ Get-CCSADComputerNames -Domain 'sub.firmax.local' -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Not -Throw
		}
		It 'Should reject invalid domain format' {
			{ Get-CCSADComputerNames -Domain 'invalid_domain' -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Throw
		}
	}

	Context 'ShouldProcess Support' {
		It 'Should support WhatIf' {
			(Get-Command Get-CCSADComputerNames).Parameters.ContainsKey('WhatIf') | Should -Be $true
		}
		It 'Should support Confirm' {
			(Get-Command Get-CCSADComputerNames).Parameters.ContainsKey('Confirm') | Should -Be $true
		}
	}

	Context 'CmdletBinding Attributes' {
		It 'Should be an advanced function' {
			(Get-Command Get-CCSADComputerNames).CmdletBinding | Should -Be $true
		}
		It 'Should have SupportsShouldProcess' {
			(Get-Command Get-CCSADComputerNames).Parameters['WhatIf'] | Should -Not -BeNullOrEmpty
		}
		It 'Should have OutputType defined' {
			(Get-Command Get-CCSADComputerNames).OutputType.Name | Should -Contain 'System.String[]'
		}
	}
}

Describe 'Get-CCSADComputerNames - Integration Tests' -Tag 'Integration' {
	Context 'Live CCS Web Service Operations' {
		BeforeAll {
            $script:TestOU = 'OU=Computers,OU=AzureAD synk,DC=FirmaX,DC=Local'
		}

		It 'Should connect to CCS Web Service successfully' {
			{ Get-CCSADComputerNames -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Not -Throw
		}

		It 'Should get computer names with domain credentials' {
			$result = Get-CCSADComputerNames -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
			$result | Should -Not -BeNullOrEmpty
		}

		It 'Should get computer names for specific OU' {
			$result = Get-CCSADComputerNames -Domain $script:TestDomain -DomainOUPath $script:TestOU -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
            $result | Should -Not -BeNullOrEmpty
		}

		It 'Should convert LDAP path format' {
			$ldapPath = 'LDAP://DC01.Firmax.local/OU=Computers,DC=Firmax,DC=local'
			{ Get-CCSADComputerNames -Domain $script:TestDomain -DomainOUPath $ldapPath -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}
	}

	Context 'Error Handling' {
		It 'Should handle invalid credentials gracefully' {
			$badCred = New-Object System.Management.Automation.PSCredential('baduser', (ConvertTo-SecureString 'badpass' -AsPlainText -Force))
			{ Get-CCSADComputerNames -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $badCred -ErrorAction Stop } | Should -Throw
		}
		It 'Should handle non-existent URL gracefully' {
			{ Get-CCSADComputerNames -Domain $script:TestDomain -Url 'https://nonexistent.invalid/CCS.asmx' -CCSCredential $script:TestCCSCredential -ErrorAction Stop } | Should -Throw
		}
	}
}

Describe 'Get-CCSADComputerNames - Performance Tests' -Tag 'Performance' {
	Context 'Pipeline Performance' {
		It 'Should process efficiently' {
			$measure = Measure-Command {
				Get-CCSADComputerNames -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf -WarningAction SilentlyContinue
			}
			$measure.TotalSeconds | Should -BeLessThan 5
		}
	}
}
