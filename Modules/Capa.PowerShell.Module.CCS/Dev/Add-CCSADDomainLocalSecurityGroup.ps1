<#
	.SYNOPSIS
		Creates a domain local security group in Active Directory.

	.DESCRIPTION
		Creates a domain local security group in Active Directory using the CCS Web Service.

	.PARAMETER GroupName
		The name of the security group to be created.

	.PARAMETER Description
		A description for the security group.

	.PARAMETER DomainOUPath
		The Organizational Unit (OU) path in which the security group will be created.

	.PARAMETER Domain
		The domain in which the security group will be created.

	.PARAMETER Url
		The URL of the CCS Web Service. Example "https://example.com/CCSWebservice/CCS.asmx".

	.PARAMETER CCSCredential
		The credentials used to authenticate with the CCS Web Service.

	.PARAMETER DomainCredential
		The credentials of an account with permissions to create the security group, if not defined it will run in the CCSWebservice context.

	.PARAMETER PasswordIsEncrypted
		Indicates if the password in the DomainCredential is encrypted. Default is false.

	.EXAMPLE
		Add-CCSADDomainLocalSecurityGroup -GroupName 'TestGroup' -Description 'Test Description' -DomainOUPath 'OU=Groups,DC=example,DC=com' -Domain 'example.com' -Url 'https://example.com/CCSWebservice/CCS.asmx' -CCSCredential $CCSCredential -DomainCredential $DomainCredential -PasswordIsEncrypted $false
#>
function Add-CCSADDomainLocalSecurityGroup {
	param (
		[Parameter(Mandatory = $true)]
		[string]$GroupName,
		[Parameter(Mandatory = $false)]
		[string]$Description,
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
	$FunctionName = 'Add-CCSADDomainLocalSecurityGroup'

	if ($Global:Cs) {
		Job_WriteLog -Text "$FunctionName GroupName: $GroupName, Description: $Description, DomainOUPath: $DomainOUPath, Domain: $Domain, Url: $Url, PasswordIsEncrypted: $PasswordIsEncrypted"
	}

	$CCS = Initialize-CCS -Url $Url -WebServiceCredential $CCSCredential
	$ADPassword = $null

	if ($DomainCredential -and $PasswordIsEncrypted) {
		$ADPassword = $DomainCredential.GetNetworkCredential().Password
	} elseif ($DomainCredential -and -not $PasswordIsEncrypted) {
		$ADPassword = Get-CCSEncryptedPassword -String $DomainCredential.GetNetworkCredential().Password
	}

	$Result = $CCS.ActiveDirectory_AddDomainLocalSecurityGroup(
		$GroupName,
		$Description,
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