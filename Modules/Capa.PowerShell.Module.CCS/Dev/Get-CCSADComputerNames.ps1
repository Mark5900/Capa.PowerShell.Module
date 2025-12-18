function Get-CCSADComputerNames {
	<#
	.SYNOPSIS
		Gets computer names from Active Directory using the CCS Web Service.

	.DESCRIPTION
		Gets computer names from Active Directory using the CCS Web Service.
		This advanced function includes comprehensive error handling, input validation, and supports pipeline input.

	.PARAMETER DomainOUPath
		The Organizational Unit (OU) path of the domain where the computers reside. Supports both standard DN format (OU=Computers,DC=example,DC=com) and LDAP format (LDAP://DC01.example.local/OU=Computers,DC=example,DC=com).

	.PARAMETER Domain
		The domain name where the computers reside. Must be a valid domain name format.

	.PARAMETER Url
		The URL of the CCS Web Service. Must be a valid URI format. Example: "https://example.com/CCSWebservice/CCS.asmx"

	.PARAMETER CCSCredential
		The credentials for the CCS Web Service.

	.PARAMETER DomainCredential
		The credentials for the domain where the computers reside. If not defined, it will run in the CCS Web Service context.

	.PARAMETER PasswordIsEncrypted
		Indicates whether the password is encrypted. Default is $false.

	.EXAMPLE
		PS C:\> Get-CCSADComputerNames -DomainOUPath "OU=Test,DC=FirmaX,DC=local" -Domain "FirmaX.local" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $ccsCredential -DomainCredential $domainCredential

	.OUTPUTS
		System.String[]
		Returns an array of computer names from the CCS Web Service operation.

	.NOTES
		This is an advanced function with support for ShouldProcess, pipeline input, and comprehensive error handling.
	#>
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
	[OutputType([string[]])]
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
		[Alias('OU', 'Path')]
		[string]$DomainOUPath = '',

		[Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Enter the domain name')]
		[ValidateNotNullOrEmpty()]
		[ValidatePattern('^([a-zA-Z0-9]([a-zA-Z0-9\-]{0,61}[a-zA-Z0-9])?\.)+[a-zA-Z]{2,}$')]
		[string]$Domain,

		[Parameter(Mandatory = $true, HelpMessage = 'Enter the CCS Web Service URL')]
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

		[Parameter(Mandatory = $true, HelpMessage = 'Enter the CCS Web Service credentials')]
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
					$ADPassword = Get-CCSEncryptedPassword -String $DomainCredential.GetNetworkCredential().Password -ErrorAction Stop
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
		# ShouldProcess support
		$WhatIfMessage = "Get computer names from domain '$Domain'"
		if ($PSCmdlet.ShouldProcess($Domain, $WhatIfMessage)) {
			try {
				Write-Verbose "[$FunctionName] Calling ActiveDirectory_GetComputerNames"

				$Result = $CCS.ActiveDirectory_GetComputerNames(
					$DomainOUPath,
					$Domain,
					$ADUsername,
					$ADPassword
				)
				Write-Debug "Result from CCS Web Service: $Result"

				if ($Global:Cs) {
					$Global:Cs.Job_WriteLog("$FunctionName Result: $Result")
				}

				# Check for errors in result
				$IsError = Invoke-CCSIsError -Result $Result

				Write-Debug "IsError evaluation for result: $IsError"
				if ($IsError) {
					# Determine appropriate error category based on result message
					$ErrorCat = [System.Management.Automation.ErrorCategory]::OperationStopped
					$RecommendedActionText = "Verify the OU, domain, and credentials are correct."

					if ($Result -like '*does not exist*') {
						$ErrorCat = [System.Management.Automation.ErrorCategory]::ObjectNotFound
						$RecommendedActionText = "Verify that the OU and domain exist."
					} elseif ($Result -like '*unwilling to process*') {
						$ErrorCat = [System.Management.Automation.ErrorCategory]::PermissionDenied
						$RecommendedActionText = "Check that the domain credentials have sufficient permissions."
					}

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
						-ErrorMessage "Failed to get computer names: $Result" `
						-ErrorCategory $ErrorCat `
						-TargetObject $Domain `
						-FunctionName $FunctionName `
						-RecommendedAction $RecommendedActionText `
						-Throw:$ShouldThrow
				} else {
					Write-Verbose "[$FunctionName] Successfully retrieved computer names"
					return $Result
				}
			} catch {
				# Determine if we should throw based on the ErrorAction preference
				$ShouldThrow = $false
				if ($PSBoundParameters.ContainsKey('ErrorAction')) {
					$ShouldThrow = $PSBoundParameters['ErrorAction'] -eq 'Stop'
				} else {
					$ShouldThrow = $ErrorActionPreference -eq 'Stop'
				}

				Invoke-CCSErrorHandling `
					-ErrorMessage "Exception occurred while retrieving computer names: $_" `
					-ErrorCategory InvalidOperation `
					-TargetObject $Domain `
					-FunctionName $FunctionName `
					-Exception $_.Exception `
					-RecommendedAction "Check the error details and verify all parameters are correct." `
					-Throw:$ShouldThrow
			}
		} else {
			Write-Verbose "[$FunctionName] WhatIf: Would get computer names from $Domain"
		}
	}
}