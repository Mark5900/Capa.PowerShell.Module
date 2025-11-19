<#
	.SYNOPSIS
		Adds a user to a security group in Active Directory using the CCS API.

	.DESCRIPTION
		Adds a user to a security group in Active Directory using the CCS API.

	.PARAMETER UserName
		The username of the user to be added to the security group.

	.PARAMETER SecurityGroupName
		The name of the security group to which the user will be added.

	.PARAMETER DomainOUPath
		The Organizational Unit (OU) path of the domain where the security group resides.

	.PARAMETER Domain
		The domain name where the security group resides.

	.PARAMETER Url
		The URL of the CCS API.

	.PARAMETER CCSCredential
		The credentials for the CCS API.

	.PARAMETER DomainCredential
		The credentials for the domain where the security group resides.

	.PARAMETER PasswordIsEncrypted
		Indicates whether the password is encrypted. Default is $false.

	.EXAMPLE
		Add-CCSADUserToSecurityGroup -UserName "jdoe" -SecurityGroupName "Domain Users" -DomainOUPath "OU=Users,DC=example,DC=com" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $ccsCredential -DomainCredential $domainCredential
#>
function Add-CCSADUserToSecurityGroup {
	param (
		[Parameter(Mandatory = $true)]
		[string]$UserName,
		[Parameter(Mandatory = $true)]
		[string]$SecurityGroupName,
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
	$FunctionName = 'Add-CCSADUserToSecurityGroup'

	if ($Global:Cs) {
		$Global:Cs.Job_WriteLog("$FunctionName UserName: $UserName, SecurityGroupName: $SecurityGroupName, DomainOUPath: $DomainOUPath, Domain: $Domain, Url: $Url, PasswordIsEncrypted: $PasswordIsEncrypted")
	}

	$CCS = Initialize-CCS -Url $Url -WebServiceCredential $CCSCredential
	$ADPassword = $null

	if ($DomainCredential -and $PasswordIsEncrypted) {
		$ADPassword = $DomainCredential.GetNetworkCredential().Password
	} elseif ($DomainCredential -and -not $PasswordIsEncrypted) {
		$ADPassword = Get-CCSEncryptedPassword -String $DomainCredential.GetNetworkCredential().Password
	}

	$Result = $CCS.ActiveDirectory_AddUserToSecurityGroup(
		$UserName,
		$SecurityGroupName,
		$DomainOUPath,
		$Domain,
		$DomainCredential.UserName,
		$ADPassword
	)

	if ($Global:Cs) {
		$Global:Cs.Job_WriteLog("$FunctionName Result: $Result")
	}

	$Throw = Invoke-CCSIsError -Result $Result
	if ($Throw) {
		throw "$FunctionName $Result"
	}

	return $Result
}