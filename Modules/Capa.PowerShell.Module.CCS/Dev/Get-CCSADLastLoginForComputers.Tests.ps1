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

Describe 'Get-CCSADLastLoginForComputers' -Tag 'Unit' {

    Context 'Parameter Validation' {

        It 'Should have mandatory Domain parameter' {
            (Get-Command Get-CCSADLastLoginForComputers).Parameters['Domain'].Attributes.Mandatory | Should -Be $true
        }

        It 'Should have mandatory Url parameter' {
            (Get-Command Get-CCSADLastLoginForComputers).Parameters['Url'].Attributes.Mandatory | Should -Be $true
        }

        It 'Should have mandatory CCSCredential parameter' {
            (Get-Command Get-CCSADLastLoginForComputers).Parameters['CCSCredential'].Attributes.Mandatory | Should -Be $true
        }

        It 'Should have optional DomainCredential parameter' {
            (Get-Command Get-CCSADLastLoginForComputers).Parameters['DomainCredential'].Attributes.Mandatory | Should -Be $false
        }

        It 'Should have optional DomainOUPath parameter' {
            (Get-Command Get-CCSADLastLoginForComputers).Parameters['DomainOUPath'].Attributes.Mandatory | Should -Be $false
        }
    }

    Context 'Parameter Aliases' {

        It 'Should have alias "OU" for DomainOUPath' {
            (Get-Command Get-CCSADLastLoginForComputers).Parameters['DomainOUPath'].Aliases | Should -Contain 'OU'
        }

        It 'Should have alias "SearchBase" for DomainOUPath' {
            (Get-Command Get-CCSADLastLoginForComputers).Parameters['DomainOUPath'].Aliases | Should -Contain 'SearchBase'
        }

        It 'Should have alias "Credential" for CCSCredential' {
            (Get-Command Get-CCSADLastLoginForComputers).Parameters['CCSCredential'].Aliases | Should -Contain 'Credential'
        }

        It 'Should have alias "ADCredential" for DomainCredential' {
            (Get-Command Get-CCSADLastLoginForComputers).Parameters['DomainCredential'].Aliases | Should -Contain 'ADCredential'
        }
    }

    Context 'CmdletBinding Attributes' {

        It 'Should be an advanced function' {
            (Get-Command Get-CCSADLastLoginForComputers).CmdletBinding | Should -Be $true
        }

        It 'Should have OutputType defined' {
            (Get-Command Get-CCSADLastLoginForComputers).OutputType | Should -Not -BeNullOrEmpty
        }
    }
}

Describe 'Get-CCSADLastLoginForComputers - Integration Tests' -Tag 'Integration' {

    Context 'DomainOUPath Validation' {

        It 'Should accept empty DomainOUPath' {
            $result = Get-CCSADLastLoginForComputers -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath '' -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
            $result | Should -Not -BeNullOrEmpty
        }

        It 'Should accept standard DN format' {
            { Get-CCSADLastLoginForComputers -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'OU=Computers,DC=Firmax,DC=local' -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
        }

        It 'Should accept DC-only format' {
            $result = Get-CCSADLastLoginForComputers -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'DC=Firmax,DC=local' -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
            $result | Should -Not -BeNullOrEmpty
        }

        It 'Should accept LDAP format' {
            { Get-CCSADLastLoginForComputers -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'LDAP://DC01.Firmax.local/OU=Computers,DC=Firmax,DC=local' -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
        }

        It 'Should reject invalid format' {
            { Get-CCSADLastLoginForComputers -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'InvalidPath' -ErrorAction Stop } | Should -Throw
        }
    }

    Context 'URL Validation' {

        It 'Should accept HTTPS URL' {
            $result = Get-CCSADLastLoginForComputers -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
            $result | Should -Not -BeNullOrEmpty
        }

        It 'Should reject HTTP URL (only HTTPS allowed)' {
            $httpUrl = $script:TestUrl -replace '^https:', 'http:'
            { Get-CCSADLastLoginForComputers -Domain $script:TestDomain -Url $httpUrl -CCSCredential $script:TestCCSCredential -ErrorAction Stop } | Should -Throw
        }

        It 'Should reject URL without protocol' {
            { Get-CCSADLastLoginForComputers -Domain $script:TestDomain -Url 'test.com/CCS.asmx' -CCSCredential $script:TestCCSCredential -ErrorAction Stop } | Should -Throw
        }
    }

    Context 'Domain Validation' {

        It 'Should accept valid domain format' {
            $result = Get-CCSADLastLoginForComputers -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
            $result | Should -Not -BeNullOrEmpty
        }

        It 'Should accept subdomain format' {
            { Get-CCSADLastLoginForComputers -Domain 'sub.firmax.local' -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
        }

        It 'Should reject invalid domain format' {
            { Get-CCSADLastLoginForComputers -Domain 'invalid_domain' -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction Stop } | Should -Throw
        }
    }

    Context 'Live CCS Web Service Operations' {

        It 'Should connect to CCS Web Service successfully' {
            $result = Get-CCSADLastLoginForComputers -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
            $result | Should -Not -BeNullOrEmpty
        }

        It 'Should retrieve computer last login information' {
            $result = Get-CCSADLastLoginForComputers -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType [PSCustomObject]
        }

        It 'Should retrieve computers with domain credentials' {
            $result = Get-CCSADLastLoginForComputers -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
            $result | Should -Not -BeNullOrEmpty
        }

        It 'Should return objects with correct properties' {
            $result = Get-CCSADLastLoginForComputers -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
            $firstComputer = $result | Select-Object -First 1
            $firstComputer.PSObject.Properties.Name | Should -Contain 'Name'
            $firstComputer.PSObject.Properties.Name | Should -Contain 'LastLogon'
            $firstComputer.PSObject.Properties.Name | Should -Contain 'LastLogonDC'
            $firstComputer.PSObject.Properties.Name | Should -Contain 'OperatingSystem'
            $firstComputer.PSObject.Properties.Name | Should -Contain 'Path'
        }

        It 'Should handle LDAP format for DomainOUPath' {
            $ldapPath = 'LDAP://DC01.Firmax.local/DC=Firmax,DC=local'
            { Get-CCSADLastLoginForComputers -DomainOUPath $ldapPath -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
        }

        It 'Should retrieve computers from specific OU' {
            $ouPath = 'DC=Firmax,DC=local'
            $result = Get-CCSADLastLoginForComputers -DomainOUPath $ouPath -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
            $result | Should -Not -BeNullOrEmpty
        }
    }

    Context 'Error Handling' {

        It 'Should handle invalid credentials gracefully' {
            $badCred = New-Object System.Management.Automation.PSCredential('baduser', (ConvertTo-SecureString 'badpass' -AsPlainText -Force))
            { Get-CCSADLastLoginForComputers -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $badCred -ErrorAction Stop } | Should -Throw
        }

        It 'Should handle non-existent URL gracefully' {
            { Get-CCSADLastLoginForComputers -Domain $script:TestDomain -Url 'https://nonexistent.invalid/CCS.asmx' -CCSCredential $script:TestCCSCredential -ErrorAction Stop } | Should -Throw
        }
    }
}

Describe 'Get-CCSADLastLoginForComputers - Performance Tests' -Tag 'Performance' {

    Context 'Query Performance' {

        It 'Should retrieve computer information in reasonable time' {
            $measure = Measure-Command {
                Get-CCSADLastLoginForComputers -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WarningAction SilentlyContinue -ErrorAction SilentlyContinue
            }
            $measure.TotalSeconds | Should -BeLessThan 30
        }
    }
}
