<#
	.SYNOPSIS
		Remove a computer from Active Directory using the CCS Web Service.

	.DESCRIPTION
		Removes a computer from Active Directory using the CCS Web Service. This function requires the CCS Web Service URL and credentials to access it.

	.PARAMETER ComputerName
		The name of the computer to be removed from Active Directory.

	.PARAMETER DomainOUPath
		The Organizational Unit (OU) path in which the computer resides.

	.PARAMETER Domain
		The domain in which the computer resides.

	.PARAMETER Url
		The URL of the CCS Web Service. Example "https://example.com/CCSWebservice/CCS.asmx".

	.PARAMETER CCSCredential
		The credentials used to authenticate with the CCS Web Service.

	.PARAMETER DomainCredential
		The credentials of an account with permissions to remove the computer from Active Directory, if not defined it will run in the CCSWebservice context.

	.PARAMETER PasswordIsEncrypted
		Indicates if the password in the DomainCredential is encrypted. Default is false.

	.EXAMPLE
		PS C:\> Remove-CCSADComputer -ComputerName "TestPC" -DomainOUPath "OU=Computers,DC=example,DC=com" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

	.EXAMPLE
		PS C:\> Remove-CCSADComputer -ComputerName "TestPC" -DomainOUPath "OU=Computers,DC=example,DC=com" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential -DomainCredential $DomainCredential
#>
function Remove-CCSADComputer {
	param (
		[Parameter(Mandatory = $true)]
		[string]$ComputerName,
		[Parameter(Mandatory = $false)]
		[string]$DomainOUPath,
		[Parameter(Mandatory = $true)]
		[string]$Domain,
		[Parameter(Mandatory = $true)]
		[string]$Url,
		[Parameter(Mandatory = $true)]
		[pscredential]$CCSCredential,
		[Parameter(Mandatory = $false)]
		[pscredential]$DomainCredential,
		[Parameter(Mandatory = $false)]
		[bool]$PasswordIsEncrypted = $false
	)
	if ($Global:Cs) {
		Job_WriteLog -Text "Remove-CCSADComputer: ComputerName: $ComputerName, DomainOUPath: $DomainOUPath, Domain: $Domain, Url: $Url, PasswordIsEncrypted: $PasswordIsEncrypted"
	}

	$CCS = Initialize-CCS -Url $Url -WebServiceCredential $CCSCredential
	$ADPassword = $null

	if ($DomainCredential -and $PasswordIsEncrypted) {
		$ADPassword = $DomainCredential.GetNetworkCredential().Password
	} elseif ($DomainCredential -and -not $PasswordIsEncrypted) {
		$ADPassword = Get-CCSEncryptedPassword -String $DomainCredential.GetNetworkCredential().Password
	}

	$Result = $CCS.ActiveDirectory_RemoveComputer(
		$ComputerName,
		$DomainOUPath,
		$Domain,
		$DomainCredential.UserName,
		$ADPassword
	)

	if ($Global:Cs) {
		Job_WriteLog -Text "Remove-CCSADComputer: Result: $Result"
	}

	return $Result
}