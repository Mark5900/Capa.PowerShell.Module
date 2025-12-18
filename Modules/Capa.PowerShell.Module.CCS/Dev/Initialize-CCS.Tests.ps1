BeforeAll {
	$RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

	$Items = Get-ChildItem -Path "$RootPath\Capa.PowerShell.Module.CCS\Dev\" -Filter '*.ps1' | Where-Object { $_.Name -notlike '*Tests.ps1' }
	foreach ($Item in $Items) {
		Import-Module $Item.FullName -Force -ErrorAction Stop
	}

	# Setup test environment
	$script:TestUrl = "https://$(hostname).capainstaller.com/CCSWebservice/CCS.asmx"
	$script:TestUrlHttp = "http://$(hostname).capainstaller.com/CCSWebservice/CCS.asmx"
	$CredentialPath = "D:\PowerShell\Credentials\$($env:USERNAME)DomainAdminPesterTests.xml"

	# Setup credentials from environment variables (GitHub secrets)
	if ($env:DOMAINADMINUSERNAME -and $env:DOMAINADMINPASSWORD) {
		$securePassword = ConvertTo-SecureString $env:DOMAINADMINPASSWORD -AsPlainText -Force
		$script:TestCredential = New-Object System.Management.Automation.PSCredential($env:DOMAINADMINUSERNAME, $securePassword)
	} elseif (Test-Path -Path $CredentialPath) {
		$script:TestCredential = Import-Clixml -Path $CredentialPath
	} else {
		$script:TestCredential = Get-Credential -Message 'Enter domain admin credentials for integration tests'
	}

	$DebugPreference = 'Continue'
	$ErrorActionPreference = 'Stop'
}

Describe 'Initialize-CCS' -Tag 'Unit' {

	Context 'Parameter Validation' {
		It 'Should have mandatory Url parameter' {
			(Get-Command Initialize-CCS).Parameters['Url'].Attributes.Mandatory | Should -Be $true
		}
		It 'Should have mandatory WebServiceCredential parameter' {
			(Get-Command Initialize-CCS).Parameters['WebServiceCredential'].Attributes.Mandatory | Should -Be $true
		}
	}

	Context 'Parameter Aliases' {
		It 'Should have alias "Uri" for Url' {
			(Get-Command Initialize-CCS).Parameters['Url'].Aliases | Should -Contain 'Uri'
		}
		It 'Should have alias "WebServiceUrl" for Url' {
			(Get-Command Initialize-CCS).Parameters['Url'].Aliases | Should -Contain 'WebServiceUrl'
		}
		It 'Should have alias "Credential" for WebServiceCredential' {
			(Get-Command Initialize-CCS).Parameters['WebServiceCredential'].Aliases | Should -Contain 'Credential'
		}
		It 'Should have alias "Cred" for WebServiceCredential' {
			(Get-Command Initialize-CCS).Parameters['WebServiceCredential'].Aliases | Should -Contain 'Cred'
		}
	}

	Context 'URL Validation' {
		It 'Should accept HTTPS URL' {
			{ Initialize-CCS -Url $script:TestUrl -WebServiceCredential $script:TestCredential -ErrorAction Stop } | Should -Not -Throw
		}
		It 'Should reject HTTP URL (only HTTPS allowed)' {
			{ Initialize-CCS -Url $script:TestUrlHttp -WebServiceCredential $script:TestCredential } | Should -Throw
		}
		It 'Should reject URL without protocol' {
			{ Initialize-CCS -Url 'test.com/CCS.asmx' -WebServiceCredential $script:TestCredential } | Should -Throw
		}
		It 'Should throw if Url is empty' {
			{ Initialize-CCS -Url '' -WebServiceCredential $script:TestCredential } | Should -Throw
		}
	}

	Context 'Input Validation' {
		It 'Should throw if Url is missing' {
			{ Initialize-CCS -WebServiceCredential $script:TestCredential } | Should -Throw
		}
		It 'Should throw if WebServiceCredential is missing' {
			{ Initialize-CCS -Url $script:TestUrl } | Should -Throw
		}
		It 'Should throw if Credential is not PSCredential' {
			{ Initialize-CCS -Url $script:TestUrl -WebServiceCredential 'notacred' } | Should -Throw
		}
	}

	Context 'ShouldProcess & CmdletBinding' {
		It 'Should be an advanced function' {
			(Get-Command Initialize-CCS).CmdletBinding | Should -Be $true
		}
		It 'Should not support WhatIf' {
			(Get-Command Initialize-CCS).Parameters.ContainsKey('WhatIf') | Should -Be $false
		}
		It 'Should not support Confirm' {
			(Get-Command Initialize-CCS).Parameters.ContainsKey('Confirm') | Should -Be $false
		}
		It 'Should have OutputType defined' {
			(Get-Command Initialize-CCS).OutputType.Name | Should -Contain 'CapaProxy.CCSSoapClient'
		}
	}
}

Describe 'Initialize-CCS - Integration Tests' -Tag 'Integration' {

	Context 'Live CCS Web Service Operations' {
		It 'Should connect to CCS Web Service successfully' {
			$client = Initialize-CCS -Url $script:TestUrl -WebServiceCredential $script:TestCredential -ErrorAction Stop
			$client | Should -Not -BeNullOrEmpty
		}
		It 'Should return a CapaProxy.CCSSoapClient object for valid input' {
			$client = Initialize-CCS -Url $script:TestUrl -WebServiceCredential $script:TestCredential
			$client | Should -BeOfType CapaProxy.CCSSoapClient
		}
		It 'Should set client credentials correctly' {
			$client = Initialize-CCS -Url $script:TestUrl -WebServiceCredential $script:TestCredential
			$client.ClientCredentials.UserName.UserName | Should -Be $script:TestCredential.UserName
		}
	}

	Context 'Error Handling' {
		It 'Should throw if DLL is missing' {
			$dllPath = Join-Path (Split-Path $PSCommandPath -Parent) 'Dependencies' 'CCSProxy.dll'
			if (Test-Path $dllPath) {
				Rename-Item $dllPath ($dllPath + '.bak')
			}
			try {
				{ Initialize-CCS -Url $script:TestUrl -WebServiceCredential $script:TestCredential -ErrorAction Stop } | Should -Throw
			} finally {
				if (Test-Path ($dllPath + '.bak')) {
					Rename-Item ($dllPath + '.bak') $dllPath
				}
			}
		}
	}
}

Describe 'Initialize-CCS - Performance Tests' -Tag 'Performance' {

	Context 'Initialization Performance' {
		It 'Should initialize client in under 3 seconds' {
			$measure = Measure-Command {
				$client = Initialize-CCS -Url $script:TestUrl -WebServiceCredential $script:TestCredential
			}
			$measure.TotalSeconds | Should -BeLessThan 3
		}
	}
}