<#
	.SYNOPSIS
		Adds a computer to a security group in Active Directory using the CCS Web Service.

	.DESCRIPTION
		Adds a computer to a security group in Active Directory using the CCS Web Service. This function requires the CCS Web Service URL and credentials to access it.

	.PARAMETER ComputerName
		The name of the computer to be added to the security group.

	.PARAMETER SecurityGroupName
		The name of the security group to which the computer will be added.

	.PARAMETER DomainOUPath
		The Organizational Unit (OU) path in which the computer resides.

	.PARAMETER Domain
		The domain in which the computer resides.

	.PARAMETER Url
		The URL of the CCS Web Service. Example "https://example.com/CCSWebservice/CCS.asmx".

	.PARAMETER CCSCredential
		The credentials used to authenticate with the CCS Web Service.

	.PARAMETER DomainCredential
		The credentials of an account with permissions to add the computer to the security group, if not defined it will run in the CCSWebservice context.

	.PARAMETER PasswordIsEncrypted
		Indicates if the password in the DomainCredential is encrypted. Default is false.

	.EXAMPLE
		PS C:\> Add-CCSADComputerToSecurityGroup -ComputerName "TestPC" -SecurityGroupName "TestGroup" -DomainOUPath "OU=Computers,DC=example,DC=com" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

	.EXAMPLE
		PS C:\> Add-CCSADComputerToSecurityGroup -ComputerName "TestPC" -SecurityGroupName "TestGroup" -DomainOUPath "OU=Computers,DC=example,DC=com" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential -DomainCredential $DomainCredential
#>
function Add-CCSADComputerToSecurityGroup {
	param (
		[Parameter(Mandatory = $true)]
		[string]$ComputerName,
		[Parameter(Mandatory = $true)]
		[string]$SecurityGroupName,
		[Parameter(Mandatory = $false)]
    [string]$DomainOUPath = '',
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
	$FunctionName = 'Add-CCSADComputerToSecurityGroup'

	if ($Global:Cs) {
		Job_WriteLog -Text "$FunctionName ComputerName: $ComputerName, SecurityGroupName: $SecurityGroupName, DomainOUPath: $DomainOUPath, Domain: $Domain, Url: $Url, PasswordIsEncrypted: $PasswordIsEncrypted"
	}

	$CCS = Initialize-CCS -Url $Url -WebServiceCredential $CCSCredential
	$ADPassword = $null

	if ($DomainCredential -and $PasswordIsEncrypted) {
		$ADPassword = $DomainCredential.GetNetworkCredential().Password
	} elseif ($DomainCredential -and -not $PasswordIsEncrypted) {
		$ADPassword = Get-CCSEncryptedPassword -String $DomainCredential.GetNetworkCredential().Password
	}

	$Result = $CCS.ActiveDirectory_AddComputerToSecurityGroup(
		$ComputerName,
		$SecurityGroupName,
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