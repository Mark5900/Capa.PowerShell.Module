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