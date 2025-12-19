<#
	.SYNOPSIS
		Validates a user's credentials against Active Directory.

	.DESCRIPTION
		This function validates a user's credentials against Active Directory using the CCS Web Service.
		It can use either PrincipalContext-based validation or direct LDAP validation.

	.PARAMETER DomainOUPath
		The distinguished name or LDAP path of the OU where the user is located.
		If not specified, the entire domain will be searched.

	.PARAMETER Domain
		The domain name where the user is located.

	.PARAMETER Url
		The URL of the CCS Web Service, e.g., https://ccs.example.com/CCS.

	.PARAMETER CCSCredential
		The credentials used to connect to the CCS Web Service.

	.PARAMETER DomainCredential
		The credentials to validate against Active Directory.
		This is the user whose credentials you want to verify.

	.PARAMETER PasswordIsEncrypted
		Indicates whether the password in the credentials is already encrypted.

	.PARAMETER UsePrincipalContext
		When specified, uses PrincipalContext-based validation.
		When not specified, uses direct LDAP validation.
		Default is to use PrincipalContext.

	.EXAMPLE
		PS C:\> $CCSCred = Get-Credential
		PS C:\> $UserCred = Get-Credential
		PS C:\> Confirm-CCSADUser -Domain 'contoso.com' -Url 'https://ccs.contoso.com/CCS' -CCSCredential $CCSCred -DomainCredential $UserCred

		Validates the user credentials in $UserCred against the contoso.com domain using PrincipalContext validation.

	.EXAMPLE
		PS C:\> Confirm-CCSADUser -DomainOUPath 'OU=Users,DC=contoso,DC=com' -Domain 'contoso.com' -Url 'https://ccs.contoso.com/CCS' -CCSCredential $CCSCred -DomainCredential $UserCred

		Validates the user credentials against the specified OU in the contoso.com domain.

	.EXAMPLE
		PS C:\> Confirm-CCSADUser -Domain 'contoso.com' -Url 'https://ccs.contoso.com/CCS' -CCSCredential $CCSCred -DomainCredential $UserCred -UsePrincipalContext:$false

		Validates the user credentials using direct LDAP validation instead of PrincipalContext.

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19306246741/ActiveDirectory+ValidateUser

	.LINK
		https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19306246741/ActiveDirectory+ValidateUser
#>
function Confirm-CCSADUser {
	[CmdletBinding()]
	[OutputType([System.Boolean])]
    [Alias('Validate-CCSADUser')]
	param
	(
		[Parameter(Mandatory = $false)]
		[ValidateScript({
				if ([string]::IsNullOrWhiteSpace($_)) {
					$true
				} elseif ($_ -match '^(CN=|OU=|DC=)' -or $_ -match '^LDAP://[^/]+/(CN=|OU=|DC=)') {
					$true
				} else {
					throw "DomainOUPath must be a valid Distinguished Name (DN) or LDAP path starting with 'LDAP://server/DN'."
				}
			})]
		[string]$DomainOUPath,
		[Parameter(Mandatory = $true)]
		[ValidatePattern('^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')]
		[string]$Domain,
		[Parameter(Mandatory = $true)]
		[ValidateScript({
				if ($_ -match '^https://') {
					$true
				} else {
					throw "URL must start with 'https://'"
				}
			})]
		[string]$Url,
		[Parameter(Mandatory = $true)]
		[pscredential]$CCSCredential,
		[Parameter(Mandatory = $true, ValueFromPipeline = $true)]
		[pscredential]$DomainCredential,
		[Parameter(Mandatory = $false)]
		[switch]$PasswordIsEncrypted,
		[Parameter(Mandatory = $false)]
		[switch]$UsePrincipalContext = $true
	)

	begin {
		$FunctionName = $MyInvocation.MyCommand.Name
		Write-Verbose "[$FunctionName] Starting function"

		# Initialize CCS connection
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
			return
		}

		# Convert LDAP path to DN if needed
		if ($PSBoundParameters.ContainsKey('DomainOUPath')) {
			if ($DomainOUPath -match '^LDAP://[^/]+/(.+)$') {
				$DomainOUPath = $Matches[1]
				Write-Verbose "Converted LDAP path to DN: $DomainOUPath"
			}
		} else {
			$DomainOUPath = ''
			Write-Verbose "No DomainOUPath specified, will search entire domain"
		}

		# Extract domain username
		$DomainUser = $DomainCredential.UserName
		Write-Verbose "Validating credentials for user: $DomainUser"

		# Get encrypted password
		$DomainUserPwd = Get-CCSEncryptedPassword -SecureString $DomainCredential.Password

		$TotalProcessed = 0
		$TotalValid = 0
		$TotalInvalid = 0
	}

	process {
		try {
			Write-Verbose "Calling ActiveDirectory_ValidateUser for user '$DomainUser' with UsePrincipalContext=$($UsePrincipalContext.IsPresent)"

			# Call CCS Web Service
			$Result = $CCS.ActiveDirectory_ValidateUser(
				$DomainOUPath,
				$Domain,
				$DomainUser,
				$DomainUserPwd,
				$UsePrincipalContext.IsPresent
			)

			$TotalProcessed++

			if ($Result) {
				Write-Verbose "Credentials validated successfully for user '$DomainUser'"
				$TotalValid++
			} else {
				Write-Verbose "Credentials validation failed for user '$DomainUser'"
				$TotalInvalid++
			}

			# Return the boolean result
			return $Result

		} catch {
			Invoke-CCSErrorHandling `
				-ErrorMessage "Failed to validate user '$DomainUser': $_" `
				-ErrorCategory AuthenticationError `
				-TargetObject $DomainUser `
				-FunctionName $FunctionName `
				-Exception $_.Exception `
				-RecommendedAction "Verify the domain credentials are correct and the domain is accessible." `
				-Throw:$false

			$TotalProcessed++
			$TotalInvalid++
			return $false
		}
	}

	end {
		Write-Verbose "Completed credential validation"
		Write-Verbose "Total processed: $TotalProcessed"
		Write-Verbose "Valid credentials: $TotalValid"
		Write-Verbose "Invalid credentials: $TotalInvalid"
	}
}
