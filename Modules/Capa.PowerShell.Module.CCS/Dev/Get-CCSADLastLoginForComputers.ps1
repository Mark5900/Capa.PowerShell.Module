function Get-CCSADLastLoginForComputers {
	<#
	.SYNOPSIS
		Retrieves last login information for all computers in Active Directory using the CCS Web Service.

	.DESCRIPTION
		Retrieves comprehensive last login information for all computers in Active Directory using the CCS Web Service.
		Returns computer name, last logon time, last logon DC, operating system, and AD path for each computer.
		This advanced function includes comprehensive error handling and input validation.

	.PARAMETER DomainOUPath
		The Organizational Unit (OU) path to search for computers.
		If not specified, searches the entire domain.
		Supports both standard DN format (OU=Computers,DC=example,DC=com) and LDAP format (LDAP://DC01.example.local/OU=Computers,DC=example,DC=com).

	.PARAMETER Domain
		The domain to query for computer information.
		Must be a valid domain name format.

	.PARAMETER Url
		The URL of the CCS Web Service.
		Must be a valid URI format. Example: "https://example.com/CCSWebservice/CCS.asmx"

	.PARAMETER CCSCredential
		The credentials used to authenticate with the CCS Web Service.

	.PARAMETER DomainCredential
		The credentials of an account with permissions to query Active Directory.
		If not defined, it will run in the CCS Web Service context.

	.PARAMETER PasswordIsEncrypted
		Indicates if the password in the DomainCredential is encrypted. Default is $false.

	.EXAMPLE
		PS C:\> Get-CCSADLastLoginForComputers -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Retrieves last login information for all computers in the domain using default CCS context.

	.EXAMPLE
		PS C:\> Get-CCSADLastLoginForComputers -DomainOUPath "OU=Computers,DC=example,DC=com" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential -DomainCredential $DomainCredential

		Retrieves last login information for all computers in a specific OU using domain credentials.

	.EXAMPLE
		PS C:\> Get-CCSADLastLoginForComputers -DomainOUPath "LDAP://DC01.Firmax.local/OU=Servers,DC=FirmaX,DC=local" -Domain "Firmax.local" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Retrieves last login information using LDAP format for the OU path. The LDAP path will be automatically converted to standard DN format.

	.EXAMPLE
		PS C:\> $computers = Get-CCSADLastLoginForComputers -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential
		PS C:\> $computers | Where-Object { $_.LastLogon -lt (Get-Date).AddDays(-30) }

		Retrieves all computers and filters for those that haven't logged in for 30 days.

	.OUTPUTS
		System.Collections.Generic.List[ADComputerInfo]
		Returns a list of ADComputerInfo objects containing:
		- Name: Computer name
		- LastLogon: Last logon timestamp
		- LastLogonDC: Domain controller where last logon occurred
		- OperatingSystem: Operating system version
		- Path: Active Directory path

	.NOTES
		This is an advanced function with comprehensive error handling.
		The function returns a strongly-typed list of computer objects from Active Directory.
	#>
	[CmdletBinding()]
	[OutputType([System.Collections.Generic.List[PSCustomObject]])]
	param (
		[Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
		[ValidateScript({
				if ([string]::IsNullOrEmpty($_)) {
					return $true
				}
				# Support standard DN format: OU=...,DC=...,DC=...
				if ($_ -match '^(OU=.*,)?(DC=.+)(,DC=.+)*$') {
					return $true
				}
				# Support LDAP format: LDAP://server/DN
				if ($_ -match '^LDAP://[^/]+/(OU=.*,)?(DC=.+)(,DC=.+)*$') {
					return $true
				}
				throw "DomainOUPath must be in format 'OU=...,DC=...,DC=...' or 'LDAP://server/OU=...,DC=...,DC=...' or empty"
			})]
		[Alias('OU', 'Path', 'SearchBase')]
		[string]$DomainOUPath = '',

		[Parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			HelpMessage = 'Enter the domain name'
		)]
		[ValidateNotNullOrEmpty()]
		[ValidatePattern('^([a-zA-Z0-9]([a-zA-Z0-9\-]{0,61}[a-zA-Z0-9])?\.)+[a-zA-Z]{2,}$')]
		[string]$Domain,

		[Parameter(
			Mandatory = $true,
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
		[Alias('WebServiceUrl', 'Uri')]
		[string]$Url,

		[Parameter(
			Mandatory = $true,
			HelpMessage = 'Enter the CCS Web Service credentials'
		)]
		[ValidateNotNull()]
		[Alias('Credential', 'WebServiceCredential')]
		[pscredential]$CCSCredential,

		[Parameter(Mandatory = $false)]
		[ValidateNotNull()]
		[Alias('ADCredential')]
		[pscredential]$DomainCredential,

		[Parameter(Mandatory = $false)]
		[Alias('Encrypted')]
		[switch]$PasswordIsEncrypted
	)

	begin {
		$FunctionName = $PSCmdlet.MyInvocation.MyCommand.Name

		Write-Verbose "[$FunctionName] Starting function execution"
		Write-Verbose "[$FunctionName] Domain: $Domain"
		Write-Verbose "[$FunctionName] DomainOUPath: $DomainOUPath"
		Write-Verbose "[$FunctionName] URL: $Url"

		# Initialize CCS connection once in begin block
		try {
			Write-Verbose "[$FunctionName] Initializing CCS Web Service connection"
			$CCS = Initialize-CCS -Url $Url -WebServiceCredential $CCSCredential -ErrorAction Stop
		} catch {
			Invoke-CCSErrorHandling `
				-ErrorMessage "Failed to initialize CCS Web Service: $_" `
				-ErrorCategory ConnectionError `
				-TargetObject $Url `
				-FunctionName $FunctionName `
				-Exception $_.Exception `
				-RecommendedAction "Verify the URL is correct and the CCS Web Service is accessible. Check credentials."
		}

		# Prepare domain credentials if provided
		$ADUsername = $null
		$ADPassword = $null

		if ($DomainCredential) {
			$ADUsername = $DomainCredential.UserName
			Write-Verbose "[$FunctionName] Using domain credential: $ADUsername"

			try {
				if ($PasswordIsEncrypted) {
					$ADPassword = $DomainCredential.GetNetworkCredential().Password
					Write-Verbose "[$FunctionName] Using pre-encrypted password"
				} else {
					$ADPassword = Get-CCSEncryptedPassword -SecureString $DomainCredential.Password -ErrorAction Stop
					Write-Verbose "[$FunctionName] Password encrypted successfully"
				}
			} catch {
				Invoke-CCSErrorHandling `
					-ErrorMessage "Failed to process domain credential password: $_" `
					-ErrorCategory SecurityError `
					-FunctionName $FunctionName `
					-Exception $_.Exception `
					-RecommendedAction "Ensure the domain credential is valid and the password can be encrypted."
			}
		} else {
			Write-Verbose "[$FunctionName] No domain credential provided, using CCS Web Service context"
		}
	}

	process {
		try {
			Write-Verbose "[$FunctionName] Querying Active Directory for computer last login information"

			if ($Global:Cs) {
				$Global:Cs.Job_WriteLog("$FunctionName Processing: DomainOUPath=$DomainOUPath, Domain=$Domain")
			}

			Write-Verbose "[$FunctionName] Calling ActiveDirectory_GetLastloginForComputers"

			$Result = $CCS.ActiveDirectory_GetLastloginForComputers(
				$DomainOUPath,
				$Domain,
				$ADUsername,
				$ADPassword
			)

			Write-Debug "Result from CCS Web Service: $($Result.Count) computers retrieved"

			if ($Global:Cs) {
				$Global:Cs.Job_WriteLog("$FunctionName Result: Retrieved $($Result.Count) computers")
			}

			Write-Verbose "[$FunctionName] Retrieved $($Result.Count) computers"

			# Check if result is null or empty
			if ($null -eq $Result) {
				Invoke-CCSErrorHandling `
					-ErrorMessage "No data returned from CCS Web Service" `
					-ErrorCategory ObjectNotFound `
					-TargetObject $Domain `
					-FunctionName $FunctionName `
					-RecommendedAction "Verify the domain and OU path are correct and contain computers."
				return
			}

			# Convert the result to PSCustomObject for better PowerShell compatibility
			foreach ($Computer in $Result) {
				$ComputerObject = [PSCustomObject]@{
					Name            = $Computer.Name
					LastLogon       = $Computer.LastLogon
					LastLogonDC     = $Computer.LastLogonDC
					OperatingSystem = $Computer.OperatingSystem
					Path            = $Computer.Path
				}

				# Add custom type name for formatting
				$ComputerObject.PSObject.TypeNames.Insert(0, 'CCS.ADComputerInfo')

				Write-Output $ComputerObject
			}

			Write-Verbose "[$FunctionName] Successfully retrieved last login information for $($Result.Count) computers"

		} catch {
			# Determine if we should throw based on the ErrorAction preference
			$ShouldThrow = $false
			if ($PSBoundParameters.ContainsKey('ErrorAction')) {
				$ShouldThrow = $PSBoundParameters['ErrorAction'] -eq 'Stop'
				Write-Debug "ErrorAction from PSBoundParameters: $($PSBoundParameters['ErrorAction'])"
			} else {
				$ShouldThrow = $ErrorActionPreference -eq 'Stop'
				Write-Debug "ErrorAction from ErrorActionPreference: $ErrorActionPreference"
			}
			Write-Debug "ShouldThrow is set to: $ShouldThrow"

			Invoke-CCSErrorHandling `
				-ErrorMessage "Exception occurred while retrieving computer information: $_" `
				-ErrorCategory InvalidOperation `
				-TargetObject $Domain `
				-FunctionName $FunctionName `
				-Exception $_.Exception `
				-RecommendedAction "Check the error details and verify all parameters are correct." `
				-Throw:$ShouldThrow
		}
	}

	end {
		Write-Verbose "[$FunctionName] Function execution completed"

		if ($Global:Cs) {
			$Global:Cs.Job_WriteLog("$FunctionName Completed")
		}
	}
}
