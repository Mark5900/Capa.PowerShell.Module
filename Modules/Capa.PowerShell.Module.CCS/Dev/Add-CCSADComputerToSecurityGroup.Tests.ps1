# TODO: #431 Write tests for Add-CCSADComputerToSecurityGroup
$Url = 'https://mracapa03.capainstaller.com/CCSWebservice/CCS.asmx'
$CCSCredential = Get-Credential
$DomainCredential = Get-Credential
Add-CCSADComputerToSecurityGroup -ComputerName 'Test' -SecurityGroupName 'TestGruppe' -Domain 'Firmax.local' -Url $Url -CCSCredential $CCSCredential -DomainCredential $DomainCredential
Add-CCSADComputerToSecurityGroup -ComputerName 'Test' -SecurityGroupName 'TestGruppe1' -Domain 'Firmax.local' -Url $Url -CCSCredential $CCSCredential -DomainCredential $DomainCredential

$Splat = @{
	ComputerName     = 'mracapa03'
	Domain           = 'Firmax.local'
	Url              = $Url
	CCSCredential    = $CCSCredential
	DomainCredential = $DomainCredential
}
$Result = Remove-CCSADComputer @Splat