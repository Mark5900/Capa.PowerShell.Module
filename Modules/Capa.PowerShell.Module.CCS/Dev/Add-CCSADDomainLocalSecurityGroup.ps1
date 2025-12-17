function Add-CCSADDomainLocalSecurityGroup {
	<#
	.SYNOPSIS
		Creates a domain local security group in Active Directory using the CCS Web Service.

	.DESCRIPTION
		Creates a domain local security group in Active Directory using the CCS Web Service.
		This advanced function includes comprehensive error handling, input validation, and supports pipeline input.

	.PARAMETER GroupName
		The name of the security group to be created.

	.PARAMETER Description
		A description for the security group.

	.PARAMETER DomainOUPath
		The Organizational Unit (OU) path in which the security group will be created.
		Supports both standard DN format (OU=Groups,DC=example,DC=com) and LDAP format (LDAP://DC01.example.local/OU=Groups,DC=example,DC=com).

	.PARAMETER Domain
		The domain in which the security group will be created.
		Must be a valid domain name format.

	.PARAMETER Url
		The URL of the CCS Web Service.
		Must be a valid URI format. Example: "https://example.com/CCSWebservice/CCS.asmx"

	.PARAMETER CCSCredential
		The credentials used to authenticate with the CCS Web Service.

	.PARAMETER DomainCredential
		The credentials of an account with permissions to create the security group.
		If not defined, it will run in the CCS Web Service context.

	.PARAMETER PasswordIsEncrypted
		Indicates if the password in the DomainCredential is encrypted. Default is $false.

	.EXAMPLE
		PS C:\> Add-CCSADDomainLocalSecurityGroup -GroupName "TestGroup" -Description "Test Description" -DomainOUPath "OU=Groups,DC=example,DC=com" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

	.OUTPUTS
		System.String
		Returns the result message from the CCS Web Service operation.

	.NOTES
		This is an advanced function with support for ShouldProcess, pipeline input, and comprehensive error handling.
	#>
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
	[OutputType([string])]
	param (
		[Parameter(
			Mandatory = $true,
			Position = 0,
			ValueFromPipeline = $true,
			ValueFromPipelineByPropertyName = $true,
			HelpMessage = 'Enter the group name to create'
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('Name', 'Group')]
		[string[]]$GroupName,

		[Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
		[Alias('Desc')]
		[string]$Description = '',

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
		Write-Verbose "[$FunctionName] Description: $Description"
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

		$ProcessedCount = 0
		$SuccessCount = 0
		$FailureCount = 0
	}

	process {
		foreach ($Group in $GroupName) {
			$ProcessedCount++

			try {
				Write-Verbose "[$FunctionName] Processing group: $Group ($ProcessedCount)"

				if ($Global:Cs) {
					$Global:Cs.Job_WriteLog("$FunctionName Processing: GroupName=$Group, Description=$Description, DomainOUPath=$DomainOUPath, Domain=$Domain")
				}

				# ShouldProcess support
				$WhatIfMessage = "Create domain local security group '$Group' in domain '$Domain'"
				if ($PSCmdlet.ShouldProcess($Group, $WhatIfMessage)) {
					Write-Verbose "[$FunctionName] Calling ActiveDirectory_AddDomainLocalSecurityGroup for $Group"

					$Result = $CCS.ActiveDirectory_AddDomainLocalSecurityGroup(
						$Group,
						$Description,
						$DomainOUPath,
						$Domain,
						$ADUsername,
						$ADPassword
					)
					Write-Debug "Result from CCS Web Service: $Result"

					if ($Global:Cs) {
						$Global:Cs.Job_WriteLog("$FunctionName Result for $Group : $Result")
					}

					Write-Verbose "[$FunctionName] Result for $Group : $Result"

					# Check for errors in result
					$IsError = Invoke-CCSIsError -Result $Result

					Write-Debug "IsError evaluation for result: $IsError"
					if ($IsError) {
						$FailureCount++

						# Determine appropriate error category based on result message
						$ErrorCat = [System.Management.Automation.ErrorCategory]::OperationStopped
						$RecommendedActionText = "Verify the group name and parameters are correct."

						if ($Result -like '*already exists*') {
							$ErrorCat = [System.Management.Automation.ErrorCategory]::ResourceExists
							$RecommendedActionText = "The group already exists."
						} elseif ($Result -like '*does not exist*') {
							$ErrorCat = [System.Management.Automation.ErrorCategory]::ObjectNotFound
							$RecommendedActionText = "Verify that the OU and domain exist."
						} elseif ($Result -like '*unwilling to process*') {
							$ErrorCat = [System.Management.Automation.ErrorCategory]::PermissionDenied
							$RecommendedActionText = "Check that the domain credentials have sufficient permissions to create the group."
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
							-ErrorMessage "Failed to create domain local security group '$Group': $Result" `
							-ErrorCategory $ErrorCat `
							-TargetObject $Group `
							-FunctionName $FunctionName `
							-RecommendedAction $RecommendedActionText `
							-Throw:$ShouldThrow
					} else {
						$SuccessCount++
						Write-Verbose "[$FunctionName] Successfully created $Group"
						Write-Output $Result
					}
				} else {
					Write-Verbose "[$FunctionName] WhatIf: Would create $Group"
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
					-ErrorMessage "Exception occurred while processing group '$Group': $_" `
					-ErrorCategory InvalidOperation `
					-TargetObject $Group `
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