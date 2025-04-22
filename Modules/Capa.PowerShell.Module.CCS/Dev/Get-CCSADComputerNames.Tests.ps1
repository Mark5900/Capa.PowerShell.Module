$Splat = @{
	Domain 				 = 'Firmax.local'
	CCSCredential = $CCSCredential
	Url          = 'https://mracapa02.capainstaller.com/CCSWebservice/CCS.asmx'
	DomainCredential = $DomainCredential
}
$Result = Get-CCSADComputerNames @Splat