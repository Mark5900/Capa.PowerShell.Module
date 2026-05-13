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

Describe 'Get-CCSADSid' -Tag 'Unit' {

    Context 'Parameter Validation' {

        It 'Should have mandatory ComputerName parameter' {
            (Get-Command Get-CCSADSid).Parameters['ComputerName'].Attributes.Mandatory | Should -Be $true
        }

        It 'Should have mandatory Domain parameter' {
            (Get-Command Get-CCSADSid).Parameters['Domain'].Attributes.Mandatory | Should -Be $true
        }

        It 'Should have mandatory Url parameter' {
            (Get-Command Get-CCSADSid).Parameters['Url'].Attributes.Mandatory | Should -Be $true
        }

        It 'Should have mandatory CCSCredential parameter' {
            (Get-Command Get-CCSADSid).Parameters['CCSCredential'].Attributes.Mandatory | Should -Be $true
        }

        It 'Should have optional DomainCredential parameter' {
            (Get-Command Get-CCSADSid).Parameters['DomainCredential'].Attributes.Mandatory | Should -Be $false
        }

        It 'Should have optional DomainOUPath parameter' {
            (Get-Command Get-CCSADSid).Parameters['DomainOUPath'].Attributes.Mandatory | Should -Be $false
        }

        It 'Should accept array of computer names' {
            (Get-Command Get-CCSADSid).Parameters['ComputerName'].ParameterType.Name | Should -Be 'String[]'
        }

        It 'Should accept pipeline input for ComputerName' {
            (Get-Command Get-CCSADSid).Parameters['ComputerName'].Attributes.ValueFromPipeline | Should -Be $true
        }
    }

    Context 'Parameter Aliases' {

        It 'Should have alias "Name" for ComputerName' {
            (Get-Command Get-CCSADSid).Parameters['ComputerName'].Aliases | Should -Contain 'Name'
        }

        It 'Should have alias "Computer" for ComputerName' {
            (Get-Command Get-CCSADSid).Parameters['ComputerName'].Aliases | Should -Contain 'Computer'
        }

        It 'Should have alias "OU" for DomainOUPath' {
            (Get-Command Get-CCSADSid).Parameters['DomainOUPath'].Aliases | Should -Contain 'OU'
        }

        It 'Should have alias "SearchBase" for DomainOUPath' {
            (Get-Command Get-CCSADSid).Parameters['DomainOUPath'].Aliases | Should -Contain 'SearchBase'
        }
    }

    Context 'CmdletBinding Attributes' {

        It 'Should be an advanced function' {
            (Get-Command Get-CCSADSid).CmdletBinding | Should -Be $true
        }

        It 'Should have OutputType defined' {
            (Get-Command Get-CCSADSid).OutputType.Name | Should -Contain 'System.String'
        }
    }
}

Describe 'Get-CCSADSid - Integration Tests' -Tag 'Integration' {

    Context 'DomainOUPath Validation' {

        It 'Should accept empty DomainOUPath' {
            $result = Get-CCSADSid -ComputerName $env:COMPUTERNAME -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath '' -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
            $result | Should -Not -BeNullOrEmpty
        }

        It 'Should accept standard DN format' {
            { Get-CCSADSid -ComputerName $env:COMPUTERNAME -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'OU=Computers,DC=Firmax,DC=local' -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
        }

        It 'Should accept DC-only format' {
            $result = Get-CCSADSid -ComputerName $env:COMPUTERNAME -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'DC=Firmax,DC=local' -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
            $result | Should -Not -BeNullOrEmpty
        }

        It 'Should accept LDAP format' {
            { Get-CCSADSid -ComputerName $env:COMPUTERNAME -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'LDAP://DC01.Firmax.local/OU=Computers,DC=Firmax,DC=local' -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
        }

        It 'Should reject invalid format' {
            { Get-CCSADSid -ComputerName $env:COMPUTERNAME -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'InvalidPath' -ErrorAction Stop } | Should -Throw
        }
    }

    Context 'URL Validation' {

        It 'Should accept HTTPS URL' {
            $result = Get-CCSADSid -ComputerName $env:COMPUTERNAME -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
            $result | Should -Not -BeNullOrEmpty
        }

        It 'Should reject HTTP URL (only HTTPS allowed)' {
            $httpUrl = $script:TestUrl -replace '^https:', 'http:'
            { Get-CCSADSid -ComputerName $env:COMPUTERNAME -Domain $script:TestDomain -Url $httpUrl -CCSCredential $script:TestCCSCredential -ErrorAction Stop } | Should -Throw
        }

        It 'Should reject URL without protocol' {
            { Get-CCSADSid -ComputerName $env:COMPUTERNAME -Domain $script:TestDomain -Url 'test.com/CCS.asmx' -CCSCredential $script:TestCCSCredential -ErrorAction Stop } | Should -Throw
        }
    }

    Context 'Domain Validation' {

        It 'Should accept valid domain format' {
            $result = Get-CCSADSid -ComputerName $env:COMPUTERNAME -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
            $result | Should -Not -BeNullOrEmpty
        }

        It 'Should accept subdomain format' {
            { Get-CCSADSid -ComputerName $env:COMPUTERNAME -Domain 'sub.firmax.local' -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
        }

        It 'Should reject invalid domain format' {
            { Get-CCSADSid -ComputerName $env:COMPUTERNAME -Domain 'invalid_domain' -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction Stop } | Should -Throw
        }
    }

    Context 'Live CCS Web Service Operations' {

        It 'Should connect to CCS Web Service successfully' {
            $result = Get-CCSADSid -ComputerName $env:COMPUTERNAME -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
            $result | Should -Not -BeNullOrEmpty
        }

        It 'Should retrieve SID for current computer' {
            $result = Get-CCSADSid -ComputerName $env:COMPUTERNAME -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
            $result | Should -Not -BeNullOrEmpty
            $result | Should -Match '^S-1-5-21-\d+-\d+-\d+-\d+$'
        }

        It 'Should retrieve SID with domain credentials' {
            $result = Get-CCSADSid -ComputerName $env:COMPUTERNAME -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
            $result | Should -Not -BeNullOrEmpty
            $result | Should -Match '^S-1-5-21-\d+-\d+-\d+-\d+$'
        }

        It 'Should process multiple computers' {
            $computers = @($env:COMPUTERNAME, 'PESTER-TEST-PC')
            $results = $computers | Get-CCSADSid -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
            $results | Should -Not -BeNullOrEmpty
        }

        It 'Should handle LDAP format for DomainOUPath' {
            $ldapPath = 'LDAP://DC01.Firmax.local/DC=Firmax,DC=local'
            { Get-CCSADSid -ComputerName $env:COMPUTERNAME -DomainOUPath $ldapPath -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
        }

        It 'Should retrieve SID from specific OU' {
            $ouPath = 'DC=Firmax,DC=local'
            $result = Get-CCSADSid -ComputerName $env:COMPUTERNAME -DomainOUPath $ouPath -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
            $result | Should -Not -BeNullOrEmpty
        }
    }

    Context 'Error Handling' {

        It 'Should handle non-existent computer gracefully' {
            $result = Get-CCSADSid -ComputerName 'NonExistentPC12345' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
            # Should either return error message or nothing
        }

        It 'Should handle invalid credentials gracefully' {
            $badCred = New-Object System.Management.Automation.PSCredential('baduser', (ConvertTo-SecureString 'badpass' -AsPlainText -Force))
            { Get-CCSADSid -ComputerName $env:COMPUTERNAME -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $badCred -ErrorAction Stop } | Should -Throw
        }

        It 'Should handle non-existent URL gracefully' {
            { Get-CCSADSid -ComputerName $env:COMPUTERNAME -Domain $script:TestDomain -Url 'https://nonexistent.invalid/CCS.asmx' -CCSCredential $script:TestCCSCredential -ErrorAction Stop } | Should -Throw
        }
    }
}

Describe 'Get-CCSADSid - Performance Tests' -Tag 'Performance' {

    Context 'Pipeline Performance' {

        It 'Should process pipeline input efficiently' {
            $computers = 1..10 | ForEach-Object { $env:COMPUTERNAME }
            $measure = Measure-Command {
                $computers | Get-CCSADSid -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WarningAction SilentlyContinue -ErrorAction SilentlyContinue
            }
            $measure.TotalSeconds | Should -BeLessThan 30
        }
    }
}
