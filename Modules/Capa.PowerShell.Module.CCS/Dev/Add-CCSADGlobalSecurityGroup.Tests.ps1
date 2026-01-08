
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

Describe 'Add-CCSADGlobalSecurityGroup' -Tag 'Unit' {

	Context 'Parameter Validation' {
		It 'Should have mandatory GroupName parameter' {
			(Get-Command Add-CCSADGlobalSecurityGroup).Parameters['GroupName'].Attributes.Mandatory | Should -Be $true
		}
		It 'Should have mandatory Domain parameter' {
			(Get-Command Add-CCSADGlobalSecurityGroup).Parameters['Domain'].Attributes.Mandatory | Should -Be $true
		}
		It 'Should have mandatory Url parameter' {
			(Get-Command Add-CCSADGlobalSecurityGroup).Parameters['Url'].Attributes.Mandatory | Should -Be $true
		}
		It 'Should have mandatory CCSCredential parameter' {
			(Get-Command Add-CCSADGlobalSecurityGroup).Parameters['CCSCredential'].Attributes.Mandatory | Should -Be $true
		}
		It 'Should have optional DomainCredential parameter' {
			(Get-Command Add-CCSADGlobalSecurityGroup).Parameters['DomainCredential'].Attributes.Mandatory | Should -Be $false
		}
		It 'Should have optional DomainOUPath parameter' {
			(Get-Command Add-CCSADGlobalSecurityGroup).Parameters['DomainOUPath'].Attributes.Mandatory | Should -Be $false
		}
		It 'Should accept array of group names' {
			(Get-Command Add-CCSADGlobalSecurityGroup).Parameters['GroupName'].ParameterType.Name | Should -Be 'String[]'
		}
		It 'Should accept pipeline input for GroupName' {
			(Get-Command Add-CCSADGlobalSecurityGroup).Parameters['GroupName'].Attributes.ValueFromPipeline | Should -Be $true
		}
	}

	Context 'Parameter Aliases' {
		It 'Should have alias "Name" for GroupName' {
			(Get-Command Add-CCSADGlobalSecurityGroup).Parameters['GroupName'].Aliases | Should -Contain 'Name'
		}
		It 'Should have alias "Group" for GroupName' {
			(Get-Command Add-CCSADGlobalSecurityGroup).Parameters['GroupName'].Aliases | Should -Contain 'Group'
		}
		It 'Should have alias "OU" for DomainOUPath' {
			(Get-Command Add-CCSADGlobalSecurityGroup).Parameters['DomainOUPath'].Aliases | Should -Contain 'OU'
		}
		It 'Should have alias "Path" for DomainOUPath' {
			(Get-Command Add-CCSADGlobalSecurityGroup).Parameters['DomainOUPath'].Aliases | Should -Contain 'Path'
		}
		It 'Should have alias "Desc" for Description' {
			(Get-Command Add-CCSADGlobalSecurityGroup).Parameters['Description'].Aliases | Should -Contain 'Desc'
		}
	}

	Context 'DomainOUPath Validation' {
		It 'Should accept empty DomainOUPath' {
			{ Add-CCSADGlobalSecurityGroup -GroupName 'TestGroup' -Description 'desc' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath '' -WhatIf } | Should -Not -Throw
		}
		It 'Should accept standard DN format' {
			{ Add-CCSADGlobalSecurityGroup -GroupName 'TestGroup' -Description 'desc' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'OU=Groups,DC=Firmax,DC=local' -WhatIf } | Should -Not -Throw
		}
		It 'Should accept DC-only format' {
			{ Add-CCSADGlobalSecurityGroup -GroupName 'TestGroup' -Description 'desc' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'DC=Firmax,DC=local' -WhatIf } | Should -Not -Throw
		}
		It 'Should accept LDAP format' {
			{ Add-CCSADGlobalSecurityGroup -GroupName 'TestGroup' -Description 'desc' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'LDAP://DC01.Firmax.local/OU=Groups,DC=Firmax,DC=local' -WhatIf } | Should -Not -Throw
		}
		It 'Should reject invalid format' {
			{ Add-CCSADGlobalSecurityGroup -GroupName 'TestGroup' -Description 'desc' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'InvalidPath' -WhatIf } | Should -Throw
		}
	}

	Context 'URL Validation' {
		It 'Should accept HTTPS URL' {
			{ Add-CCSADGlobalSecurityGroup -GroupName 'TestGroup' -Description 'desc' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Not -Throw
		}
		It 'Should reject HTTP URL (only HTTPS allowed)' {
			$httpUrl = $script:TestUrl -replace '^https:', 'http:'
			{ Add-CCSADGlobalSecurityGroup -GroupName 'TestGroup' -Description 'desc' -Domain $script:TestDomain -Url $httpUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Throw
		}
		It 'Should reject URL without protocol' {
			{ Add-CCSADGlobalSecurityGroup -GroupName 'TestGroup' -Description 'desc' -Domain $script:TestDomain -Url 'test.com/CCS.asmx' -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Throw
		}
	}

	Context 'Domain Validation' {
		It 'Should accept valid domain format' {
			{ Add-CCSADGlobalSecurityGroup -GroupName 'TestGroup' -Description 'desc' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Not -Throw
		}
		It 'Should accept subdomain format' {
			{ Add-CCSADGlobalSecurityGroup -GroupName 'TestGroup' -Description 'desc' -Domain 'sub.firmax.local' -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Not -Throw
		}
		It 'Should reject invalid domain format' {
			{ Add-CCSADGlobalSecurityGroup -GroupName 'TestGroup' -Description 'desc' -Domain 'invalid_domain' -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Throw
		}
	}

	Context 'ShouldProcess Support' {
		It 'Should support WhatIf' {
			(Get-Command Add-CCSADGlobalSecurityGroup).Parameters.ContainsKey('WhatIf') | Should -Be $true
		}
		It 'Should support Confirm' {
			(Get-Command Add-CCSADGlobalSecurityGroup).Parameters.ContainsKey('Confirm') | Should -Be $true
		}
	}

	Context 'CmdletBinding Attributes' {
		It 'Should be an advanced function' {
			(Get-Command Add-CCSADGlobalSecurityGroup).CmdletBinding | Should -Be $true
		}
		It 'Should have SupportsShouldProcess' {
			(Get-Command Add-CCSADGlobalSecurityGroup).Parameters['WhatIf'] | Should -Not -BeNullOrEmpty
		}
		It 'Should have OutputType defined' {
			(Get-Command Add-CCSADGlobalSecurityGroup).OutputType.Name | Should -Contain 'System.String'
		}
	}
}

Describe 'Add-CCSADGlobalSecurityGroup - Integration Tests' -Tag 'Integration' {
	Context 'Live CCS Web Service Operations' {
		BeforeAll {
			$script:TestGroupName = "PesterTestGLG_$(Get-Random -Minimum 1000 -Maximum 9999)"
			$script:TestDescription = 'Pester integration test global group'
		}

		It 'Should connect to CCS Web Service successfully' {
			{ Add-CCSADGlobalSecurityGroup -GroupName $script:TestGroupName -Description $script:TestDescription -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Not -Throw
		}

		It 'Should create global security group with domain credentials' {
			$result = Add-CCSADGlobalSecurityGroup -GroupName $script:TestGroupName -Description $script:TestDescription -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
			$result | Should -Not -BeNullOrEmpty
		}

		It 'Should process multiple group names' {
			$groups = @("$script:TestGroupName`1", "$script:TestGroupName`2")
			{ $groups | Add-CCSADGlobalSecurityGroup -Description $script:TestDescription -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should convert LDAP path format' {
			$ldapPath = 'LDAP://DC01.Firmax.local/DC=Firmax,DC=local'
			{ Add-CCSADGlobalSecurityGroup -GroupName $script:TestGroupName -Description $script:TestDescription -DomainOUPath $ldapPath -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should create PesterTestGLG group in TestPester-Global OU' {
			$result = Add-CCSADGlobalSecurityGroup -GroupName 'TestPester-Global' -Description 'Pester test global group' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction Stop

            $TestsOK = $false
            if ($result -eq 'ok' -or $result -match 'group exist') {
                $TestsOK = $true
            }

            $TestsOK | Should -Be $true
		}
	}

	Context 'Error Handling' {
		It 'Should handle invalid credentials gracefully' {
			$badCred = New-Object System.Management.Automation.PSCredential('baduser', (ConvertTo-SecureString 'badpass' -AsPlainText -Force))
			{ Add-CCSADGlobalSecurityGroup -GroupName 'TestGroup' -Description 'desc' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $badCred -ErrorAction Stop } | Should -Throw
		}
		It 'Should handle non-existent URL gracefully' {
			{ Add-CCSADGlobalSecurityGroup -GroupName 'TestGroup' -Description 'desc' -Domain $script:TestDomain -Url 'https://nonexistent.invalid/CCS.asmx' -CCSCredential $script:TestCCSCredential -ErrorAction Stop } | Should -Throw
		}
	}
}

Describe 'Add-CCSADGlobalSecurityGroup - Performance Tests' -Tag 'Performance' {
	Context 'Pipeline Performance' {
		It 'Should process pipeline input efficiently' {
			$groups = 1..10 | ForEach-Object { "GLG$_" }
			$measure = Measure-Command {
				$groups | Add-CCSADGlobalSecurityGroup -Description 'desc' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf -WarningAction SilentlyContinue
			}
			$measure.TotalSeconds | Should -BeLessThan 5
		}
	}
}
