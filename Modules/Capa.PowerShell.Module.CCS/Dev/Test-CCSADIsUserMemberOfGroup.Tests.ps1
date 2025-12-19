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

Describe 'Test-CCSADIsUserMemberOfGroup' -Tag 'Unit' {

    Context 'Parameter Validation' {

        It 'Should have mandatory UserName parameter' {
            (Get-Command Test-CCSADIsUserMemberOfGroup).Parameters['UserName'].Attributes.Mandatory | Should -Be $true
        }

        It 'Should have mandatory GroupName parameter' {
            (Get-Command Test-CCSADIsUserMemberOfGroup).Parameters['GroupName'].Attributes.Mandatory | Should -Be $true
        }

        It 'Should have mandatory Domain parameter' {
            (Get-Command Test-CCSADIsUserMemberOfGroup).Parameters['Domain'].Attributes.Mandatory | Should -Be $true
        }

        It 'Should have mandatory Url parameter' {
            (Get-Command Test-CCSADIsUserMemberOfGroup).Parameters['Url'].Attributes.Mandatory | Should -Be $true
        }

        It 'Should have mandatory CCSCredential parameter' {
            (Get-Command Test-CCSADIsUserMemberOfGroup).Parameters['CCSCredential'].Attributes.Mandatory | Should -Be $true
        }

        It 'Should have optional DomainCredential parameter' {
            (Get-Command Test-CCSADIsUserMemberOfGroup).Parameters['DomainCredential'].Attributes.Mandatory | Should -Be $false
        }

        It 'Should have optional DomainOUPath parameter' {
            (Get-Command Test-CCSADIsUserMemberOfGroup).Parameters['DomainOUPath'].Attributes.Mandatory | Should -Be $false
        }

        It 'Should accept pipeline input for UserName' {
            (Get-Command Test-CCSADIsUserMemberOfGroup).Parameters['UserName'].Attributes.ValueFromPipeline | Should -Be $true
        }
    }

    Context 'Parameter Aliases' {

        It 'Should have alias "Name" for UserName' {
            (Get-Command Test-CCSADIsUserMemberOfGroup).Parameters['UserName'].Aliases | Should -Contain 'Name'
        }

        It 'Should have alias "User" for UserName' {
            (Get-Command Test-CCSADIsUserMemberOfGroup).Parameters['UserName'].Aliases | Should -Contain 'User'
        }

        It 'Should have alias "Group" for GroupName' {
            (Get-Command Test-CCSADIsUserMemberOfGroup).Parameters['GroupName'].Aliases | Should -Contain 'Group'
        }

        It 'Should have alias "OU" for DomainOUPath' {
            (Get-Command Test-CCSADIsUserMemberOfGroup).Parameters['DomainOUPath'].Aliases | Should -Contain 'OU'
        }
    }

	Context 'DomainOUPath Validation' {

		It 'Should reject invalid format' {
			{ Test-CCSADIsUserMemberOfGroup -UserName 'testuser' -GroupName 'TestGroup' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'InvalidPath' -ErrorAction Stop } | Should -Throw
		}
	}

	Context 'URL Validation' {

		It 'Should reject HTTP URL (only HTTPS allowed)' {
			$httpUrl = $script:TestUrl -replace '^https:', 'http:'
			{ Test-CCSADIsUserMemberOfGroup -UserName 'testuser' -GroupName 'TestGroup' -Domain $script:TestDomain -Url $httpUrl -CCSCredential $script:TestCCSCredential -ErrorAction Stop } | Should -Throw
		}

		It 'Should reject URL without protocol' {
			{ Test-CCSADIsUserMemberOfGroup -UserName 'testuser' -GroupName 'TestGroup' -Domain $script:TestDomain -Url 'test.com/CCS.asmx' -CCSCredential $script:TestCCSCredential -ErrorAction Stop } | Should -Throw
		}
	}

	Context 'Domain Validation' {

		It 'Should reject invalid domain format' {
			{ Test-CCSADIsUserMemberOfGroup -UserName 'testuser' -GroupName 'TestGroup' -Domain 'invalid_domain' -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction Stop } | Should -Throw
		}
	}

	Context 'CmdletBinding Attributes' {

		It 'Should be an advanced function' {
			(Get-Command Test-CCSADIsUserMemberOfGroup).CmdletBinding | Should -Be $true
		}

		It 'Should NOT have SupportsShouldProcess (read-only operation)' {
			(Get-Command Test-CCSADIsUserMemberOfGroup).Parameters['WhatIf'] | Should -BeNullOrEmpty
		}

		It 'Should have OutputType attribute' {
			$Command = Get-Command Test-CCSADIsUserMemberOfGroup
			$Command.OutputType | Should -Not -BeNullOrEmpty
		}
	}
}

Describe 'Test-CCSADIsUserMemberOfGroup - Integration Tests' -Tag 'Integration' {

	Context 'Live CCS Web Service Operations' {

		BeforeAll {
			$script:TestUserName = $env:USERNAME
			$script:TestGroupName = 'Domain Users'
		}

		It 'Should connect to CCS Web Service successfully' {
			{ Test-CCSADIsUserMemberOfGroup -UserName $script:TestUserName -GroupName $script:TestGroupName -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should return true for user that is member of group' {
			$result = Test-CCSADIsUserMemberOfGroup -UserName $script:TestUserName -GroupName $script:TestGroupName -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
			$result | Should -Be $true
		}

		It 'Should return false for user that is not member of group' {
			$result = Test-CCSADIsUserMemberOfGroup -UserName $script:TestUserName -GroupName 'NonExistentGroup_XYZ123' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
			$result | Should -Be $false
		}

		It 'Should test user membership with domain credentials' {
			$result = Test-CCSADIsUserMemberOfGroup -UserName $script:TestUserName -GroupName $script:TestGroupName -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
			$result | Should -Be $true
		}

		It 'Should process multiple users via pipeline' {
			$users = @($script:TestUserName, $script:TestUserName)
			$results = $users | Test-CCSADIsUserMemberOfGroup -GroupName $script:TestGroupName -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
			$results.Count | Should -Be 2
			$results | ForEach-Object { $_ | Should -Be $true }
		}

		It 'Should convert LDAP path format' {
			$ldapPath = 'LDAP://DC01.Firmax.local/DC=Firmax,DC=local'
			$result = Test-CCSADIsUserMemberOfGroup -UserName $script:TestUserName -GroupName $script:TestGroupName -DomainOUPath $ldapPath -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
			$result | Should -Be $true
		}

		It 'Should handle empty DomainOUPath' {
			$result = Test-CCSADIsUserMemberOfGroup -UserName $script:TestUserName -GroupName $script:TestGroupName -DomainOUPath '' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
			$result | Should -Be $true
		}
	}

	Context 'Error Handling' {

		It 'Should handle invalid credentials gracefully' {
			$badCred = New-Object System.Management.Automation.PSCredential('baduser', (ConvertTo-SecureString 'badpass' -AsPlainText -Force))
			$result = Test-CCSADIsUserMemberOfGroup -UserName 'TestUser' -GroupName 'TestGroup' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $badCred -ErrorAction SilentlyContinue
			$result | Should -Be $false
		}

		It 'Should handle non-existent URL gracefully' {
			$result = Test-CCSADIsUserMemberOfGroup -UserName 'TestUser' -GroupName 'TestGroup' -Domain $script:TestDomain -Url 'https://nonexistent.invalid/CCS.asmx' -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue
			$result | Should -Be $false
		}

		It 'Should handle non-existent user gracefully' {
			$result = Test-CCSADIsUserMemberOfGroup -UserName 'NonExistentUser_XYZ123' -GroupName $script:TestGroupName -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
			$result | Should -Be $false
		}
	}
}

Describe 'Test-CCSADIsUserMemberOfGroup - Performance Tests' -Tag 'Performance' {

	Context 'Pipeline Performance' {

		It 'Should process pipeline input efficiently' {
			$users = 1..10 | ForEach-Object { $env:USERNAME }
			$measure = Measure-Command {
				$users | Test-CCSADIsUserMemberOfGroup -GroupName 'Domain Users' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
			}
			$measure.TotalSeconds | Should -BeLessThan 10
		}
	}
}
