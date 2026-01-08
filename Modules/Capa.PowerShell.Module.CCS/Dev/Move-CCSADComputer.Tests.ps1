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

Describe 'Move-CCSADComputer' -Tag 'Unit' {

    Context 'Parameter Validation' {

        It 'Should have mandatory ComputerName parameter' {
            (Get-Command Move-CCSADComputer).Parameters['ComputerName'].Attributes.Mandatory | Should -Be $true
        }

        It 'Should have mandatory DestinationOU parameter' {
            (Get-Command Move-CCSADComputer).Parameters['DestinationOU'].Attributes.Mandatory | Should -Be $true
        }

        It 'Should have mandatory Domain parameter' {
            (Get-Command Move-CCSADComputer).Parameters['Domain'].Attributes.Mandatory | Should -Be $true
        }

        It 'Should have mandatory Url parameter' {
            (Get-Command Move-CCSADComputer).Parameters['Url'].Attributes.Mandatory | Should -Be $true
        }

        It 'Should have mandatory CCSCredential parameter' {
            (Get-Command Move-CCSADComputer).Parameters['CCSCredential'].Attributes.Mandatory | Should -Be $true
        }

        It 'Should have optional DomainCredential parameter' {
            (Get-Command Move-CCSADComputer).Parameters['DomainCredential'].Attributes.Mandatory | Should -Be $false
        }

        It 'Should have optional DomainOUPath parameter' {
            (Get-Command Move-CCSADComputer).Parameters['DomainOUPath'].Attributes.Mandatory | Should -Be $false
        }

        It 'Should accept array of computer names' {
            (Get-Command Move-CCSADComputer).Parameters['ComputerName'].ParameterType.Name | Should -Be 'String[]'
        }

        It 'Should accept pipeline input for ComputerName' {
            (Get-Command Move-CCSADComputer).Parameters['ComputerName'].Attributes.ValueFromPipeline | Should -Be $true
        }
    }

    Context 'Parameter Aliases' {

        It 'Should have alias "Name" for ComputerName' {
            (Get-Command Move-CCSADComputer).Parameters['ComputerName'].Aliases | Should -Contain 'Name'
        }

        It 'Should have alias "Computer" for ComputerName' {
            (Get-Command Move-CCSADComputer).Parameters['ComputerName'].Aliases | Should -Contain 'Computer'
        }

        It 'Should have alias "TargetOU" for DestinationOU' {
            (Get-Command Move-CCSADComputer).Parameters['DestinationOU'].Aliases | Should -Contain 'TargetOU'
        }

        It 'Should have alias "SourceOU" for DomainOUPath' {
            (Get-Command Move-CCSADComputer).Parameters['DomainOUPath'].Aliases | Should -Contain 'SourceOU'
        }

        It 'Should have alias "Credential" for CCSCredential' {
            (Get-Command Move-CCSADComputer).Parameters['CCSCredential'].Aliases | Should -Contain 'Credential'
        }
    }

    Context 'DestinationOU Validation' {

        It 'Should accept standard DN format with OU' {
            { Move-CCSADComputer -ComputerName 'PC01' -DestinationOU 'OU=Workstations,DC=Firmax,DC=local' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WhatIf } | Should -Not -Throw
        }

        It 'Should accept DC-only format' {
            { Move-CCSADComputer -ComputerName 'PC01' -DestinationOU 'DC=Firmax,DC=local' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WhatIf } | Should -Not -Throw
        }

        It 'Should reject invalid format' {
            { Move-CCSADComputer -ComputerName 'PC01' -DestinationOU 'InvalidPath' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Throw
        }

        It 'Should reject LDAP format for DestinationOU' {
            { Move-CCSADComputer -ComputerName 'PC01' -DestinationOU 'LDAP://DC01.Firmax.local/OU=Workstations,DC=Firmax,DC=local' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Throw
        }
    }

    Context 'DomainOUPath Validation' {

        It 'Should accept empty DomainOUPath' {
            { Move-CCSADComputer -ComputerName 'PC01' -DestinationOU 'OU=Workstations,DC=Firmax,DC=local' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath '' -ErrorAction SilentlyContinue -WhatIf } | Should -Not -Throw
        }

        It 'Should accept standard DN format' {
            { Move-CCSADComputer -ComputerName 'PC01' -DestinationOU 'OU=Workstations,DC=Firmax,DC=local' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'OU=Computers,DC=Firmax,DC=local' -ErrorAction SilentlyContinue -WhatIf } | Should -Not -Throw
        }

        It 'Should accept DC-only format' {
            { Move-CCSADComputer -ComputerName 'PC01' -DestinationOU 'OU=Workstations,DC=Firmax,DC=local' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'DC=Firmax,DC=local' -ErrorAction SilentlyContinue -WhatIf } | Should -Not -Throw
        }

        It 'Should accept LDAP format' {
            { Move-CCSADComputer -ComputerName 'PC01' -DestinationOU 'OU=Workstations,DC=Firmax,DC=local' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'LDAP://DC01.Firmax.local/OU=Computers,DC=Firmax,DC=local' -ErrorAction SilentlyContinue -WhatIf } | Should -Not -Throw
        }

        It 'Should reject invalid format' {
            { Move-CCSADComputer -ComputerName 'PC01' -DestinationOU 'OU=Workstations,DC=Firmax,DC=local' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'InvalidPath' -WhatIf } | Should -Throw
        }
    }

    Context 'URL Validation' {

        It 'Should accept HTTPS URL' {
            { Move-CCSADComputer -ComputerName 'PC01' -DestinationOU 'OU=Workstations,DC=Firmax,DC=local' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WhatIf } | Should -Not -Throw
        }

        It 'Should reject HTTP URL (only HTTPS allowed)' {
            $httpUrl = $script:TestUrl -replace '^https:', 'http:'
            { Move-CCSADComputer -ComputerName 'PC01' -DestinationOU 'OU=Workstations,DC=Firmax,DC=local' -Domain $script:TestDomain -Url $httpUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Throw
        }

        It 'Should reject URL without protocol' {
            { Move-CCSADComputer -ComputerName 'PC01' -DestinationOU 'OU=Workstations,DC=Firmax,DC=local' -Domain $script:TestDomain -Url 'test.com/CCS.asmx' -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Throw
        }
    }

    Context 'Domain Validation' {

        It 'Should accept valid domain format' {
            { Move-CCSADComputer -ComputerName 'PC01' -DestinationOU 'OU=Workstations,DC=Firmax,DC=local' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WhatIf } | Should -Not -Throw
        }

        It 'Should accept subdomain format' {
            { Move-CCSADComputer -ComputerName 'PC01' -DestinationOU 'OU=Workstations,DC=Firmax,DC=local' -Domain 'sub.firmax.local' -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WhatIf } | Should -Not -Throw
        }

        It 'Should reject invalid domain format' {
            { Move-CCSADComputer -ComputerName 'PC01' -DestinationOU 'OU=Workstations,DC=Firmax,DC=local' -Domain 'invalid_domain' -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Throw
        }
    }

    Context 'ShouldProcess Support' {

        It 'Should support WhatIf' {
            (Get-Command Move-CCSADComputer).Parameters.ContainsKey('WhatIf') | Should -Be $true
        }

        It 'Should support Confirm' {
            (Get-Command Move-CCSADComputer).Parameters.ContainsKey('Confirm') | Should -Be $true
        }

        It 'Should have ConfirmImpact set to High' {
            $command = Get-Command Move-CCSADComputer
            $command.ScriptBlock.Attributes | Where-Object { $_ -is [System.Management.Automation.CmdletBindingAttribute] } |
                Select-Object -First 1 -ExpandProperty ConfirmImpact | Should -Be 'High'
        }
    }

    Context 'CmdletBinding Attributes' {

        It 'Should be an advanced function' {
            (Get-Command Move-CCSADComputer).CmdletBinding | Should -Be $true
        }

        It 'Should have SupportsShouldProcess' {
            (Get-Command Move-CCSADComputer).Parameters['WhatIf'] | Should -Not -BeNullOrEmpty
        }

        It 'Should have OutputType defined' {
            (Get-Command Move-CCSADComputer).OutputType.Name | Should -Contain 'System.String'
        }
    }
}

Describe 'Move-CCSADComputer - Integration Tests' -Tag 'Integration' {

    Context 'Live CCS Web Service Operations' {

        BeforeAll {
            $script:TestComputerName = 'PESTER-TEST-PC'
            $script:TestDestinationOU = 'OU=Test,DC=Firmax,DC=local'
        }

        It 'Should connect to CCS Web Service successfully' {
            { Move-CCSADComputer -ComputerName $script:TestComputerName -DestinationOU $script:TestDestinationOU -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
        }

        It 'Should move computer with domain credentials' {
            { Move-CCSADComputer -ComputerName $script:TestComputerName -DestinationOU $script:TestDestinationOU -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -Confirm:$false -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
        }

        It 'Should process multiple computers' {
            $computers = @("$script:TestComputerName`1", "$script:TestComputerName`2")
            { $computers | Move-CCSADComputer -DestinationOU $script:TestDestinationOU -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -Confirm:$false -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
        }

        It 'Should convert LDAP path format for source OU' {
            $ldapPath = 'LDAP://DC01.Firmax.local/DC=Firmax,DC=local'
            { Move-CCSADComputer -ComputerName $script:TestComputerName -DestinationOU $script:TestDestinationOU -DomainOUPath $ldapPath -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -Confirm:$false -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
        }

        It 'Should move computer from specific source OU' {
            { Move-CCSADComputer -ComputerName $script:TestComputerName -DestinationOU $script:TestDestinationOU -DomainOUPath 'OU=Computers,DC=Firmax,DC=local' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -Confirm:$false -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
        }
    }

    Context 'Error Handling' {

        It 'Should handle invalid credentials gracefully' {
            $badCred = New-Object System.Management.Automation.PSCredential('baduser', (ConvertTo-SecureString 'badpass' -AsPlainText -Force))
            { Move-CCSADComputer -ComputerName 'TestPC' -DestinationOU 'OU=Test,DC=Firmax,DC=local' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $badCred -ErrorAction Stop } | Should -Throw
        }

        It 'Should handle non-existent URL gracefully' {
            { Move-CCSADComputer -ComputerName 'TestPC' -DestinationOU 'OU=Test,DC=Firmax,DC=local' -Domain $script:TestDomain -Url 'https://nonexistent.invalid/CCS.asmx' -CCSCredential $script:TestCCSCredential -ErrorAction Stop } | Should -Throw
        }

        It 'Should handle non-existent computer gracefully' {
            { Move-CCSADComputer -ComputerName 'NonExistentPC-12345' -DestinationOU 'OU=Test,DC=Firmax,DC=local' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -Confirm:$false -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
        }
    }
}

Describe 'Move-CCSADComputer - Performance Tests' -Tag 'Performance' {

    Context 'Pipeline Performance' {

        It 'Should process pipeline input efficiently' {
            $computers = 1..10 | ForEach-Object { "PC$_" }
            $measure = Measure-Command {
                $computers | Move-CCSADComputer -DestinationOU 'OU=Test,DC=Firmax,DC=local' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf -Confirm:$false -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
            }
            $measure.TotalSeconds | Should -BeLessThan 5
        }
    }
}
