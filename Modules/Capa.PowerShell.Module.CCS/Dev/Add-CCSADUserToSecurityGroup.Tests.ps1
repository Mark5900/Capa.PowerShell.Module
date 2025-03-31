# TODO: #436 Write tests for Add-CCSADUserToSecurityGroup
$Splat = @{
	UserName          = "Test"
	SecurityGroupName = "TestGruppe1"
	Domain            = 'Firmax.local'
	Url               = 'https://mracapa02.capainstaller.com/CCSWebservice/CCS.asmx'
	CCSCredential     = $CCSCredential
	DomainCredential  = $DomainCredential
}
Add-CCSADUserToSecurityGroup @Splat