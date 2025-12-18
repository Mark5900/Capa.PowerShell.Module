function Initialize-CCS {
	<#
	.SYNOPSIS
		Initializes the CCS Web Service client for secure communication.

	.DESCRIPTION
		Initializes the CCS Web Service client by loading the necessary DLL, setting up the binding and endpoint, and configuring client credentials for authentication.
		This advanced function includes comprehensive error handling, input validation, and verbose/debug output.

	.PARAMETER Url
		The URL of the CCS Web Service. Must be a valid HTTPS URI format.
		Example: "https://example.com/CCSWebservice/CCS.asmx"

	.PARAMETER WebServiceCredential
		The credentials used to authenticate with the CCS Web Service.

	.EXAMPLE
		PS C:\> Initialize-CCS -Url "https://example.com/CCSWebservice/CCS.asmx" -WebServiceCredential $Credential

		Initializes the CCS client with the specified URL and credentials.

	.EXAMPLE
		PS C:\> $client = Initialize-CCS -Url $url -Credential $cred -Verbose

		Initializes the CCS client with verbose output, using the Credential alias.

	.OUTPUTS
		CapaProxy.CCSSoapClient
		Returns the initialized CCS SOAP client object.

	.NOTES
		This is an advanced function with comprehensive error handling, parameter validation, and verbose output.
	#>
	[CmdletBinding()]
	[OutputType([CapaProxy.CCSSoapClient])]
	param (
		[Parameter(
			Mandatory = $true,
			Position = 0,
			ValueFromPipelineByPropertyName = $true,
			HelpMessage = 'Enter the CCS Web Service URL'
		)]
		[ValidateNotNullOrEmpty()]
		[ValidateScript({
			if ($_ -match '^https://') {
				$true
			} else {
				throw "URL must start with https:// (secure connection required)"
			}
		})]
	[Alias('Uri', 'WebServiceUrl')]
	[string]$Url,

	[Parameter(
		Mandatory = $true,
		Position = 1,
		ValueFromPipelineByPropertyName = $true,
		HelpMessage = 'Enter the CCS Web Service credentials'
	)]
	[ValidateNotNullOrEmpty()]
	[ValidateScript({
		if ($_ -is [System.Management.Automation.PSCredential]) {
			$true
		} else {
			throw "WebServiceCredential must be a PSCredential object"
		}
	})]
	[Alias('Credential', 'Cred')]
	[pscredential]$WebServiceCredential
)	begin {
		$FunctionName = $PSCmdlet.MyInvocation.MyCommand.Name
		Write-Verbose "[$FunctionName] Starting function execution"
		Write-Verbose "[$FunctionName] URL: $Url"
		Write-Verbose "[$FunctionName] Username: $($WebServiceCredential.UserName)"
	}

	process {
		try {
			# Validate and load DLL
			$DllPath = Join-Path $PSScriptRoot 'Dependencies' 'CCSProxy.dll'
			Write-Verbose "[$FunctionName] DLL Path: $DllPath"

			if (-not (Test-Path $DllPath)) {
				$msg = "CCSProxy.dll not found at $DllPath"
				Write-Error $msg
				throw $msg
			}

			Write-Debug "[$FunctionName] Loading CCSProxy.dll"
			Add-Type -Path $DllPath -ErrorAction Stop

			# Configure binding
			Write-Debug "[$FunctionName] Configuring BasicHttpBinding"
			$binding = New-Object System.ServiceModel.BasicHttpBinding
			$binding.Security.Mode = [System.ServiceModel.BasicHttpSecurityMode]::Transport
			$binding.Security.Transport.ClientCredentialType = [System.ServiceModel.HttpClientCredentialType]::Basic

			# Create endpoint
			Write-Debug "[$FunctionName] Creating endpoint for $Url"
			$endpoint = New-Object System.ServiceModel.EndpointAddress($Url)

			# Create client
			Write-Verbose "[$FunctionName] Initializing CCS SOAP client"
			$client = New-Object CapaProxy.CCSSoapClient($binding, $endpoint)

			# Set credentials
			$client.ClientCredentials.UserName.UserName = $WebServiceCredential.UserName
			$client.ClientCredentials.UserName.Password = $WebServiceCredential.GetNetworkCredential().Password

			Write-Verbose "[$FunctionName] CCS client initialized successfully"
			Write-Output $client

		} catch {
			$msg = "[$FunctionName] Failed to initialize CCS Web Service client: $_"
			Write-Error $msg
			throw $msg
		}
	}

	end {
		Write-Verbose "[$FunctionName] Function execution completed"
	}
}