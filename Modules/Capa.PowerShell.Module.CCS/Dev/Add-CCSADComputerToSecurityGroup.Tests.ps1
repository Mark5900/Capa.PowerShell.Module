# TODO: #431 Write tests for Add-CCSADComputerToSecurityGroup
$Url = 'https://mracapa02.capainstaller.com/CCSWebservice/CCS.asmx'
$CCSCredential = Get-Credential
$DomainCredential = Get-Credential
Add-CCSADComputerToSecurityGroup -ComputerName 'MRADTEST02' -SecurityGroupName 'TestGruppe' -Domain 'Firmax.local' -Url $Url -CCSCredential $CCSCredential -DomainCredential $DomainCredential

$Splat = @{
	ComputerName     = 'MRADTEST02'
	Domain           = 'Firmax.local'
	Url              = $Url
	CCSCredential    = $CCSCredential
	DomainCredential = $DomainCredential
}
$Result = Remove-CCSADComputer @Splat