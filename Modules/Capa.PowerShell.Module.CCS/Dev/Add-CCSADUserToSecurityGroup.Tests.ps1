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

Describe 'Add-CCSADUserToSecurityGroup' -Tag 'Unit' {

    Context 'Parameter Validation' {

        It 'Should have mandatory UserName parameter' {
            (Get-Command Add-CCSADUserToSecurityGroup).Parameters['UserName'].Attributes.Mandatory | Should -Be $true
        }

        It 'Should have mandatory SecurityGroupName parameter' {
            (Get-Command Add-CCSADUserToSecurityGroup).Parameters['SecurityGroupName'].Attributes.Mandatory | Should -Be $true
        }

        It 'Should have mandatory Domain parameter' {
            (Get-Command Add-CCSADUserToSecurityGroup).Parameters['Domain'].Attributes.Mandatory | Should -Be $true
        }

        It 'Should have mandatory Url parameter' {
            (Get-Command Add-CCSADUserToSecurityGroup).Parameters['Url'].Attributes.Mandatory | Should -Be $true
        }

        It 'Should have mandatory CCSCredential parameter' {
            (Get-Command Add-CCSADUserToSecurityGroup).Parameters['CCSCredential'].Attributes.Mandatory | Should -Be $true
        }

        It 'Should have optional DomainCredential parameter' {
            (Get-Command Add-CCSADUserToSecurityGroup).Parameters['DomainCredential'].Attributes.Mandatory | Should -Be $false
        }

        It 'Should have optional DomainOUPath parameter' {
            (Get-Command Add-CCSADUserToSecurityGroup).Parameters['DomainOUPath'].Attributes.Mandatory | Should -Be $false
        }

        It 'Should accept array of user names' {
            (Get-Command Add-CCSADUserToSecurityGroup).Parameters['UserName'].ParameterType.Name | Should -Be 'String[]'
        }

        It 'Should accept pipeline input for UserName' {
            (Get-Command Add-CCSADUserToSecurityGroup).Parameters['UserName'].Attributes.ValueFromPipeline | Should -Be $true
        }
    }

    Context 'Parameter Aliases' {

        It 'Should have alias "Name" for UserName' {
            (Get-Command Add-CCSADUserToSecurityGroup).Parameters['UserName'].Aliases | Should -Contain 'Name'
        }

        It 'Should have alias "User" for UserName' {
            (Get-Command Add-CCSADUserToSecurityGroup).Parameters['UserName'].Aliases | Should -Contain 'User'
        }

        It 'Should have alias "GroupName" for SecurityGroupName' {
            (Get-Command Add-CCSADUserToSecurityGroup).Parameters['SecurityGroupName'].Aliases | Should -Contain 'GroupName'
        }

        It 'Should have alias "OU" for DomainOUPath' {
            (Get-Command Add-CCSADUserToSecurityGroup).Parameters['DomainOUPath'].Aliases | Should -Contain 'OU'
        }
    }

    Context 'DomainOUPath Validation' {

        It 'Should accept empty DomainOUPath' {
            { Add-CCSADUserToSecurityGroup -UserName 'testuser' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath '' -WhatIf } | Should -Not -Throw
        }

        It 'Should accept standard DN format' {
            { Add-CCSADUserToSecurityGroup -UserName 'testuser' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'OU=Users,DC=Firmax,DC=local' -WhatIf } | Should -Not -Throw
        }

        It 'Should accept DC-only format' {
            { Add-CCSADUserToSecurityGroup -UserName 'testuser' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'DC=Firmax,DC=local' -WhatIf } | Should -Not -Throw
        }

        It 'Should accept LDAP format' {
            { Add-CCSADUserToSecurityGroup -UserName 'testuser' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'LDAP://DC01.Firmax.local/OU=Users,DC=Firmax,DC=local' -WhatIf } | Should -Not -Throw
        }

        It 'Should reject invalid format' {
            { Add-CCSADUserToSecurityGroup -UserName 'testuser' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'InvalidPath' -WhatIf } | Should -Throw
        }
    }

    Context 'URL Validation' {

        It 'Should accept HTTPS URL' {
            { Add-CCSADUserToSecurityGroup -UserName 'testuser' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Not -Throw
        }

        It 'Should reject HTTP URL (only HTTPS allowed)' {
            $httpUrl = $script:TestUrl -replace '^https:', 'http:'
            { Add-CCSADUserToSecurityGroup -UserName 'testuser' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url $httpUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Throw
        }

        It 'Should reject URL without protocol' {
            { Add-CCSADUserToSecurityGroup -UserName 'testuser' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url 'test.com/CCS.asmx' -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Throw
        }
    }

    Context 'Domain Validation' {

        It 'Should accept valid domain format' {
            { Add-CCSADUserToSecurityGroup -UserName 'testuser' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Not -Throw
        }

        It 'Should accept subdomain format' {
            { Add-CCSADUserToSecurityGroup -UserName 'testuser' -SecurityGroupName 'TestGroup' -Domain 'sub.firmax.local' -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Not -Throw
        }

        It 'Should reject invalid domain format' {
            { Add-CCSADUserToSecurityGroup -UserName 'testuser' -SecurityGroupName 'TestGroup' -Domain 'invalid_domain' -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Throw
        }
    }

    Context 'ShouldProcess Support' {

        It 'Should support WhatIf' {
            (Get-Command Add-CCSADUserToSecurityGroup).Parameters.ContainsKey('WhatIf') | Should -Be $true
        }

        It 'Should support Confirm' {
            (Get-Command Add-CCSADUserToSecurityGroup).Parameters.ContainsKey('Confirm') | Should -Be $true
        }
    }

    Context 'CmdletBinding Attributes' {

        It 'Should be an advanced function' {
            (Get-Command Add-CCSADUserToSecurityGroup).CmdletBinding | Should -Be $true
        }

        It 'Should have SupportsShouldProcess' {
            (Get-Command Add-CCSADUserToSecurityGroup).Parameters['WhatIf'] | Should -Not -BeNullOrEmpty
        }

        It 'Should have OutputType defined' {
            (Get-Command Add-CCSADUserToSecurityGroup).OutputType.Name | Should -Contain 'System.String'
        }
    }
}

Describe 'Add-CCSADUserToSecurityGroup - Integration Tests' -Tag 'Integration' {

    Context 'Live CCS Web Service Operations' {

        BeforeAll {
            $script:TestUserName = 'PesterTests'
            $script:TestGroupName1 = 'TestPester'
            $script:TestGroupName2 = 'TestPester-DomainLocal'
        }

        It 'Should connect to CCS Web Service successfully' {
            { Add-CCSADUserToSecurityGroup -UserName $script:TestUserName -SecurityGroupName $script:TestGroupName1 -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Not -Throw
        }

        It 'Should add user to security group with domain credentials' {
            $result = Add-CCSADUserToSecurityGroup -UserName $script:TestUserName -SecurityGroupName $script:TestGroupName1 -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
            $result | Should -Not -BeNullOrEmpty
        }

        It 'Should add user to domain local group' {
            $result = Add-CCSADUserToSecurityGroup -UserName $script:TestUserName -SecurityGroupName $script:TestGroupName2 -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
            $result | Should -Not -BeNullOrEmpty
        }

        It 'Should process multiple users' {
            $users = @("$script:TestUserName`1", "$script:TestUserName`2")
            { $users | Add-CCSADUserToSecurityGroup -SecurityGroupName $script:TestGroupName1 -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
        }

        It 'Should convert LDAP path format' {
            $ldapPath = 'LDAP://DC01.Firmax.local/DC=Firmax,DC=local'
            { Add-CCSADUserToSecurityGroup -UserName $script:TestUserName -SecurityGroupName $script:TestGroupName1 -DomainOUPath $ldapPath -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
        }

        It 'Should add PesterTests to TestPester group and return ok' {
            $result = Add-CCSADUserToSecurityGroup -UserName 'PesterTests' -SecurityGroupName 'TestPester' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction Stop
            $result | Should -Be 'The user is already member og the group'
        }
    }

    Context 'Error Handling' {

        It 'Should handle invalid credentials gracefully' {
            $badCred = New-Object System.Management.Automation.PSCredential('baduser', (ConvertTo-SecureString 'badpass' -AsPlainText -Force))
            { Add-CCSADUserToSecurityGroup -UserName 'testuser' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $badCred -ErrorAction Stop } | Should -Throw
        }

        It 'Should handle non-existent URL gracefully' {
            { Add-CCSADUserToSecurityGroup -UserName 'testuser' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url 'https://nonexistent.invalid/CCS.asmx' -CCSCredential $script:TestCCSCredential -ErrorAction Stop } | Should -Throw
        }
    }
}

Describe 'Add-CCSADUserToSecurityGroup - Performance Tests' -Tag 'Performance' {

    Context 'Pipeline Performance' {

        It 'Should process pipeline input efficiently' {
            $users = 1..10 | ForEach-Object { "User$_" }
            $measure = Measure-Command {
                $users | Add-CCSADUserToSecurityGroup -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf -WarningAction SilentlyContinue
            }
            $measure.TotalSeconds | Should -BeLessThan 5
        }
    }
}