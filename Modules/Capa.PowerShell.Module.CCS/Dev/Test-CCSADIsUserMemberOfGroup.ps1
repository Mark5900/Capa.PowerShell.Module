function Test-CCSADIsUserMemberOfGroup {
	<#
	.SYNOPSIS
		Tests if a user is a member of a security group in Active Directory using the CCS Web Service.

	.DESCRIPTION
		Tests if a user is a member of a security group in Active Directory using the CCS Web Service.
		This advanced function includes comprehensive error handling and input validation.

	.PARAMETER UserName
		The username to check for group membership.
		This should be the user's login name (samAccountName).

	.PARAMETER GroupName
		The name of the security group to check membership for.

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
		The credentials of the user account to check for group membership.
		If not provided, uses the CCS Web Service context.

	.PARAMETER PasswordIsEncrypted
		Indicates if the password in the DomainCredential is encrypted. Default is $false.

	.EXAMPLE
		PS C:\> Test-CCSADIsUserMemberOfGroup -UserName "jdoe" -GroupName "IT-Admins" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Tests if user 'jdoe' is a member of 'IT-Admins' group using default CCS context.

	.EXAMPLE
		PS C:\> Test-CCSADIsUserMemberOfGroup -UserName "jdoe" -GroupName "IT-Admins" -DomainOUPath "OU=Users,DC=example,DC=com" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential -DomainCredential $DomainCredential

		Tests if user 'jdoe' is a member of 'IT-Admins' group using specific domain credentials and OU path.

	.EXAMPLE
		PS C:\> Test-CCSADIsUserMemberOfGroup -UserName "jdoe" -GroupName "IT-Admins" -DomainOUPath "LDAP://DC01.Firmax.local/DC=Firmax,DC=local" -Domain "Firmax.local" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Tests group membership using LDAP format for the OU path. The LDAP path will be automatically converted to standard DN format.

	.OUTPUTS
		System.Boolean
		Returns $true if the user is a member of the group, $false otherwise.

	.NOTES
		This is an advanced function with comprehensive error handling.
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19306246741/ActiveDirectory+isUserMemberOf

	.LINK
		https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19306246741/ActiveDirectory+isUserMemberOf
	#>
	[CmdletBinding()]
	[OutputType([System.Boolean])]
	param (
		[Parameter(
			Mandatory = $true,
			Position = 0,
			ValueFromPipeline = $true,
			ValueFromPipelineByPropertyName = $true,
			HelpMessage = 'Enter the username to check for group membership'
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('Name', 'User', 'SamAccountName')]
		[string]$UserName,

		[Parameter(
			Mandatory = $true,
			Position = 1,
			ValueFromPipelineByPropertyName = $true,
			HelpMessage = 'Enter the security group name'
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('Group', 'SecurityGroupName')]
		[string]$GroupName,

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
		[Alias('OU', 'Path')]
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
		Write-Verbose "[$FunctionName] UserName: $UserName"
		Write-Verbose "[$FunctionName] GroupName: $GroupName"
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
			return
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
				return
			}
		} else {
			Write-Verbose "[$FunctionName] No domain credential provided, using CCS Web Service context"
			$ADUsername = $UserName
			$ADPassword = ''
		}

		# Convert LDAP path to DN if needed
		if (-not [string]::IsNullOrEmpty($DomainOUPath) -and $DomainOUPath -match '^LDAP://[^/]+/(.+)$') {
			$DomainOUPath = $Matches[1]
			Write-Verbose "[$FunctionName] Converted LDAP path to DN: $DomainOUPath"
		}
	}

	process {
		try {
			Write-Verbose "[$FunctionName] Checking if user '$UserName' is member of group '$GroupName'"

			if ($Global:Cs) {
				$Global:Cs.Job_WriteLog("$FunctionName Processing: UserName=$UserName, GroupName=$GroupName, DomainOUPath=$DomainOUPath, Domain=$Domain")
			}

			Write-Verbose "[$FunctionName] Calling ActiveDirectory_isUserMemberOf for $UserName"

			$Result = $CCS.ActiveDirectory_isUserMemberOf(
				$DomainOUPath,
				$Domain,
				$ADUsername,
				$ADPassword,
				$GroupName
			)

			Write-Debug "Result from CCS Web Service: $Result"

			if ($Global:Cs) {
				$Global:Cs.Job_WriteLog("$FunctionName Result for $UserName : $Result")
			}

			Write-Verbose "[$FunctionName] Result for $UserName : $Result"

			# Return the boolean result
			Write-Output $Result

		} catch {
			# Determine if we should throw based on the ErrorAction preference
			$ShouldThrow = $false
			if ($PSBoundParameters.ContainsKey('ErrorAction')) {
				$ShouldThrow = $PSBoundParameters['ErrorAction'] -eq 'Stop'
			} else {
				$ShouldThrow = $ErrorActionPreference -eq 'Stop'
			}

			Invoke-CCSErrorHandling `
				-ErrorMessage "Exception occurred while checking group membership for user '$UserName': $_" `
				-ErrorCategory InvalidOperation `
				-TargetObject $UserName `
				-FunctionName $FunctionName `
				-Exception $_.Exception `
				-RecommendedAction "Check the error details and verify all parameters are correct." `
				-Throw:$ShouldThrow

			# Return false on error
			return $false
		}
	}

	end {
		Write-Verbose "[$FunctionName] Function execution completed"

		if ($Global:Cs) {
			$Global:Cs.Job_WriteLog("$FunctionName Completed")
		}
	}
}
