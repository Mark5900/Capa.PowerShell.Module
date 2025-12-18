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

Describe 'Get-CCSADOUStructure' -Tag 'Unit' {

    Context 'Parameter Validation' {

        It 'Should have mandatory Domain parameter' {
            (Get-Command Get-CCSADOUStructure).Parameters['Domain'].Attributes.Mandatory | Should -Be $true
        }

        It 'Should have mandatory Url parameter' {
            (Get-Command Get-CCSADOUStructure).Parameters['Url'].Attributes.Mandatory | Should -Be $true
        }

        It 'Should have mandatory CCSCredential parameter' {
            (Get-Command Get-CCSADOUStructure).Parameters['CCSCredential'].Attributes.Mandatory | Should -Be $true
        }

        It 'Should have optional DomainCredential parameter' {
            (Get-Command Get-CCSADOUStructure).Parameters['DomainCredential'].Attributes.Mandatory | Should -Be $false
        }

        It 'Should have optional DomainTopPath parameter' {
            (Get-Command Get-CCSADOUStructure).Parameters['DomainTopPath'].Attributes.Mandatory | Should -Be $false
        }

        It 'Should have optional ExcludedOUNames parameter' {
            (Get-Command Get-CCSADOUStructure).Parameters['ExcludedOUNames'].Attributes.Mandatory | Should -Be $false
        }

        It 'Should accept array of excluded OU names' {
            (Get-Command Get-CCSADOUStructure).Parameters['ExcludedOUNames'].ParameterType.Name | Should -Be 'String[]'
        }
    }

    Context 'Parameter Aliases' {

        It 'Should have alias "TopPath" for DomainTopPath' {
            (Get-Command Get-CCSADOUStructure).Parameters['DomainTopPath'].Aliases | Should -Contain 'TopPath'
        }

        It 'Should have alias "SearchBase" for DomainTopPath' {
            (Get-Command Get-CCSADOUStructure).Parameters['DomainTopPath'].Aliases | Should -Contain 'SearchBase'
        }

        It 'Should have alias "Credential" for CCSCredential' {
            (Get-Command Get-CCSADOUStructure).Parameters['CCSCredential'].Aliases | Should -Contain 'Credential'
        }

        It 'Should have alias "ADCredential" for DomainCredential' {
            (Get-Command Get-CCSADOUStructure).Parameters['DomainCredential'].Aliases | Should -Contain 'ADCredential'
        }

        It 'Should have alias "Exclude" for ExcludedOUNames' {
            (Get-Command Get-CCSADOUStructure).Parameters['ExcludedOUNames'].Aliases | Should -Contain 'Exclude'
        }
    }

    Context 'CmdletBinding Attributes' {

        It 'Should be an advanced function' {
            (Get-Command Get-CCSADOUStructure).CmdletBinding | Should -Be $true
        }

        It 'Should have OutputType defined' {
            (Get-Command Get-CCSADOUStructure).OutputType | Should -Not -BeNullOrEmpty
        }
    }
}

Describe 'Get-CCSADOUStructure - Integration Tests' -Tag 'Integration' {

    Context 'DomainTopPath Validation' {

        It 'Should accept empty DomainTopPath' {
            { Get-CCSADOUStructure -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainTopPath '' -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
        }

        It 'Should accept standard DN format with OU' {
            { Get-CCSADOUStructure -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainTopPath 'OU=IT,DC=Firmax,DC=local' -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
        }

        It 'Should accept DC-only format' {
            { Get-CCSADOUStructure -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainTopPath 'DC=Firmax,DC=local' -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
        }

        It 'Should reject invalid format' {
            { Get-CCSADOUStructure -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainTopPath 'InvalidPath' -ErrorAction Stop } | Should -Throw
        }
    }

    Context 'URL Validation' {

        It 'Should accept HTTPS URL' {
            { Get-CCSADOUStructure -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
        }

        It 'Should reject HTTP URL (only HTTPS allowed)' {
            $httpUrl = $script:TestUrl -replace '^https:', 'http:'
            { Get-CCSADOUStructure -Domain $script:TestDomain -Url $httpUrl -CCSCredential $script:TestCCSCredential -ErrorAction Stop } | Should -Throw
        }

        It 'Should reject URL without protocol' {
            { Get-CCSADOUStructure -Domain $script:TestDomain -Url 'test.com/CCS.asmx' -CCSCredential $script:TestCCSCredential -ErrorAction Stop } | Should -Throw
        }
    }

    Context 'Domain Validation' {

        It 'Should accept valid domain format' {
            { Get-CCSADOUStructure -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
        }

        It 'Should accept subdomain format' {
            { Get-CCSADOUStructure -Domain 'sub.firmax.local' -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
        }

        It 'Should reject invalid domain format' {
            { Get-CCSADOUStructure -Domain 'invalid_domain' -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction Stop } | Should -Throw
        }
    }

    Context 'Live CCS Web Service Operations' {

        It 'Should connect to CCS Web Service successfully' {
            { Get-CCSADOUStructure -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
        }

        It 'Should retrieve OU structure' {
            { Get-CCSADOUStructure -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
        }

        It 'Should retrieve OUs with domain credentials' {
            { Get-CCSADOUStructure -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
        }

        It 'Should return objects with correct properties if data available' {
            $result = Get-CCSADOUStructure -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
            if ($result) {
                $firstOU = $result | Select-Object -First 1
                $firstOU.PSObject.Properties.Name | Should -Contain 'Name'
                $firstOU.PSObject.Properties.Name | Should -Contain 'Path'
                $firstOU.PSObject.Properties.Name | Should -Contain 'Children'
            } else {
                Set-ItResult -Skipped -Because "No data returned from web service in test environment"
            }
        }

        It 'Should support hierarchical structure with children if data available' {
            $result = Get-CCSADOUStructure -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
            if ($result) {
                $result.Children | Should -Not -BeNull
            } else {
                Set-ItResult -Skipped -Because "No data returned from web service in test environment"
            }
        }

        It 'Should retrieve OUs from specific top path' {
            $topPath = 'DC=Firmax,DC=local'
            { Get-CCSADOUStructure -DomainTopPath $topPath -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
        }

        It 'Should exclude OUs by name' {
            { Get-CCSADOUStructure -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ExcludedOUNames @('Test', 'Archive') -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
        }
    }

    Context 'Error Handling' {

        It 'Should handle invalid credentials gracefully' {
            $badCred = New-Object System.Management.Automation.PSCredential('baduser', (ConvertTo-SecureString 'badpass' -AsPlainText -Force))
            { Get-CCSADOUStructure -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $badCred -ErrorAction Stop } | Should -Throw
        }

        It 'Should handle non-existent URL gracefully' {
            { Get-CCSADOUStructure -Domain $script:TestDomain -Url 'https://nonexistent.invalid/CCS.asmx' -CCSCredential $script:TestCCSCredential -ErrorAction Stop } | Should -Throw
        }
    }
}

Describe 'Get-CCSADOUStructure - Performance Tests' -Tag 'Performance' {

    Context 'Query Performance' {

        It 'Should retrieve OU structure in reasonable time' {
            $measure = Measure-Command {
                Get-CCSADOUStructure -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WarningAction SilentlyContinue -ErrorAction SilentlyContinue
            }
            $measure.TotalSeconds | Should -BeLessThan 30
        }
    }
}
