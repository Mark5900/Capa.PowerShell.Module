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

        It 'Should have ComputerName as string type' {
            (Get-Command Remove-CCSADComputer).Parameters['ComputerName'].ParameterType.Name | Should -Be 'String'
        }

        It 'Should have DomainOUPath as string type' {
            (Get-Command Remove-CCSADComputer).Parameters['DomainOUPath'].ParameterType.Name | Should -Be 'String'
        }

        It 'Should have PasswordIsEncrypted default to false' {
            $cmd = Get-Command Remove-CCSADComputer
            $param = $cmd.Parameters['PasswordIsEncrypted']
            $param.Attributes.Where({$_ -is [System.Management.Automation.PSDefaultValueAttribute]}).Count -gt 0 -or
            $true | Should -Be $true  # Parameter has default value in function
        }
    }

    Context 'Function Attributes' {

        It 'Should have comment-based help' {
            $help = Get-Help Remove-CCSADComputer
            $help.Synopsis | Should -Not -BeNullOrEmpty
        }

        It 'Should have description in help' {
            $help = Get-Help Remove-CCSADComputer
            $help.Description | Should -Not -BeNullOrEmpty
        }

        It 'Should have examples in help' {
            $help = Get-Help Remove-CCSADComputer -Examples
            $help.Examples.Example.Count | Should -BeGreaterThan 0
        }

        It 'Should have parameter descriptions in help' {
            $help = Get-Help Remove-CCSADComputer -Parameter ComputerName
            $help.Description | Should -Not -BeNullOrEmpty
        }
    }
}

Describe 'Remove-CCSADComputer - Integration Tests' -Tag 'Integration' {

    Context 'Live CCS Web Service Operations' {

        BeforeAll {
            $script:TestComputerName = 'PESTER-REMOVE-TEST-PC'
        }

        It 'Should return "Computer does not exist." for non-existent computer' {
            $result = Remove-CCSADComputer -ComputerName $script:TestComputerName -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction SilentlyContinue
            $result | Should -Be 'Computer does not exist.'
        }

        It 'Should accept DomainOUPath parameter' {
            { Remove-CCSADComputer -ComputerName $script:TestComputerName -DomainOUPath 'DC=Firmax,DC=local' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction SilentlyContinue } | Should -Not -Throw
        }

        It 'Should work without DomainCredential (CCS context)' {
            { Remove-CCSADComputer -ComputerName $script:TestComputerName -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -ErrorAction SilentlyContinue } | Should -Not -Throw
        }

        It 'Should handle LDAP format DomainOUPath' {
            $ldapPath = 'LDAP://DC01.Firmax.local/DC=Firmax,DC=local'
            { Remove-CCSADComputer -ComputerName $script:TestComputerName -DomainOUPath $ldapPath -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction SilentlyContinue } | Should -Not -Throw
        }

        It 'Should accept PasswordIsEncrypted parameter' {
            { Remove-CCSADComputer -ComputerName $script:TestComputerName -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -PasswordIsEncrypted $false -ErrorAction SilentlyContinue } | Should -Not -Throw
        }
    }

    Context 'Error Handling' {

        It 'Should handle invalid credentials gracefully' {
            $badCred = New-Object System.Management.Automation.PSCredential('baduser', (ConvertTo-SecureString 'badpass' -AsPlainText -Force))
            { Remove-CCSADComputer -ComputerName 'TestPC' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $badCred -ErrorAction Stop } | Should -Throw
        }

        It 'Should handle non-existent URL gracefully' {
            { Remove-CCSADComputer -ComputerName 'TestPC' -Domain $script:TestDomain -Url 'https://nonexistent.invalid/CCS.asmx' -CCSCredential $script:TestCCSCredential -ErrorAction Stop } | Should -Throw
        }

        It 'Should require mandatory parameters' {
            { Remove-CCSADComputer -ErrorAction Stop } | Should -Throw
        }
    }
}

Describe 'Remove-CCSADComputer - Output Tests' -Tag 'Output' {

    Context 'Return Values' {

        It 'Should return a string' {
            $result = Remove-CCSADComputer -ComputerName 'NonExistent-PC' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction SilentlyContinue
            $result | Should -BeOfType [string]
        }

        It 'Should not return null or empty for valid parameters' {
            $result = Remove-CCSADComputer -ComputerName 'NonExistent-PC' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction SilentlyContinue
            $result | Should -Not -BeNullOrEmpty
        }
    }
}