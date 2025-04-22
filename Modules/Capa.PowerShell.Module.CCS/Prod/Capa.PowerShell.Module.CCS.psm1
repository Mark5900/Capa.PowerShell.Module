
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


<#
	.SYNOPSIS
		Creates a global security group in Active Directory.

	.DESCRIPTION
		Creates a global security group in Active Directory using the CCS Web Service.

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
		Add-CCSADGlobalSecurityGroup -GroupName 'TestGroup' -Description 'Test Description' -DomainOUPath 'OU=Groups,DC=example,DC=com' -Domain 'example.com' -Url 'https://example.com/CCSWebservice/CCS.asmx' -CCSCredential $CCSCredential -DomainCredential $DomainCredential -PasswordIsEncrypted $false
#>
function Add-CCSADGlobalSecurityGroup {
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
	$FunctionName = 'Add-CCSADGlobalSecurityGroup'

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

	$Result = $CCS.ActiveDirectory_AddGlobalSecurityGroup(
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
		Job_WriteLog -Text "$FunctionName UserName: $UserName, SecurityGroupName: $SecurityGroupName, DomainOUPath: $DomainOUPath, Domain: $Domain, Url: $Url, PasswordIsEncrypted: $PasswordIsEncrypted"
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
		Job_WriteLog -Text "$FunctionName Result: $Result"
	}

	$Throw = Invoke-CCSIsError -Result $Result
	if ($Throw) {
		throw "$FunctionName $Result"
	}

	return $Result
}


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
	$FunctionName = 'Add-CCSADUserToSecurityGroup'

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


<#
	.SYNOPSIS
		This function encrypts a string using the InstallationScreen.exe utility.

	.DESCRIPTION
		This function takes a string as input and uses the InstallationScreen.exe utility to encrypt it.
		The encrypted string is returned as output and used multiple times, when working with the CCS Webservice.

	.PARAMETER String
		The string to be encrypted.

	.EXAMPLE
		PS C:\> Get-CCSEncryptedPassword -String "Admin1234"
#>
function Get-CCSEncryptedPassword {
	param (
		[Parameter(Mandatory = $true)]
		[string]$String
	)
	$OutputPath = Join-Path $env:TEMP 'InstallationScreen.log'

	try {
		$ExePath = Join-Path $PSScriptRoot 'Dependencies' 'InstallationScreen.exe'
		$Arguments = "power $String"

		if (Test-Path $OutputPath) {
			Remove-Item $OutputPath -Force
		}

		Start-Process -FilePath $ExePath -ArgumentList $Arguments -Wait -RedirectStandardOutput $OutputPath -NoNewWindow
		$Output = Get-Content $OutputPath

		return $Output.Trim() -replace '\r?\n', ''
	} catch {
		<#Do this if a terminating exception happens#>
	} finally {
		if (Test-Path $OutputPath) {
			Remove-Item $OutputPath -Force
		}
	}
}


<#
	.SYNOPSIS
		This function initializes the CCS Webservice client.

	.DESCRIPTION
		This function initializes the CCS Webservice client by loading the necessary DLL and setting up the binding and endpoint.
		It also sets the client credentials for authentication.

	.PARAMETER Url
		The URL of the CCS Webservice.

	.PARAMETER WebServiceCredential
		The credentials used to authenticate with the CCS Webservice.

	.EXAMPLE
		PS C:\> Initialize-CCS -Url "https://example.com/CCSWebservice/CCS.asmx" -WebServiceCredential $Credential
#>
function Initialize-CCS {
	param (
		[Parameter(Mandatory = $true)]
		[string]$Url,
		[Parameter(Mandatory = $true)]
		[pscredential]$WebServiceCredential
	)
	if ($Url -notlike 'https://*') {
		throw "Invalid URL format. Please provide a valid HTTPS URL."
	}

	$DllPath = Join-Path $PSScriptRoot 'Dependencies' 'CCSProxy.dll'
	Add-Type -Path $DllPath

	$binding = New-Object System.ServiceModel.BasicHttpBinding
	$binding.Security.Mode = [System.ServiceModel.BasicHttpSecurityMode]::Transport
	$binding.Security.Transport.ClientCredentialType = [System.ServiceModel.HttpClientCredentialType]::Basic

	$endpoint = New-Object System.ServiceModel.EndpointAddress($Url)
	$client = New-Object CapaProxy.CCSSoapClient($binding, $endpoint)
	$client.ClientCredentials.UserName.UserName = $WebServiceCredential.UserName
	$client.ClientCredentials.UserName.Password = $WebServiceCredential.GetNetworkCredential().Password

	return $client
}


function Invoke-CCSIsError {
	param (
		[Parameter(Mandatory = $true)]
		[string]$Result
	)

	switch -Wildcard ($Result) {
		'*does not exist*' {
			return $true
		}
		'The server is unwilling to process the request*' {
			return $true
		}
		default {
			return $false
		}
	}
}


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

	.EXAMPLE
		PS C:\> Remove-CCSADComputer -ComputerName "TestPC" -DomainOUPath "LDAP://DC01.FirmaX.local/OU=Computers,DC=FirmaX,DC=local" -Domain "FirmaX.local" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential -DomainCredential $DomainCredential -PasswordIsEncrypted $true
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


