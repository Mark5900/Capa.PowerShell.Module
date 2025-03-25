BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')

	$Url = 'https://mracapa02.capainstaller.com/CCSWebservice/CCS.asmx'

	$CCSUser = 'svc_capawebservice'
	$ADUser = 'Administrator'
	$Password = 'Admin1234'
	$Domain = 'FirmaX.local'

	$SecurePassword = ConvertTo-SecureString -String $Password -AsPlainText -Force
	$CCSCredential = New-Object System.Management.Automation.PSCredential($CCSUser, $SecurePassword)
	$DomainCredential = New-Object System.Management.Automation.PSCredential($ADUser, $SecurePassword)

	$ComputerName1 = 'Test-Computer'
	$ComputerName2 = 'Test-Computer2'
	$OUPath = "CN=Computers,DC=FirmaX,DC=local"

	New-ADComputer -Name $ComputerName2 -Credential $DomainCredential
}
Describe 'Tests that should work' {
	It "Should say 'Computer does not exist.'" {
		$Splat = @{
			ComputerName = $ComputerName1
			Domain = $Domain
			Url = $Url
			CCSCredential = $CCSCredential
			DomainCredential = $DomainCredential
		}
		$Result =  Remove-CCSADComputer @Splat
		$Result | Should -BeOfType [string]
		$Result | Should -Be 'Computer does not exist.'
	}
	It "Should say 'Computer Deleted.'" {
		$Splat = @{
			ComputerName = $ComputerName2
			Domain = $Domain
			Url = $Url
			CCSCredential = $CCSCredential
			DomainCredential = $DomainCredential
		}
		$Result =  Remove-CCSADComputer @Splat
		$Result | Should -BeOfType [string]
		$Result | Should -Be 'Computer Deleted.'
	}
}
AfterAll {
	try {
		Remove-ADComputer -Identity $ComputerName2 -Credential $DomainCredential -Confirm:$false
	}
	catch {}
}