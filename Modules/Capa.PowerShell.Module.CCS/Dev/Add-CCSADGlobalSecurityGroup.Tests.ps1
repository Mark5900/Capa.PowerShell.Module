# TODO: Create Tests for Add-CCSADGlobalSecurityGroup

$CCSCredential = Get-Credential -Message 'Enter CCS Web Service credentials'
$DomainCredential = Get-Credential -Message 'Enter Domain credentials'

$Splat = @{
	GroupName        = 'Test_Add-CCSADGlobalSecurityGroup'
	Description      = 'Test Description'
	Domain           = 'Firmax.local'
	Url              = 'https://mracapa02.capainstaller.com/CCSWebservice/CCS.asmx'
	CCSCredential    = $CCSCredential
	DomainCredential = $DomainCredential
}
Add-CCSADGlobalSecurityGroup @Splat