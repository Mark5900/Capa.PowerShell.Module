BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')

	$Url1 = "https://mracapa02.capainstaller.com/CCSWebservice/CCS.asmx"
	$Url2 = "http://mracapa02.capainstaller.com/CCSWebservice/CCS.asmx"

	$User = "svc_capawebservice"
	$Password = "Admin1234"

	$SecurePassword = ConvertTo-SecureString -String $Password -AsPlainText -Force
	$Credential = New-Object System.Management.Automation.PSCredential($User, $SecurePassword)
}
Describe "Tests that should work" {
	It "Should return a obejct" {
		$Client = Initialize-CCS -Url $Url1 -WebServiceCredential $Credential
		$Client | Should -BeOfType CapaProxy.CCSSoapClient
	}
}
Describe "Tests that should fail" {
	It "Should throw an exception" {
		{ Initialize-CCS -Url $Url2 -WebServiceCredential $Credential } | Should -Throw
	}
}