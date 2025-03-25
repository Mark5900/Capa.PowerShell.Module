
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


