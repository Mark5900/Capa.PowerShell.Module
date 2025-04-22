<#
	.SYNOPSIS
		Adds a Universal Security Group to Active Directory.

	.DESCRIPTION
		Adds a Universal Security Group to Active Directory.

	.PARAMETER GroupName
		The name of the group to be created.

	.PARAMETER Description
		The description of the group.

	.PARAMETER DomainOUPath
		The Organizational Unit (OU) path where the group will be created.

	.PARAMETER Domain
		The domain where the group will be created.

	.PARAMETER Url
		The URL of the CCS Web Service.

	.PARAMETER CCSCredential
		The credentials for the CCS Web Service.

	.PARAMETER DomainCredential
		The credentials for the domain.

	.PARAMETER PasswordIsEncrypted
		Indicates whether the AD password is encrypted.

	.EXAMPLE
		Add-CCSADUniversalSecurityGroup -GroupName 'TestGroup' -Description 'Test Description' -DomainOUPath 'OU=Groups,DC=example,DC=com' -Domain 'example.com' -Url 'https://example.com/CCSWebservice/CCS.asmx' -CCSCredential $CCSCredential -DomainCredential $DomainCredential -PasswordIsEncrypted $false
#>
function Add-CCSADUniversalSecurityGroup {
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
	$FunctionName = 'Add-CCSADUniversalSecurityGroup'

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

	$Result = $CCS.ActiveDirectory_AddUniversalSecurityGroup(
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