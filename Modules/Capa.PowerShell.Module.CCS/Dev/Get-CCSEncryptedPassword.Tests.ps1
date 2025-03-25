BeforeAll {
	. $PSCommandPath.Replace('.Tests.ps1', '.ps1')

	$Plain = "Admin1234"
	$Encrypted = "mOQXCLuC/rSkIrAQU3Ttbg=="
}
Describe 'Testing Get-CCSEncryptedPassword' {
	It "Should return $Encrypted" {
		$Result = Get-CCSEncryptedPassword -String $Plain
		$Result | Should -Be $Encrypted
	}
}