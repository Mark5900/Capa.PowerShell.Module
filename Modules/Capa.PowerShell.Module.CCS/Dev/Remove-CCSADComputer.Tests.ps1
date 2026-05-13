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

Describe 'Remove-CCSADComputer' -Tag 'Unit' {

    Context 'Parameter Validation' {

        It 'Should have mandatory ComputerName parameter' {
            (Get-Command Remove-CCSADComputer).Parameters['ComputerName'].Attributes.Mandatory | Should -Be $true
        }

        It 'Should have optional DomainOUPath parameter' {
            (Get-Command Remove-CCSADComputer).Parameters['DomainOUPath'].Attributes.Mandatory | Should -Be $false
        }

        It 'Should have mandatory Domain parameter' {
            (Get-Command Remove-CCSADComputer).Parameters['Domain'].Attributes.Mandatory | Should -Be $true
        }

        It 'Should have mandatory Url parameter' {
            (Get-Command Remove-CCSADComputer).Parameters['Url'].Attributes.Mandatory | Should -Be $true
        }

        It 'Should have mandatory CCSCredential parameter' {
            (Get-Command Remove-CCSADComputer).Parameters['CCSCredential'].Attributes.Mandatory | Should -Be $true
        }

        It 'Should have optional DomainCredential parameter' {
            (Get-Command Remove-CCSADComputer).Parameters['DomainCredential'].Attributes.Mandatory | Should -Be $false
        }

        It 'Should have optional PasswordIsEncrypted parameter' {
            (Get-Command Remove-CCSADComputer).Parameters['PasswordIsEncrypted'].Attributes.Mandatory | Should -Be $false
        }

        It 'Should accept array of computer names' {
            (Get-Command Remove-CCSADComputer).Parameters['ComputerName'].ParameterType.Name | Should -Be 'String[]'
        }

        It 'Should accept pipeline input for ComputerName' {
            (Get-Command Remove-CCSADComputer).Parameters['ComputerName'].Attributes.ValueFromPipeline | Should -Be $true
        }
    }

    Context 'Parameter Aliases' {

        It 'Should have alias "Name" for ComputerName' {
            (Get-Command Remove-CCSADComputer).Parameters['ComputerName'].Aliases | Should -Contain 'Name'
        }

        It 'Should have alias "Computer" for ComputerName' {
            (Get-Command Remove-CCSADComputer).Parameters['ComputerName'].Aliases | Should -Contain 'Computer'
        }

        It 'Should have alias "OU" for DomainOUPath' {
            (Get-Command Remove-CCSADComputer).Parameters['DomainOUPath'].Aliases | Should -Contain 'OU'
        }
    }

    Context 'DomainOUPath Validation' {

        It 'Should accept empty DomainOUPath' {
            { Remove-CCSADComputer -ComputerName 'PC01' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath '' -WhatIf } | Should -Not -Throw
        }

        It 'Should accept standard DN format' {
            { Remove-CCSADComputer -ComputerName 'PC01' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'OU=Computers,DC=Firmax,DC=local' -WhatIf } | Should -Not -Throw
        }

        It 'Should accept DC-only format' {
            { Remove-CCSADComputer -ComputerName 'PC01' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'DC=Firmax,DC=local' -WhatIf } | Should -Not -Throw
        }

        It 'Should accept LDAP format' {
            { Remove-CCSADComputer -ComputerName 'PC01' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'LDAP://DC01.Firmax.local/OU=Computers,DC=Firmax,DC=local' -WhatIf } | Should -Not -Throw
        }

        It 'Should reject invalid format' {
            { Remove-CCSADComputer -ComputerName 'PC01' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'InvalidPath' -WhatIf } | Should -Throw
        }
    }

    Context 'URL Validation' {

        It 'Should accept HTTPS URL' {
            { Remove-CCSADComputer -ComputerName 'PC01' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Not -Throw
        }

        It 'Should reject HTTP URL (only HTTPS allowed)' {
            $httpUrl = $script:TestUrl -replace '^https:', 'http:'
            { Remove-CCSADComputer -ComputerName 'PC01' -Domain $script:TestDomain -Url $httpUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Throw
        }

        It 'Should reject URL without protocol' {
            { Remove-CCSADComputer -ComputerName 'PC01' -Domain $script:TestDomain -Url 'test.com/CCS.asmx' -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Throw
        }
    }

    Context 'Domain Validation' {

        It 'Should accept valid domain format' {
            { Remove-CCSADComputer -ComputerName 'PC01' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Not -Throw
        }

        It 'Should accept subdomain format' {
            { Remove-CCSADComputer -ComputerName 'PC01' -Domain 'sub.firmax.local' -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Not -Throw
        }

        It 'Should reject invalid domain format' {
            { Remove-CCSADComputer -ComputerName 'PC01' -Domain 'invalid_domain' -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Throw
        }
    }

    Context 'ShouldProcess Support' {

        It 'Should support WhatIf' {
            (Get-Command Remove-CCSADComputer).Parameters.ContainsKey('WhatIf') | Should -Be $true
        }

        It 'Should support Confirm' {
            (Get-Command Remove-CCSADComputer).Parameters.ContainsKey('Confirm') | Should -Be $true
        }
    }

    Context 'CmdletBinding Attributes' {

        It 'Should be an advanced function' {
            (Get-Command Remove-CCSADComputer).CmdletBinding | Should -Be $true
        }

        It 'Should have SupportsShouldProcess' {
            (Get-Command Remove-CCSADComputer).Parameters['WhatIf'] | Should -Not -BeNullOrEmpty
        }

        It 'Should have OutputType defined' {
            (Get-Command Remove-CCSADComputer).OutputType.Name | Should -Contain 'System.String'
        }
    }
}

Describe 'Remove-CCSADComputer - Integration Tests' -Tag 'Integration' {

    Context 'Live CCS Web Service Operations' {

        BeforeAll {
            $script:TestComputerName = 'PESTER-REMOVE-TEST-PC'
        }

        It 'Should connect to CCS Web Service successfully' {
            { Remove-CCSADComputer -ComputerName $script:TestComputerName -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Not -Throw
        }

        It 'Should handle non-existent computer gracefully' {
            { Remove-CCSADComputer -ComputerName $script:TestComputerName -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
        }

        It 'Should remove computer with domain credentials' {
            { Remove-CCSADComputer -ComputerName $script:TestComputerName -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
        }

        It 'Should process multiple computers' {
            $computers = @("$script:TestComputerName`1", "$script:TestComputerName`2")
            { $computers | Remove-CCSADComputer -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
        }

        It 'Should convert LDAP path format' {
            $ldapPath = 'LDAP://DC01.Firmax.local/DC=Firmax,DC=local'
            { Remove-CCSADComputer -ComputerName $script:TestComputerName -DomainOUPath $ldapPath -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
        }

        It 'Should work without DomainCredential (CCS context)' {
            { Remove-CCSADComputer -ComputerName $script:TestComputerName -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
        }
    }

    Context 'Error Handling' {

        It 'Should handle invalid credentials gracefully' {
            $badCred = New-Object System.Management.Automation.PSCredential('baduser', (ConvertTo-SecureString 'badpass' -AsPlainText -Force))
            { Remove-CCSADComputer -ComputerName 'TestPC' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $badCred -ErrorAction Stop } | Should -Throw
        }
    }
}

Describe 'Remove-CCSADComputer - Performance Tests' -Tag 'Performance' {

    Context 'Pipeline Performance' {

        It 'Should process pipeline input efficiently' {
            $computers = 1..10 | ForEach-Object { "PC$_" }
            $measure = Measure-Command {
                $computers | Remove-CCSADComputer -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf -WarningAction SilentlyContinue
            }
            $measure.TotalSeconds | Should -BeLessThan 5
        }
    }
}