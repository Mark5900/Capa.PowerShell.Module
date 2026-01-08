
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

Describe 'Add-CCSADUniversalSecurityGroup' -Tag 'Unit' {

	Context 'Parameter Validation' {
		It 'Should have mandatory GroupName parameter' {
			(Get-Command Add-CCSADUniversalSecurityGroup).Parameters['GroupName'].Attributes.Mandatory | Should -Be $true
		}
		It 'Should have mandatory Domain parameter' {
			(Get-Command Add-CCSADUniversalSecurityGroup).Parameters['Domain'].Attributes.Mandatory | Should -Be $true
		}
		It 'Should have mandatory Url parameter' {
			(Get-Command Add-CCSADUniversalSecurityGroup).Parameters['Url'].Attributes.Mandatory | Should -Be $true
		}
		It 'Should have mandatory CCSCredential parameter' {
			(Get-Command Add-CCSADUniversalSecurityGroup).Parameters['CCSCredential'].Attributes.Mandatory | Should -Be $true
		}
		It 'Should have optional DomainCredential parameter' {
			(Get-Command Add-CCSADUniversalSecurityGroup).Parameters['DomainCredential'].Attributes.Mandatory | Should -Be $false
		}
		It 'Should have optional DomainOUPath parameter' {
			(Get-Command Add-CCSADUniversalSecurityGroup).Parameters['DomainOUPath'].Attributes.Mandatory | Should -Be $false
		}
		It 'Should accept array of group names' {
			(Get-Command Add-CCSADUniversalSecurityGroup).Parameters['GroupName'].ParameterType.Name | Should -Be 'String[]'
		}
		It 'Should accept pipeline input for GroupName' {
			(Get-Command Add-CCSADUniversalSecurityGroup).Parameters['GroupName'].Attributes.ValueFromPipeline | Should -Be $true
		}
	}

	Context 'Parameter Aliases' {
		It 'Should have alias "Name" for GroupName' {
			(Get-Command Add-CCSADUniversalSecurityGroup).Parameters['GroupName'].Aliases | Should -Contain 'Name'
		}
		It 'Should have alias "Group" for GroupName' {
			(Get-Command Add-CCSADUniversalSecurityGroup).Parameters['GroupName'].Aliases | Should -Contain 'Group'
		}
		It 'Should have alias "OU" for DomainOUPath' {
			(Get-Command Add-CCSADUniversalSecurityGroup).Parameters['DomainOUPath'].Aliases | Should -Contain 'OU'
		}
		It 'Should have alias "Path" for DomainOUPath' {
			(Get-Command Add-CCSADUniversalSecurityGroup).Parameters['DomainOUPath'].Aliases | Should -Contain 'Path'
		}
		It 'Should have alias "Desc" for Description' {
			(Get-Command Add-CCSADUniversalSecurityGroup).Parameters['Description'].Aliases | Should -Contain 'Desc'
		}
	}

	Context 'DomainOUPath Validation' {
		It 'Should accept empty DomainOUPath' {
			{ Add-CCSADUniversalSecurityGroup -GroupName 'TestGroup' -Description 'desc' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath '' -WhatIf } | Should -Not -Throw
		}
		It 'Should accept standard DN format' {
			{ Add-CCSADUniversalSecurityGroup -GroupName 'TestGroup' -Description 'desc' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'OU=Groups,DC=Firmax,DC=local' -WhatIf } | Should -Not -Throw
		}
		It 'Should accept DC-only format' {
			{ Add-CCSADUniversalSecurityGroup -GroupName 'TestGroup' -Description 'desc' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'DC=Firmax,DC=local' -WhatIf } | Should -Not -Throw
		}
		It 'Should accept LDAP format' {
			{ Add-CCSADUniversalSecurityGroup -GroupName 'TestGroup' -Description 'desc' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'LDAP://DC01.Firmax.local/OU=Groups,DC=Firmax,DC=local' -WhatIf } | Should -Not -Throw
		}
		It 'Should reject invalid format' {
			{ Add-CCSADUniversalSecurityGroup -GroupName 'TestGroup' -Description 'desc' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'InvalidPath' -WhatIf } | Should -Throw
		}
	}

	Context 'URL Validation' {
		It 'Should accept HTTPS URL' {
			{ Add-CCSADUniversalSecurityGroup -GroupName 'TestGroup' -Description 'desc' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Not -Throw
		}
		It 'Should reject HTTP URL (only HTTPS allowed)' {
			$httpUrl = $script:TestUrl -replace '^https:', 'http:'
			{ Add-CCSADUniversalSecurityGroup -GroupName 'TestGroup' -Description 'desc' -Domain $script:TestDomain -Url $httpUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Throw
		}
		It 'Should reject URL without protocol' {
			{ Add-CCSADUniversalSecurityGroup -GroupName 'TestGroup' -Description 'desc' -Domain $script:TestDomain -Url 'test.com/CCS.asmx' -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Throw
		}
	}

	Context 'Domain Validation' {
		It 'Should accept valid domain format' {
			{ Add-CCSADUniversalSecurityGroup -GroupName 'TestGroup' -Description 'desc' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Not -Throw
		}
		It 'Should accept subdomain format' {
			{ Add-CCSADUniversalSecurityGroup -GroupName 'TestGroup' -Description 'desc' -Domain 'sub.firmax.local' -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Not -Throw
		}
		It 'Should reject invalid domain format' {
			{ Add-CCSADUniversalSecurityGroup -GroupName 'TestGroup' -Description 'desc' -Domain 'invalid_domain' -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Throw
		}
	}

	Context 'ShouldProcess Support' {
		It 'Should support WhatIf' {
			(Get-Command Add-CCSADUniversalSecurityGroup).Parameters.ContainsKey('WhatIf') | Should -Be $true
		}
		It 'Should support Confirm' {
			(Get-Command Add-CCSADUniversalSecurityGroup).Parameters.ContainsKey('Confirm') | Should -Be $true
		}
	}

	Context 'CmdletBinding Attributes' {
		It 'Should be an advanced function' {
			(Get-Command Add-CCSADUniversalSecurityGroup).CmdletBinding | Should -Be $true
		}
		It 'Should have SupportsShouldProcess' {
			(Get-Command Add-CCSADUniversalSecurityGroup).Parameters['WhatIf'] | Should -Not -BeNullOrEmpty
		}
		It 'Should have OutputType defined' {
			(Get-Command Add-CCSADUniversalSecurityGroup).OutputType.Name | Should -Contain 'System.String'
		}
	}
}

Describe 'Add-CCSADUniversalSecurityGroup - Integration Tests' -Tag 'Integration' {
	Context 'Live CCS Web Service Operations' {
		BeforeAll {
			$script:TestGroupName = "PesterTestUSG_$(Get-Random -Minimum 1000 -Maximum 9999)"
			$script:TestDescription = 'Pester integration test universal group'
		}

		It 'Should connect to CCS Web Service successfully' {
			{ Add-CCSADUniversalSecurityGroup -GroupName $script:TestGroupName -Description $script:TestDescription -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Not -Throw
		}

		It 'Should create universal security group with domain credentials' {
			$result = Add-CCSADUniversalSecurityGroup -GroupName $script:TestGroupName -Description $script:TestDescription -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
			$result | Should -Not -BeNullOrEmpty
		}

		It 'Should process multiple group names' {
			$groups = @("$script:TestGroupName`1", "$script:TestGroupName`2")
			{ $groups | Add-CCSADUniversalSecurityGroup -Description $script:TestDescription -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should convert LDAP path format' {
			$ldapPath = 'LDAP://DC01.Firmax.local/DC=Firmax,DC=local'
			{ Add-CCSADUniversalSecurityGroup -GroupName $script:TestGroupName -Description $script:TestDescription -DomainOUPath $ldapPath -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should create PesterTestUSG group in TestPester-Universal OU' {
			$result = Add-CCSADUniversalSecurityGroup -GroupName 'TestPester-Universal' -Description 'Pester test universal group' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction Stop

            $TestsOk = $false
            if ($result -eq 'ok' -or $result -match 'group exist') {
                $TestsOk = $true
            }

            $TestsOk | Should -Be $true
		}
	}

	Context 'Error Handling' {
		It 'Should handle invalid credentials gracefully' {
			$badCred = New-Object System.Management.Automation.PSCredential('baduser', (ConvertTo-SecureString 'badpass' -AsPlainText -Force))
			{ Add-CCSADUniversalSecurityGroup -GroupName 'TestGroup' -Description 'desc' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $badCred -ErrorAction Stop } | Should -Throw
		}
		It 'Should handle non-existent URL gracefully' {
			{ Add-CCSADUniversalSecurityGroup -GroupName 'TestGroup' -Description 'desc' -Domain $script:TestDomain -Url 'https://nonexistent.invalid/CCS.asmx' -CCSCredential $script:TestCCSCredential -ErrorAction Stop } | Should -Throw
		}
	}
}

Describe 'Add-CCSADUniversalSecurityGroup - Performance Tests' -Tag 'Performance' {
	Context 'Pipeline Performance' {
		It 'Should process pipeline input efficiently' {
			$groups = 1..10 | ForEach-Object { "USG$_" }
			$measure = Measure-Command {
				$groups | Add-CCSADUniversalSecurityGroup -Description 'desc' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf -WarningAction SilentlyContinue
			}
			$measure.TotalSeconds | Should -BeLessThan 5
		}
	}
}
