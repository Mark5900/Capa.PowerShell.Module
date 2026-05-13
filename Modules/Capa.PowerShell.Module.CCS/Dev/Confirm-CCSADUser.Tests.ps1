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

    # Create invalid credentials for testing
    $invalidPassword = ConvertTo-SecureString 'InvalidPassword123!' -AsPlainText -Force
    $script:InvalidDomainCredential = New-Object System.Management.Automation.PSCredential('InvalidUser', $invalidPassword)

    $DebugPreference = 'Continue'
    $ErrorActionPreference = 'Stop'
}

Describe 'Confirm-CCSADUser' -Tag 'Unit' {

    Context 'Parameter Validation' {

        It 'Should have mandatory DomainCredential parameter' {
            (Get-Command Confirm-CCSADUser).Parameters['DomainCredential'].Attributes.Mandatory | Should -Be $true
        }

        It 'Should have mandatory Domain parameter' {
            (Get-Command Confirm-CCSADUser).Parameters['Domain'].Attributes.Mandatory | Should -Be $true
        }

        It 'Should have mandatory Url parameter' {
            (Get-Command Confirm-CCSADUser).Parameters['Url'].Attributes.Mandatory | Should -Be $true
        }

        It 'Should have mandatory CCSCredential parameter' {
            (Get-Command Confirm-CCSADUser).Parameters['CCSCredential'].Attributes.Mandatory | Should -Be $true
        }

        It 'Should have optional DomainOUPath parameter' {
            (Get-Command Confirm-CCSADUser).Parameters['DomainOUPath'].Attributes.Mandatory | Should -Be $false
        }

        It 'Should have optional PasswordIsEncrypted parameter' {
            (Get-Command Confirm-CCSADUser).Parameters['PasswordIsEncrypted'].Attributes.Mandatory | Should -Be $false
        }

        It 'Should have optional UsePrincipalContext parameter' {
            (Get-Command Confirm-CCSADUser).Parameters['UsePrincipalContext'].Attributes.Mandatory | Should -Be $false
        }

        It 'Should accept pipeline input for DomainCredential' {
            (Get-Command Confirm-CCSADUser).Parameters['DomainCredential'].Attributes.ValueFromPipeline | Should -Be $true
        }

        It 'Should have PSCredential type for DomainCredential' {
            (Get-Command Confirm-CCSADUser).Parameters['DomainCredential'].ParameterType.Name | Should -Be 'PSCredential'
        }

        It 'Should have PSCredential type for CCSCredential' {
            (Get-Command Confirm-CCSADUser).Parameters['CCSCredential'].ParameterType.Name | Should -Be 'PSCredential'
        }
    }

	Context 'Function Attributes' {

		It 'Should have alias "Validate-CCSADUser" for function' {
			$Command = Get-Command Confirm-CCSADUser
			$Command.Name | Should -Be 'Confirm-CCSADUser'
		}
	}

	Context 'CmdletBinding Attributes' {

		It 'Should be an advanced function' {
			(Get-Command Confirm-CCSADUser).CmdletBinding | Should -Be $true
		}

		It 'Should NOT have SupportsShouldProcess (read-only operation)' {
			(Get-Command Confirm-CCSADUser).Parameters['WhatIf'] | Should -BeNullOrEmpty
		}

		It 'Should have OutputType attribute' {
			$Command = Get-Command Confirm-CCSADUser
			$Command.OutputType | Should -Not -BeNullOrEmpty
		}
	}

	Context 'Switch Parameters' {

		It 'Should have PasswordIsEncrypted as switch parameter' {
			(Get-Command Confirm-CCSADUser).Parameters['PasswordIsEncrypted'].ParameterType.Name | Should -Be 'SwitchParameter'
		}

		It 'Should have UsePrincipalContext as switch parameter' {
			(Get-Command Confirm-CCSADUser).Parameters['UsePrincipalContext'].ParameterType.Name | Should -Be 'SwitchParameter'
		}
	}
}
