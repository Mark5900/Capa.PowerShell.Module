# TODO: #432 Writes tests for Add-CCSADDomainLocalSecurityGroup
$Splat = @{
	GroupName        = 'TestCCSCreate'
	Description      = 'Test Description'
	Domain           = 'Firmax.local'
	Url              = 'https://mracapa02.capainstaller.com/CCSWebservice/CCS.asmx'
	CCSCredential    = $CCSCredential
	DomainCredential = $DomainCredential
}
Add-CCSADDomainLocalSecurityGroup @Splat