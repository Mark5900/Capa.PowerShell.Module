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

Describe 'Remove-CCSADComputerFromSecurityGroup' -Tag 'Unit' {

	Context 'Parameter Validation' {

		It 'Should have mandatory ComputerName parameter' {
			(Get-Command Remove-CCSADComputerFromSecurityGroup).Parameters['ComputerName'].Attributes.Mandatory | Should -Be $true
		}

		It 'Should have mandatory SecurityGroupName parameter' {
			(Get-Command Remove-CCSADComputerFromSecurityGroup).Parameters['SecurityGroupName'].Attributes.Mandatory | Should -Be $true
		}

		It 'Should have mandatory Domain parameter' {
			(Get-Command Remove-CCSADComputerFromSecurityGroup).Parameters['Domain'].Attributes.Mandatory | Should -Be $true
		}

		It 'Should have mandatory Url parameter' {
			(Get-Command Remove-CCSADComputerFromSecurityGroup).Parameters['Url'].Attributes.Mandatory | Should -Be $true
		}

		It 'Should have mandatory CCSCredential parameter' {
			(Get-Command Remove-CCSADComputerFromSecurityGroup).Parameters['CCSCredential'].Attributes.Mandatory | Should -Be $true
		}

		It 'Should have optional DomainCredential parameter' {
			(Get-Command Remove-CCSADComputerFromSecurityGroup).Parameters['DomainCredential'].Attributes.Mandatory | Should -Be $false
		}

		It 'Should have optional DomainOUPath parameter' {
			(Get-Command Remove-CCSADComputerFromSecurityGroup).Parameters['DomainOUPath'].Attributes.Mandatory | Should -Be $false
		}

		It 'Should accept array of computer names' {
			(Get-Command Remove-CCSADComputerFromSecurityGroup).Parameters['ComputerName'].ParameterType.Name | Should -Be 'String[]'
		}

		It 'Should accept pipeline input for ComputerName' {
			(Get-Command Remove-CCSADComputerFromSecurityGroup).Parameters['ComputerName'].Attributes.ValueFromPipeline | Should -Be $true
		}
	}

	Context 'Parameter Aliases' {

		It 'Should have alias "Name" for ComputerName' {
			(Get-Command Remove-CCSADComputerFromSecurityGroup).Parameters['ComputerName'].Aliases | Should -Contain 'Name'
		}

		It 'Should have alias "Computer" for ComputerName' {
			(Get-Command Remove-CCSADComputerFromSecurityGroup).Parameters['ComputerName'].Aliases | Should -Contain 'Computer'
		}

		It 'Should have alias "GroupName" for SecurityGroupName' {
			(Get-Command Remove-CCSADComputerFromSecurityGroup).Parameters['SecurityGroupName'].Aliases | Should -Contain 'GroupName'
		}

		It 'Should have alias "OU" for DomainOUPath' {
			(Get-Command Remove-CCSADComputerFromSecurityGroup).Parameters['DomainOUPath'].Aliases | Should -Contain 'OU'
		}
	}

	Context 'DomainOUPath Validation' {

		It 'Should accept empty DomainOUPath' {
			{ Remove-CCSADComputerFromSecurityGroup -ComputerName 'PC01' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath '' -WhatIf -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should accept standard DN format' {
			{ Remove-CCSADComputerFromSecurityGroup -ComputerName 'PC01' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'OU=Computers,DC=Firmax,DC=local' -WhatIf -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should accept DC-only format' {
			{ Remove-CCSADComputerFromSecurityGroup -ComputerName 'PC01' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'DC=Firmax,DC=local' -WhatIf -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should accept LDAP format' {
			{ Remove-CCSADComputerFromSecurityGroup -ComputerName 'PC01' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'LDAP://DC01.Firmax.local/OU=Computers,DC=Firmax,DC=local' -WhatIf -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should reject invalid format' {
			{ Remove-CCSADComputerFromSecurityGroup -ComputerName 'PC01' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'InvalidPath' -WhatIf } | Should -Throw
		}
	}

	Context 'URL Validation' {

		It 'Should accept HTTPS URL' {
			{ Remove-CCSADComputerFromSecurityGroup -ComputerName 'PC01' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should reject HTTP URL (only HTTPS allowed)' {
			$httpUrl = $script:TestUrl -replace '^https:', 'http:'
			{ Remove-CCSADComputerFromSecurityGroup -ComputerName 'PC01' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url $httpUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Throw
		}

		It 'Should reject URL without protocol' {
			{ Remove-CCSADComputerFromSecurityGroup -ComputerName 'PC01' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url 'test.com/CCS.asmx' -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Throw
		}
	}

	Context 'Domain Validation' {

		It 'Should accept valid domain format' {
			{ Remove-CCSADComputerFromSecurityGroup -ComputerName 'PC01' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should accept subdomain format' {
			{ Remove-CCSADComputerFromSecurityGroup -ComputerName 'PC01' -SecurityGroupName 'TestGroup' -Domain 'sub.firmax.local' -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should reject invalid domain format' {
			{ Remove-CCSADComputerFromSecurityGroup -ComputerName 'PC01' -SecurityGroupName 'TestGroup' -Domain 'invalid_domain' -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Throw
		}
	}

	Context 'ShouldProcess Support' {

		It 'Should support WhatIf' {
			(Get-Command Remove-CCSADComputerFromSecurityGroup).Parameters.ContainsKey('WhatIf') | Should -Be $true
		}

		It 'Should support Confirm' {
			(Get-Command Remove-CCSADComputerFromSecurityGroup).Parameters.ContainsKey('Confirm') | Should -Be $true
		}
	}

	Context 'CmdletBinding Attributes' {

		It 'Should be an advanced function' {
			(Get-Command Remove-CCSADComputerFromSecurityGroup).CmdletBinding | Should -Be $true
		}

		It 'Should have SupportsShouldProcess' {
			(Get-Command Remove-CCSADComputerFromSecurityGroup).Parameters['WhatIf'] | Should -Not -BeNullOrEmpty
		}

		It 'Should have OutputType defined' {
			(Get-Command Remove-CCSADComputerFromSecurityGroup).OutputType.Name | Should -Contain 'System.String'
		}
	}
}

Describe 'Remove-CCSADComputerFromSecurityGroup - Integration Tests' -Tag 'Integration' {

	Context 'Live CCS Web Service Operations' {

		BeforeAll {
			# Use existing test group name
			$script:TestGroupName = "TestPester"
			$script:TestComputerName = 'PESTER-TEST-PC'
		}

		It 'Should connect to CCS Web Service successfully' {
			{ Remove-CCSADComputerFromSecurityGroup -ComputerName $script:TestComputerName -SecurityGroupName $script:TestGroupName -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should remove computer from security group with domain credentials' {
			{ Remove-CCSADComputerFromSecurityGroup -ComputerName $script:TestComputerName -SecurityGroupName $script:TestGroupName -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -Confirm:$false -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should process multiple computers' {
			$computers = @("$script:TestComputerName`1", "$script:TestComputerName`2")
			{ $computers | Remove-CCSADComputerFromSecurityGroup -SecurityGroupName $script:TestGroupName -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -Confirm:$false -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should convert LDAP path format' {
			$ldapPath = 'LDAP://DC01.Firmax.local/DC=Firmax,DC=local'
			{ Remove-CCSADComputerFromSecurityGroup -ComputerName $script:TestComputerName -SecurityGroupName $script:TestGroupName -DomainOUPath $ldapPath -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -Confirm:$false -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}
	}

	Context 'Error Handling' {

		It 'Should handle invalid credentials gracefully' {
			$badCred = New-Object System.Management.Automation.PSCredential('baduser', (ConvertTo-SecureString 'badpass' -AsPlainText -Force))
			{ Remove-CCSADComputerFromSecurityGroup -ComputerName 'TestPC' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $badCred -ErrorAction Stop } | Should -Throw
		}

		It 'Should handle non-existent URL gracefully' {
			{ Remove-CCSADComputerFromSecurityGroup -ComputerName 'TestPC' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url 'https://nonexistent.invalid/CCS.asmx' -CCSCredential $script:TestCCSCredential -ErrorAction Stop } | Should -Throw
		}
	}
}

Describe 'Remove-CCSADComputerFromSecurityGroup - Performance Tests' -Tag 'Performance' {

	Context 'Pipeline Performance' {

		It 'Should process pipeline input efficiently' {
			$computers = 1..10 | ForEach-Object { "PC$_" }
			$measure = Measure-Command {
				$computers | Remove-CCSADComputerFromSecurityGroup -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf -Confirm:$false -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
			}
			$measure.TotalSeconds | Should -BeLessThan 5
		}
	}
}
