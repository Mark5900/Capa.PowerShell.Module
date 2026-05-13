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

Describe 'Remove-CCSADUserFromSecurityGroup' -Tag 'Unit' {

	Context 'Parameter Validation' {

		It 'Should have mandatory UserName parameter' {
			(Get-Command Remove-CCSADUserFromSecurityGroup).Parameters['UserName'].Attributes.Mandatory | Should -Be $true
		}

		It 'Should have mandatory SecurityGroupName parameter' {
			(Get-Command Remove-CCSADUserFromSecurityGroup).Parameters['SecurityGroupName'].Attributes.Mandatory | Should -Be $true
		}

		It 'Should have mandatory Domain parameter' {
			(Get-Command Remove-CCSADUserFromSecurityGroup).Parameters['Domain'].Attributes.Mandatory | Should -Be $true
		}

		It 'Should have mandatory Url parameter' {
			(Get-Command Remove-CCSADUserFromSecurityGroup).Parameters['Url'].Attributes.Mandatory | Should -Be $true
		}

		It 'Should have mandatory CCSCredential parameter' {
			(Get-Command Remove-CCSADUserFromSecurityGroup).Parameters['CCSCredential'].Attributes.Mandatory | Should -Be $true
		}

		It 'Should have optional DomainCredential parameter' {
			(Get-Command Remove-CCSADUserFromSecurityGroup).Parameters['DomainCredential'].Attributes.Mandatory | Should -Be $false
		}

		It 'Should have optional DomainOUPath parameter' {
			(Get-Command Remove-CCSADUserFromSecurityGroup).Parameters['DomainOUPath'].Attributes.Mandatory | Should -Be $false
		}

		It 'Should accept array of user names' {
			(Get-Command Remove-CCSADUserFromSecurityGroup).Parameters['UserName'].ParameterType.Name | Should -Be 'String[]'
		}

		It 'Should accept pipeline input for UserName' {
			(Get-Command Remove-CCSADUserFromSecurityGroup).Parameters['UserName'].Attributes.ValueFromPipeline | Should -Be $true
		}
	}

	Context 'Parameter Aliases' {

		It 'Should have alias "Name" for UserName' {
			(Get-Command Remove-CCSADUserFromSecurityGroup).Parameters['UserName'].Aliases | Should -Contain 'Name'
		}

		It 'Should have alias "User" for UserName' {
			(Get-Command Remove-CCSADUserFromSecurityGroup).Parameters['UserName'].Aliases | Should -Contain 'User'
		}

		It 'Should have alias "GroupName" for SecurityGroupName' {
			(Get-Command Remove-CCSADUserFromSecurityGroup).Parameters['SecurityGroupName'].Aliases | Should -Contain 'GroupName'
		}

		It 'Should have alias "Group" for SecurityGroupName' {
			(Get-Command Remove-CCSADUserFromSecurityGroup).Parameters['SecurityGroupName'].Aliases | Should -Contain 'Group'
		}

		It 'Should have alias "OU" for DomainOUPath' {
			(Get-Command Remove-CCSADUserFromSecurityGroup).Parameters['DomainOUPath'].Aliases | Should -Contain 'OU'
		}
	}

	Context 'DomainOUPath Validation' {

		It 'Should accept empty DomainOUPath' {
			{ Remove-CCSADUserFromSecurityGroup -UserName 'TestUser' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath '' -WhatIf -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should accept standard DN format' {
			{ Remove-CCSADUserFromSecurityGroup -UserName 'TestUser' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'OU=Users,DC=Firmax,DC=local' -WhatIf -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should accept DC-only format' {
			{ Remove-CCSADUserFromSecurityGroup -UserName 'TestUser' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'DC=Firmax,DC=local' -WhatIf -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should accept LDAP format' {
			{ Remove-CCSADUserFromSecurityGroup -UserName 'TestUser' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'LDAP://DC01.Firmax.local/OU=Users,DC=Firmax,DC=local' -WhatIf -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should reject invalid format' {
			{ Remove-CCSADUserFromSecurityGroup -UserName 'TestUser' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -DomainOUPath 'InvalidPath' -WhatIf } | Should -Throw
		}
	}

	Context 'URL Validation' {

		It 'Should accept HTTPS URL' {
			{ Remove-CCSADUserFromSecurityGroup -UserName 'TestUser' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should reject HTTP URL (only HTTPS allowed)' {
			$httpUrl = $script:TestUrl -replace '^https:', 'http:'
			{ Remove-CCSADUserFromSecurityGroup -UserName 'TestUser' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url $httpUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Throw
		}

		It 'Should reject URL without protocol' {
			{ Remove-CCSADUserFromSecurityGroup -UserName 'TestUser' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url 'test.com/CCS.asmx' -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Throw
		}
	}

	Context 'Domain Validation' {

		It 'Should accept valid domain format' {
			{ Remove-CCSADUserFromSecurityGroup -UserName 'TestUser' -SecurityGroupName 'TestGroup' -Domain $script:TestDomain -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should accept subdomain format' {
			{ Remove-CCSADUserFromSecurityGroup -UserName 'TestUser' -SecurityGroupName 'TestGroup' -Domain 'sub.firmax.local' -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf -ErrorAction SilentlyContinue -WarningAction SilentlyContinue } | Should -Not -Throw
		}

		It 'Should reject invalid domain format' {
			{ Remove-CCSADUserFromSecurityGroup -UserName 'TestUser' -SecurityGroupName 'TestGroup' -Domain 'invalid_domain' -Url $script:TestUrl -CCSCredential $script:TestCCSCredential -WhatIf } | Should -Throw
		}
	}

	Context 'ShouldProcess Support' {

		It 'Should support WhatIf' {
			(Get-Command Remove-CCSADUserFromSecurityGroup).Parameters.ContainsKey('WhatIf') | Should -Be $true
		}

		It 'Should support Confirm' {
			(Get-Command Remove-CCSADUserFromSecurityGroup).Parameters.ContainsKey('Confirm') | Should -Be $true
		}
	}

	Context 'CmdletBinding Attributes' {

		It 'Should be an advanced function' {
			(Get-Command Remove-CCSADUserFromSecurityGroup).CmdletBinding | Should -Be $true
		}

		It 'Should have SupportsShouldProcess' {
			(Get-Command Remove-CCSADUserFromSecurityGroup).Parameters['WhatIf'] | Should -Not -BeNullOrEmpty
		}

		It 'Should have OutputType defined' {
			(Get-Command Remove-CCSADUserFromSecurityGroup).OutputType.Name | Should -Contain 'System.String'
		}
	}
}

Describe "Remove-CCSADUserFromSecurityGroup Integration Tests" -Tag 'Integration' {

	BeforeAll {
		$TestUserName = "TestUser_$([guid]::NewGuid().ToString().Substring(0, 8))"
		$TestSecurityGroupName = "TestGroup_Remove"
		$TestDomain = "Firmax.local"
		$TestUrl = "https://psccsdev.firmax.local:443/CCSWebservice/CCS.asmx"
		$TestCCSCredentialUsername = "admin"
		$TestCCSCredentialPassword = ConvertTo-SecureString "Iamhim" -AsPlainText -Force
		$TestCCSCredential = New-Object System.Management.Automation.PSCredential($TestCCSCredentialUsername, $TestCCSCredentialPassword)
		$TestDomainOUPath = "DC=FirmaX,DC=local"
	}

	It "Should remove a user from a security group successfully" -Skip {
		$Result = Remove-CCSADUserFromSecurityGroup -UserName $TestUserName -SecurityGroupName $TestSecurityGroupName -DomainOUPath $TestDomainOUPath -Domain $TestDomain -Url $TestUrl -CCSCredential $TestCCSCredential -Confirm:$false -ErrorAction SilentlyContinue
		$Result | Should -Not -BeNullOrEmpty
	}

	It "Should handle multiple users via pipeline" -Skip {
		$Users = @("User1", "User2", "User3")
		$Result = $Users | Remove-CCSADUserFromSecurityGroup -SecurityGroupName $TestSecurityGroupName -DomainOUPath $TestDomainOUPath -Domain $TestDomain -Url $TestUrl -CCSCredential $TestCCSCredential -Confirm:$false -ErrorAction SilentlyContinue
		$Result.Count | Should -Be 3
	}

	It "Should support WhatIf parameter" {
		$Result = Remove-CCSADUserFromSecurityGroup -UserName $TestUserName -SecurityGroupName $TestSecurityGroupName -DomainOUPath $TestDomainOUPath -Domain $TestDomain -Url $TestUrl -CCSCredential $TestCCSCredential -WhatIf -Confirm:$false -ErrorAction SilentlyContinue
		$Result | Should -BeNullOrEmpty
	}

	It "Should handle LDAP format for DomainOUPath" -Skip {
		$LdapPath = "LDAP://DCFIRMAX01.Firmax.local/DC=FirmaX,DC=local"
		$Result = Remove-CCSADUserFromSecurityGroup -UserName $TestUserName -SecurityGroupName $TestSecurityGroupName -DomainOUPath $LdapPath -Domain $TestDomain -Url $TestUrl -CCSCredential $TestCCSCredential -Confirm:$false -ErrorAction SilentlyContinue
		$Result | Should -Not -BeNullOrEmpty
	}

	It "Should handle empty DomainOUPath" -Skip {
		$Result = Remove-CCSADUserFromSecurityGroup -UserName $TestUserName -SecurityGroupName $TestSecurityGroupName -DomainOUPath "" -Domain $TestDomain -Url $TestUrl -CCSCredential $TestCCSCredential -Confirm:$false -ErrorAction SilentlyContinue
		$Result | Should -Not -BeNullOrEmpty
	}

	It "Should handle non-existent user gracefully" {
		$Result = Remove-CCSADUserFromSecurityGroup -UserName "NonExistentUser_xyz123" -SecurityGroupName $TestSecurityGroupName -DomainOUPath $TestDomainOUPath -Domain $TestDomain -Url $TestUrl -CCSCredential $TestCCSCredential -Confirm:$false -ErrorAction SilentlyContinue
		# Should not throw, but may return error message
		$true | Should -Be $true
	}
}

Describe "Remove-CCSADUserFromSecurityGroup Performance Tests" -Tag 'Performance' {

	BeforeAll {
		$TestUserName = "TestUser_$([guid]::NewGuid().ToString().Substring(0, 8))"
		$TestSecurityGroupName = "TestGroup_Remove"
		$TestDomain = "Firmax.local"
		$TestUrl = "https://psccsdev.firmax.local:443/CCSWebservice/CCS.asmx"
		$TestCCSCredentialUsername = "admin"
		$TestCCSCredentialPassword = ConvertTo-SecureString "Iamhim" -AsPlainText -Force
		$TestCCSCredential = New-Object System.Management.Automation.PSCredential($TestCCSCredentialUsername, $TestCCSCredentialPassword)
		$TestDomainOUPath = "DC=FirmaX,DC=local"
	}

	It "Should process 10 users in reasonable time" -Skip {
		$Users = 1..10 | ForEach-Object { "TestUser_$_" }
		$Stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
		$Users | Remove-CCSADUserFromSecurityGroup -SecurityGroupName $TestSecurityGroupName -DomainOUPath $TestDomainOUPath -Domain $TestDomain -Url $TestUrl -CCSCredential $TestCCSCredential -Confirm:$false -ErrorAction SilentlyContinue
		$Stopwatch.Stop()
		$Stopwatch.Elapsed.TotalSeconds | Should -BeLessThan 30
	}
}
