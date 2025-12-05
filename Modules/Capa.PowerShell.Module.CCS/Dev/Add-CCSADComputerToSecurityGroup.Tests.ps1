BeforeAll {
    $RootPath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

    $Items = Get-ChildItem -Path "$RootPath\Capa.PowerShell.Module.CCS\Dev\" -Filter "*.ps1" | Where-Object { $_.Name -notlike "*Tests.ps1" }
    foreach ($Item in $Items) {
        . $Item.FullName
    }

	# Setup test environment
	$script:TestUrl = "https://$(hostname).capainstaller.com/CCSWebservice/CCS.asmx"
	$script:TestDomain = 'Firmax.local'

	# Setup credentials from environment variables (GitHub secrets)
	if ($env:DOMAINADMINUSERNAME -and $env:DOMAINADMINPASSWORD) {
		$securePassword = ConvertTo-SecureString $env:DOMAINADMINPASSWORD -AsPlainText -Force
		$script:TestDomainCredential = New-Object System.Management.Automation.PSCredential($env:DOMAINADMINUSERNAME, $securePassword)
		$script:TestCCSCredential = $script:TestDomainCredential
	} else {
		Write-Warning "Domain admin credentials not found in environment variables. Integration tests will be skipped."
		$script:TestDomainCredential = $null
		$script:TestCCSCredential = $null
	}

	# Mock objects for unit tests
	$script:MockCCS = [PSCustomObject]@{
		ActiveDirectory_AddComputerToSecurityGroup = {
			param($Computer, $Group, $OU, $Domain, $User, $Pass)
			return "Success: Computer '$Computer' added to group '$Group'"
		}
	}
}

Describe 'Add-CCSADComputerToSecurityGroup' -Tag 'Unit' {

	Context 'Parameter Validation' {

		It 'Should have mandatory ComputerName parameter' {
			(Get-Command Add-CCSADComputerToSecurityGroup).Parameters['ComputerName'].Attributes.Mandatory | Should -Be $true
		}

		It 'Should have mandatory SecurityGroupName parameter' {
			(Get-Command Add-CCSADComputerToSecurityGroup).Parameters['SecurityGroupName'].Attributes.Mandatory | Should -Be $true
		}

		It 'Should have mandatory Domain parameter' {
			(Get-Command Add-CCSADComputerToSecurityGroup).Parameters['Domain'].Attributes.Mandatory | Should -Be $true
		}

		It 'Should have mandatory Url parameter' {
			(Get-Command Add-CCSADComputerToSecurityGroup).Parameters['Url'].Attributes.Mandatory | Should -Be $true
		}

		It 'Should have mandatory CCSCredential parameter' {
			(Get-Command Add-CCSADComputerToSecurityGroup).Parameters['CCSCredential'].Attributes.Mandatory | Should -Be $true
		}

		It 'Should have optional DomainCredential parameter' {
			(Get-Command Add-CCSADComputerToSecurityGroup).Parameters['DomainCredential'].Attributes.Mandatory | Should -Be $false
		}

		It 'Should have optional DomainOUPath parameter' {
			(Get-Command Add-CCSADComputerToSecurityGroup).Parameters['DomainOUPath'].Attributes.Mandatory | Should -Be $false
		}

		It 'Should accept array of computer names' {
			(Get-Command Add-CCSADComputerToSecurityGroup).Parameters['ComputerName'].ParameterType.Name | Should -Be 'String[]'
		}

		It 'Should accept pipeline input for ComputerName' {
			(Get-Command Add-CCSADComputerToSecurityGroup).Parameters['ComputerName'].Attributes.ValueFromPipeline | Should -Be $true
		}
	}

	Context 'Parameter Aliases' {

		It 'Should have alias "Name" for ComputerName' {
			(Get-Command Add-CCSADComputerToSecurityGroup).Parameters['ComputerName'].Aliases | Should -Contain 'Name'
		}

		It 'Should have alias "Computer" for ComputerName' {
			(Get-Command Add-CCSADComputerToSecurityGroup).Parameters['ComputerName'].Aliases | Should -Contain 'Computer'
		}

		It 'Should have alias "GroupName" for SecurityGroupName' {
			(Get-Command Add-CCSADComputerToSecurityGroup).Parameters['SecurityGroupName'].Aliases | Should -Contain 'GroupName'
		}

		It 'Should have alias "OU" for DomainOUPath' {
			(Get-Command Add-CCSADComputerToSecurityGroup).Parameters['DomainOUPath'].Aliases | Should -Contain 'OU'
		}
	}

	Context 'DomainOUPath Validation' {

		BeforeAll {
			Mock Initialize-CCS { return $script:MockCCS }
			Mock Get-CCSEncryptedPassword { return 'EncryptedPassword' }
			Mock Invoke-CCSIsError { return $false }

			$TestCred = New-Object System.Management.Automation.PSCredential('testuser', (ConvertTo-SecureString 'testpass' -AsPlainText -Force))
		}

		It 'Should accept empty DomainOUPath' {
			{ Add-CCSADComputerToSecurityGroup -ComputerName 'PC01' -SecurityGroupName 'TestGroup' -Domain 'example.com' -Url $script:TestUrl -CCSCredential $TestCred -DomainOUPath '' -WhatIf } | Should -Not -Throw
		}

		It 'Should accept standard DN format' {
			{ Add-CCSADComputerToSecurityGroup -ComputerName 'PC01' -SecurityGroupName 'TestGroup' -Domain 'example.com' -Url $script:TestUrl -CCSCredential $TestCred -DomainOUPath 'OU=Computers,DC=example,DC=com' -WhatIf } | Should -Not -Throw
		}

		It 'Should accept DC-only format' {
			{ Add-CCSADComputerToSecurityGroup -ComputerName 'PC01' -SecurityGroupName 'TestGroup' -Domain 'example.com' -Url $script:TestUrl -CCSCredential $TestCred -DomainOUPath 'DC=example,DC=com' -WhatIf } | Should -Not -Throw
		}

		It 'Should accept LDAP format' {
			{ Add-CCSADComputerToSecurityGroup -ComputerName 'PC01' -SecurityGroupName 'TestGroup' -Domain 'example.com' -Url $script:TestUrl -CCSCredential $TestCred -DomainOUPath 'LDAP://DC01.example.com/OU=Computers,DC=example,DC=com' -WhatIf } | Should -Not -Throw
		}

		It 'Should reject invalid format' {
			{ Add-CCSADComputerToSecurityGroup -ComputerName 'PC01' -SecurityGroupName 'TestGroup' -Domain 'example.com' -Url $script:TestUrl -CCSCredential $TestCred -DomainOUPath 'InvalidPath' -WhatIf } | Should -Throw
		}
	}

	Context 'URL Validation' {

		BeforeAll {
			Mock Initialize-CCS { return $script:MockCCS }
			$TestCred = New-Object System.Management.Automation.PSCredential('testuser', (ConvertTo-SecureString 'testpass' -AsPlainText -Force))
		}

		It 'Should accept HTTPS URL' {
			{ Add-CCSADComputerToSecurityGroup -ComputerName 'PC01' -SecurityGroupName 'TestGroup' -Domain 'example.com' -Url $script:TestUrl -CCSCredential $TestCred -WhatIf } | Should -Not -Throw
		}

		It 'Should accept HTTP URL' {
			$httpUrl = $script:TestUrl -replace '^https:', 'http:'
			{ Add-CCSADComputerToSecurityGroup -ComputerName 'PC01' -SecurityGroupName 'TestGroup' -Domain 'example.com' -Url $httpUrl -CCSCredential $TestCred -WhatIf } | Should -Not -Throw
		}

		It 'Should reject URL without protocol' {
			{ Add-CCSADComputerToSecurityGroup -ComputerName 'PC01' -SecurityGroupName 'TestGroup' -Domain 'example.com' -Url 'test.com/CCS.asmx' -CCSCredential $TestCred -WhatIf } | Should -Throw
		}
	}

	Context 'Domain Validation' {

		BeforeAll {
			Mock Initialize-CCS { return $script:MockCCS }
			$TestCred = New-Object System.Management.Automation.PSCredential('testuser', (ConvertTo-SecureString 'testpass' -AsPlainText -Force))
		}

		It 'Should accept valid domain format' {
			{ Add-CCSADComputerToSecurityGroup -ComputerName 'PC01' -SecurityGroupName 'TestGroup' -Domain 'example.com' -Url $script:TestUrl -CCSCredential $TestCred -WhatIf } | Should -Not -Throw
		}

		It 'Should accept subdomain format' {
			{ Add-CCSADComputerToSecurityGroup -ComputerName 'PC01' -SecurityGroupName 'TestGroup' -Domain 'sub.example.com' -Url $script:TestUrl -CCSCredential $TestCred -WhatIf } | Should -Not -Throw
		}

		It 'Should reject invalid domain format' {
			{ Add-CCSADComputerToSecurityGroup -ComputerName 'PC01' -SecurityGroupName 'TestGroup' -Domain 'invalid_domain' -Url $script:TestUrl -CCSCredential $TestCred -WhatIf } | Should -Throw
		}
	}

	Context 'ShouldProcess Support' {

		It 'Should support WhatIf' {
			(Get-Command Add-CCSADComputerToSecurityGroup).Parameters.ContainsKey('WhatIf') | Should -Be $true
		}

		It 'Should support Confirm' {
			(Get-Command Add-CCSADComputerToSecurityGroup).Parameters.ContainsKey('Confirm') | Should -Be $true
		}
	}

	Context 'CmdletBinding Attributes' {

		It 'Should be an advanced function' {
			(Get-Command Add-CCSADComputerToSecurityGroup).CmdletBinding | Should -Be $true
		}

		It 'Should have SupportsShouldProcess' {
			(Get-Command Add-CCSADComputerToSecurityGroup).Parameters['WhatIf'] | Should -Not -BeNullOrEmpty
		}

		It 'Should have OutputType defined' {
			(Get-Command Add-CCSADComputerToSecurityGroup).OutputType.Name | Should -Contain 'System.String'
		}
	}
}

Describe 'Add-CCSADComputerToSecurityGroup - Integration Tests' -Tag 'Integration' {

	BeforeAll {
		if (-not $script:TestCCSCredential) {
			Set-ItResult -Skipped -Because "Domain admin credentials not available"
		}
	}

	Context 'Live CCS Web Service Operations' {

		BeforeAll {
			# Create unique test group name
			$script:TestGroupName = "PesterTest_$(Get-Random -Minimum 1000 -Maximum 9999)"
			$script:TestComputerName = "PESTER_TEST_PC"
		}

		It 'Should connect to CCS Web Service successfully' -Skip:(-not $script:TestCCSCredential) {
			{ Add-CCSADComputerToSecurityGroup -ComputerName $script:TestComputerName -SecurityGroupName $script:TestGroupName -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Not -Throw
		}

		It 'Should add computer to security group with domain credentials' -Skip:(-not $script:TestCCSCredential) {
			$result = Add-CCSADComputerToSecurityGroup -ComputerName $script:TestComputerName -SecurityGroupName $script:TestGroupName -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
			$result | Should -Not -BeNullOrEmpty
		}

		It 'Should process multiple computers' -Skip:(-not $script:TestCCSCredential) {
			$computers = @("$script:TestComputerName`1", "$script:TestComputerName`2")
			{ $computers | Add-CCSADComputerToSecurityGroup -SecurityGroupName $script:TestGroupName -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should convert LDAP path format' -Skip:(-not $script:TestCCSCredential) {
			$ldapPath = "LDAP://DC01.Firmax.local/DC=Firmax,DC=local"
			{ Add-CCSADComputerToSecurityGroup -ComputerName $script:TestComputerName -SecurityGroupName $script:TestGroupName -DomainOUPath $ldapPath -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainCredential $script:TestDomainCredential -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}
	}

	Context 'Error Handling' {

		It 'Should handle invalid credentials gracefully' -Skip:(-not $script:TestCCSCredential) {
			$badCred = New-Object System.Management.Automation.PSCredential('baduser', (ConvertTo-SecureString 'badpass' -AsPlainText -Force))
			{ Add-CCSADComputerToSecurityGroup -ComputerName 'TestPC' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $badCred -ErrorAction Stop } | Should -Throw
		}

		It 'Should handle non-existent URL gracefully' -Skip:(-not $script:TestCCSCredential) {
			{ Add-CCSADComputerToSecurityGroup -ComputerName 'TestPC' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url 'https://nonexistent.invalid/CCS.asmx' -CCSCredential $script:TestCCSCredential -ErrorAction Stop } | Should -Throw
		}
	}
}

Describe 'Add-CCSADComputerToSecurityGroup - Performance Tests' -Tag 'Performance' {

	BeforeAll {
		Mock Initialize-CCS { return $script:MockCCS }
		Mock Get-CCSEncryptedPassword { return 'EncryptedPassword' }
		Mock Invoke-CCSIsError { return $false }

		$TestCred = New-Object System.Management.Automation.PSCredential('testuser', (ConvertTo-SecureString 'testpass' -AsPlainText -Force))
	}

	Context 'Pipeline Performance' {

		It 'Should process pipeline input efficiently' {
			$computers = 1..10 | ForEach-Object { "PC$_" }
			$measure = Measure-Command {
				$computers | Add-CCSADComputerToSecurityGroup -SecurityGroupName 'TestGroup' -Domain 'example.com' -Url $script:TestUrl -CCSCredential $TestCred -WhatIf -WarningAction SilentlyContinue
			}
			$measure.TotalSeconds | Should -BeLessThan 5
		}
	}
}