BeforeAll {
    $RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

    $Items = Get-ChildItem -Path "$RootPath\Capa.PowerShell.Module.CCS\Dev\" -Filter '*.ps1' | Where-Object { $_.Name -notlike '*Tests.ps1' }
    foreach ($Item in $Items) {
        Import-Module $Item.FullName -Force -ErrorAction Stop
    }

    # Setup test environment
    $script:TestUrl = "https://$(hostname).capainstaller.com/CCSWebservice/CCS.asmx"
    $script:TestDomain = 'Firmax.local'

    # Setup credentials from environment variables (GitHub secrets)
    if ($env:DOMAINADMINUSERNAME -and $env:DOMAINADMINPASSWORD) {
        $securePassword = ConvertTo-SecureString $env:DOMAINADMINPASSWORD -AsPlainText -Force
        $script:TestDomainCredential = New-Object System.Management.Automation.PSCredential($env:DOMAINADMINUSERNAME, $securePassword)
        $script:TestCCSCredential = $script:TestDomainCredential
    } else {
        $script:TestDomainCredential = Get-Credential -Message 'Enter domain admin credentials for integration tests'
        $script:TestCCSCredential = $script:TestDomainCredential
    }

    $DebugPreference = 'Continue'
    $ErrorActionPreference = 'Stop'
}

Describe 'Add-CCSADComputerToSecurityGroup' -Tag 'Unit' {

    Context 'Parameter Validation' {

        It 'Should have mandatory ComputerName parameter' {
            (Get-Command Add-CCSADComputerToSecurityGroup).Parameters['ComputerName'].Attributes.Mandatory | Should -Be $true
        }

        It 'Should have mandatory SecurityGroupName parameter' {
            (Get-Command Add-CCSADComputerToSecurityGroup).Parameters['SecurityGroupName'].Attributes.Mandatory | Should -Be $true
        }

        It 'Should have mandatory Domain parameter' {
            (Get-Command Add-CCSADComputerToSecurityGroup).Parameters['Domain'].Attributes.Mandatory | Should -Be $true
        }

        It 'Should have mandatory Url parameter' {
            (Get-Command Add-CCSADComputerToSecurityGroup).Parameters['Url'].Attributes.Mandatory | Should -Be $true
        }

        It 'Should have mandatory CCSCredential parameter' {
            (Get-Command Add-CCSADComputerToSecurityGroup).Parameters['CCSCredential'].Attributes.Mandatory | Should -Be $true
        }

        It 'Should have optional DomainCredential parameter' {
            (Get-Command Add-CCSADComputerToSecurityGroup).Parameters['DomainCredential'].Attributes.Mandatory | Should -Be $false
        }

        It 'Should have optional DomainOUPath parameter' {
            (Get-Command Add-CCSADComputerToSecurityGroup).Parameters['DomainOUPath'].Attributes.Mandatory | Should -Be $false
        }

        It 'Should accept array of computer names' {
            (Get-Command Add-CCSADComputerToSecurityGroup).Parameters['ComputerName'].ParameterType.Name | Should -Be 'String[]'
        }

        It 'Should accept pipeline input for ComputerName' {
            (Get-Command Add-CCSADComputerToSecurityGroup).Parameters['ComputerName'].Attributes.ValueFromPipeline | Should -Be $true
        }
    }

    Context 'Parameter Aliases' {

        It 'Should have alias "Name" for ComputerName' {
            (Get-Command Add-CCSADComputerToSecurityGroup).Parameters['ComputerName'].Aliases | Should -Contain 'Name'
        }

        It 'Should have alias "Computer" for ComputerName' {
            (Get-Command Add-CCSADComputerToSecurityGroup).Parameters['ComputerName'].Aliases | Should -Contain 'Computer'
        }

        It 'Should have alias "GroupName" for SecurityGroupName' {
            (Get-Command Add-CCSADComputerToSecurityGroup).Parameters['SecurityGroupName'].Aliases | Should -Contain 'GroupName'
        }

        It 'Should have alias "OU" for DomainOUPath' {
            (Get-Command Add-CCSADComputerToSecurityGroup).Parameters['DomainOUPath'].Aliases | Should -Contain 'OU'
        }
    }

    Context 'DomainOUPath Validation' {

        It 'Should accept empty DomainOUPath' {
            { Add-CCSADComputerToSecurityGroup -ComputerName 'PC01' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath '' -WhatIf } | Should -Not -Throw
        }

        It 'Should accept standard DN format' {
            { Add-CCSADComputerToSecurityGroup -ComputerName 'PC01' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'OU=Computers,DC=Firmax,DC=local' -WhatIf } | Should -Not -Throw
        }

        It 'Should accept DC-only format' {
            { Add-CCSADComputerToSecurityGroup -ComputerName 'PC01' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'DC=Firmax,DC=local' -WhatIf } | Should -Not -Throw
        }

        It 'Should accept LDAP format' {
            { Add-CCSADComputerToSecurityGroup -ComputerName 'PC01' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'LDAP://DC01.Firmax.local/OU=Computers,DC=Firmax,DC=local' -WhatIf } | Should -Not -Throw
        }

        It 'Should reject invalid format' {
            { Add-CCSADComputerToSecurityGroup -ComputerName 'PC01' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'InvalidPath' -WhatIf } | Should -Throw
        }
    }

	Context 'URL Validation' {

		It 'Should accept HTTPS URL' {
			{ Add-CCSADComputerToSecurityGroup -ComputerName 'PC01' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Not -Throw
		}

		It 'Should reject HTTP URL (only HTTPS allowed)' {
			$httpUrl = $script:TestUrl -replace '^https:', 'http:'
			{ Add-CCSADComputerToSecurityGroup -ComputerName 'PC01' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url $httpUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Throw
		}

		It 'Should reject URL without protocol' {
			{ Add-CCSADComputerToSecurityGroup -ComputerName 'PC01' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url 'test.com/CCS.asmx' -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Throw
		}
	}

	Context 'Domain Validation' {

		It 'Should accept valid domain format' {
			{ Add-CCSADComputerToSecurityGroup -ComputerName 'PC01' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Not -Throw
		}

		It 'Should accept subdomain format' {
			{ Add-CCSADComputerToSecurityGroup -ComputerName 'PC01' -SecurityGroupName 'TestGroup' -Domain 'sub.firmax.local' -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Not -Throw
		}

		It 'Should reject invalid domain format' {
			{ Add-CCSADComputerToSecurityGroup -ComputerName 'PC01' -SecurityGroupName 'TestGroup' -Domain 'invalid_domain' -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Throw
		}
	}

	Context 'ShouldProcess Support' {

		It 'Should support WhatIf' {
			(Get-Command Add-CCSADComputerToSecurityGroup).Parameters.ContainsKey('WhatIf') | Should -Be $true
		}

		It 'Should support Confirm' {
			(Get-Command Add-CCSADComputerToSecurityGroup).Parameters.ContainsKey('Confirm') | Should -Be $true
		}
	}

	Context 'CmdletBinding Attributes' {

		It 'Should be an advanced function' {
			(Get-Command Add-CCSADComputerToSecurityGroup).CmdletBinding | Should -Be $true
		}

		It 'Should have SupportsShouldProcess' {
			(Get-Command Add-CCSADComputerToSecurityGroup).Parameters['WhatIf'] | Should -Not -BeNullOrEmpty
		}

		It 'Should have OutputType defined' {
			(Get-Command Add-CCSADComputerToSecurityGroup).OutputType.Name | Should -Contain 'System.String'
		}
	}
}

Describe 'Add-CCSADComputerToSecurityGroup - Integration Tests' -Tag 'Integration' {

    Context 'Live CCS Web Service Operations' {

        BeforeAll {
            # Create unique test group name
            $script:TestGroupName = "PesterTest_$(Get-Random -Minimum 1000 -Maximum 9999)"
            $script:TestComputerName = 'PESTER-TEST-PC'
        }

        It 'Should connect to CCS Web Service successfully' {
            { Add-CCSADComputerToSecurityGroup -ComputerName $script:TestComputerName -SecurityGroupName $script:TestGroupName -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Not -Throw
        }

        It 'Should add computer to security group with domain credentials' {
            $result = Add-CCSADComputerToSecurityGroup -ComputerName $script:TestComputerName -SecurityGroupName $script:TestGroupName -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
            $result | Should -Not -BeNullOrEmpty
        }

        It 'Should process multiple computers' {
            $computers = @("$script:TestComputerName`1", "$script:TestComputerName`2")
            { $computers | Add-CCSADComputerToSecurityGroup -SecurityGroupName $script:TestGroupName -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
        }

        It 'Should convert LDAP path format' {
            $ldapPath = 'LDAP://DC01.Firmax.local/DC=Firmax,DC=local'
            { Add-CCSADComputerToSecurityGroup -ComputerName $script:TestComputerName -SecurityGroupName $script:TestGroupName -DomainOUPath $ldapPath -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
        }

        It 'Should add PESTER-TEST-PC to TestPester group' {
            $result = Add-CCSADComputerToSecurityGroup -ComputerName 'PESTER-TEST-PC' -SecurityGroupName 'TestPester' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction Stop
            $result | Should -Be 'ok'
        }
    }

    Context 'Error Handling' {

        It 'Should handle invalid credentials gracefully' {
            $badCred = New-Object System.Management.Automation.PSCredential('baduser', (ConvertTo-SecureString 'badpass' -AsPlainText -Force))
            { Add-CCSADComputerToSecurityGroup -ComputerName 'TestPC' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $badCred -ErrorAction Stop } | Should -Throw
        }

        It 'Should handle non-existent URL gracefully' {
            { Add-CCSADComputerToSecurityGroup -ComputerName 'TestPC' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url 'https://nonexistent.invalid/CCS.asmx' -CCSCredential $script:TestCCSCredential -ErrorAction Stop } | Should -Throw
        }
    }
}

Describe 'Add-CCSADComputerToSecurityGroup - Performance Tests' -Tag 'Performance' {

    Context 'Pipeline Performance' {

        It 'Should process pipeline input efficiently' {
            $computers = 1..10 | ForEach-Object { "PC$_" }
            $measure = Measure-Command {
                $computers | Add-CCSADComputerToSecurityGroup -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf -WarningAction SilentlyContinue
            }
            $measure.TotalSeconds | Should -BeLessThan 5
        }
    }
}
