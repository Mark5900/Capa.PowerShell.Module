function Get-CCSADCustomAttributeForUser {
	<#
	.SYNOPSIS
		Gets a custom attribute value for a user from Active Directory using the CCS Web Service.

	.DESCRIPTION
		Retrieves a custom attribute value for a user from Active Directory using the CCS Web Service.
		This advanced function includes comprehensive error handling, input validation, and supports pipeline input.

	.PARAMETER UserName
		The username of the user to retrieve the attribute for.
		Supports pipeline input and accepts multiple usernames.

	.PARAMETER Attribute
		The name of the custom attribute to retrieve.

	.PARAMETER DomainOUPath
		The Organizational Unit (OU) path in which the user resides.
		If not specified, searches the entire domain.
		Supports both standard DN format (OU=Users,DC=example,DC=com) and LDAP format (LDAP://DC01.example.local/OU=Users,DC=example,DC=com).

	.PARAMETER Domain
		The domain in which the user resides.
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
		PS C:\> Get-CCSADCustomAttributeForUser -UserName "jdoe" -Attribute "department" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Gets the department attribute for user jdoe using default CCS context.

	.EXAMPLE
		PS C:\> Get-CCSADCustomAttributeForUser -UserName "jdoe" -Attribute "extensionAttribute1" -DomainOUPath "OU=Users,DC=example,DC=com" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential -DomainCredential $DomainCredential

		Gets a custom extension attribute for user jdoe using specific domain credentials and OU path.

	.EXAMPLE
		PS C:\> "jdoe", "asmith", "bjones" | Get-CCSADCustomAttributeForUser -Attribute "employeeID" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Gets the employeeID attribute for multiple users using pipeline input.

	.EXAMPLE
		PS C:\> Get-CCSADCustomAttributeForUser -UserName "jdoe" -Attribute "title" -DomainOUPath "LDAP://DC01.Firmax.local/OU=Users,DC=FirmaX,DC=local" -Domain "Firmax.local" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Gets the title attribute for user jdoe using LDAP format for the OU path. The LDAP path will be automatically converted to standard DN format.

	.OUTPUTS
		System.String
		Returns the value of the specified custom attribute.

	.NOTES
		This is an advanced function with support for pipeline input and comprehensive error handling.
	#>
	[CmdletBinding()]
	[OutputType([string])]
	param (
		[Parameter(
			Mandatory = $true,
			Position = 0,
			ValueFromPipeline = $true,
			ValueFromPipelineByPropertyName = $true,
			HelpMessage = 'Enter the username to retrieve the attribute for'
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('User', 'SamAccountName', 'Identity')]
		[string[]]$UserName,

		[Parameter(
			Mandatory = $true,
			Position = 1,
			ValueFromPipelineByPropertyName = $true,
			HelpMessage = 'Enter the attribute name to retrieve'
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('AttributeName', 'Property')]
		[string]$Attribute,

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
		Write-Verbose "[$FunctionName] Attribute: $Attribute"
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

		$ProcessedCount = 0
		$SuccessCount = 0
		$FailureCount = 0
	}

	process {
		foreach ($User in $UserName) {
			$ProcessedCount++

			try {
				Write-Verbose "[$FunctionName] Processing user: $User ($ProcessedCount)"

				if ($Global:Cs) {
					$Global:Cs.Job_WriteLog("$FunctionName Processing: UserName=$User, Attribute=$Attribute, DomainOUPath=$DomainOUPath, Domain=$Domain")
				}

				Write-Verbose "[$FunctionName] Calling ActiveDirectory_GetCustomAttributeForUser for $User"

				$Result = $CCS.ActiveDirectory_GetCustomAttributeForUser(
					$User,
					$Attribute,
					$DomainOUPath,
					$Domain,
					$ADUsername,
					$ADPassword
				)

				Write-Debug "[$FunctionName] Result from CCS Web Service: $Result"

				if ($Global:Cs) {
					$Global:Cs.Job_WriteLog("$FunctionName Result for $User : $Result")
				}

				Write-Verbose "[$FunctionName] Attribute value for $User : $Result"

				# Check for errors in result
				if (Invoke-CCSIsError -Result $Result) {
					$FailureCount++

					# Determine if we should throw based on the ErrorAction preference
					$ShouldThrow = $false
					if ($PSBoundParameters.ContainsKey('ErrorAction')) {
						$ShouldThrow = $PSBoundParameters['ErrorAction'] -eq 'Stop'
						Write-Debug "[$FunctionName] ErrorAction from PSBoundParameters: $($PSBoundParameters['ErrorAction'])"
					} else {
						$ShouldThrow = $ErrorActionPreference -eq 'Stop'
						Write-Debug "[$FunctionName] ErrorAction from preference: $ErrorActionPreference"
					}
					Write-Debug "[$FunctionName] ShouldThrow is set to: $ShouldThrow"

					Invoke-CCSErrorHandling `
						-ErrorMessage "Failed to get attribute '$Attribute' for user '$User': $Result" `
						-ErrorCategory ObjectNotFound `
						-TargetObject $User `
						-FunctionName $FunctionName `
						-RecommendedAction "Verify the username is correct and exists in Active Directory. Check that the attribute exists. Check domain credentials if provided." `
						-Throw:$ShouldThrow
				} else {
					$SuccessCount++
					Write-Output $Result
				}
			} catch {
				$FailureCount++

				# Determine if we should throw based on the ErrorAction preference
				$ShouldThrow = $false
				if ($PSBoundParameters.ContainsKey('ErrorAction')) {
					$ShouldThrow = $PSBoundParameters['ErrorAction'] -eq 'Stop'
				} else {
					$ShouldThrow = $ErrorActionPreference -eq 'Stop'
				}

				Invoke-CCSErrorHandling `
					-ErrorMessage "Exception occurred while processing user '$User': $_" `
					-ErrorCategory InvalidOperation `
					-TargetObject $User `
					-FunctionName $FunctionName `
					-Exception $_.Exception `
					-RecommendedAction "Check the error details and verify all parameters are correct." `
					-Throw:$ShouldThrow
			}
		}
	}

	end {
		Write-Verbose "[$FunctionName] Function execution completed"
		Write-Verbose "[$FunctionName] Total processed: $ProcessedCount | Success: $SuccessCount | Failed: $FailureCount"

		if ($Global:Cs) {
			$Global:Cs.Job_WriteLog("$FunctionName Summary - Processed: $ProcessedCount, Success: $SuccessCount, Failed: $FailureCount")
		}
	}
}
