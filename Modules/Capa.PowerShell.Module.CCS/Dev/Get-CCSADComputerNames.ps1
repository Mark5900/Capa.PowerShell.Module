<#
	.SYNOPSIS
		Gets the computer names from Active Directory using the CCS API.

	.DESCRIPTION
		Gets the computer names from Active Directory using the CCS API.

	.PARAMETER DomainOUPath
		The Organizational Unit (OU) path of the domain where the computers reside.

	.PARAMETER Domain
		The domain name where the computers reside.

	.PARAMETER Url
		The URL of the CCS API.

	.PARAMETER CCSCredential
		The credentials for the CCS API.

	.PARAMETER DomainCredential
		The credentials for the domain where the computers reside.

	.PARAMETER PasswordIsEncrypted
		Indicates whether the password is encrypted. Default is $false.

	.EXAMPLE
		Get-CCSADComputerNames -DomainOUPath "OU=Test,DC=FirmaX,DC=local" -Domain "FirmaX.local" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $ccsCredential -DomainCredential $domainCredential
#>
function Get-CCSADComputerNames {
	param (
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
	$FunctionName = 'Get-CCSADComputerNames'

	if ($Global:Cs) {
		Job_WriteLog -Text "$FunctionName DomainOUPath: $DomainOUPath, Domain: $Domain, Url: $Url, PasswordIsEncrypted: $PasswordIsEncrypted"
	}

	$CCS = Initialize-CCS -Url $Url -WebServiceCredential $CCSCredential
	$ADPassword = $null

	if ($DomainCredential -and $PasswordIsEncrypted) {
		$ADPassword = $DomainCredential.GetNetworkCredential().Password
	} elseif ($DomainCredential -and -not $PasswordIsEncrypted) {
		$ADPassword = Get-CCSEncryptedPassword -String $DomainCredential.GetNetworkCredential().Password
	}

	$Result = $CCS.ActiveDirectory_GetComputerNames(
		$DomainOUPath,
		$Domain,
		$DomainCredential.UserName,
		$ADPassword
	)

	if ($Global:Cs) {
		Job_WriteLog -Text "$FunctionName Result: $Result"
	}

	$Throw = Invoke-CCSIsError -Result $Result
	if ($Throw) {
		throw "$FunctionName $Result"
	}

	return $Result
}