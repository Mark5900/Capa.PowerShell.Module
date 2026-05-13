function Create-CCSADSecurityGroupsForShares {
	<#
	.SYNOPSIS
		Creates Active Directory security groups for network shares using the CCS Web Service.

	.DESCRIPTION
		Creates Active Directory security groups for network shares using the CCS Web Service.
		This advanced function includes comprehensive error handling, input validation, and supports creating both read and read/write groups.
		The function can automatically create security groups based on share names with customizable group name and description formats.

	.PARAMETER DomainOUPath
		The Organizational Unit (OU) path where the security groups will be created.
		If not specified, groups will be created in the default location.
		Supports both standard DN format (OU=Groups,DC=example,DC=com) and LDAP format (LDAP://DC01.example.local/OU=Groups,DC=example,DC=com).

	.PARAMETER Domain
		The domain in which the security groups will be created.
		Must be a valid domain name format.

	.PARAMETER Url
		The URL of the CCS Web Service.
		Must be a valid HTTPS URI format. Example: "https://example.com/CCSWebservice/CCS.asmx"

	.PARAMETER CCSCredential
		The credentials used to authenticate with the CCS Web Service.

	.PARAMETER DomainCredential
		The credentials of an account with permissions to create security groups in Active Directory.
		If not defined, it will run in the CCS Web Service context.

	.PARAMETER GroupFormat
		The format string for the group name. Use placeholders: $sharename$, $sharecaption$
		Example: "Share_$sharename$" will create groups like "Share_Data_R" and "Share_Data_RW"

	.PARAMETER GroupDescriptionFormat
		The format string for the group description. Use placeholders: $sharename$, $sharecaption$, $shareunc$, $localpath$
		Example: "Access to $sharename$ share at $shareunc$"

	.PARAMETER CreateReadGroup
		If specified, creates a read-only group (suffix: _R) for each share.

	.PARAMETER CreateReadWriteGroup
		If specified, creates a read/write group (suffix: _RW) for each share.

	.PARAMETER ExcludeStandardShares
		If specified, excludes standard Windows shares (C$, ADMIN$, IPC$, etc.) from group creation.

	.PARAMETER PasswordIsEncrypted
		Indicates if the password in the DomainCredential is encrypted. Default is $false.

	.EXAMPLE
		PS C:\> Create-CCSADSecurityGroupsForShares -GroupFormat "Share_`$sharename`$" -GroupDescriptionFormat "Access to `$sharename`$" -CreateReadGroup -CreateReadWriteGroup -ExcludeStandardShares -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Creates both read and read/write groups for all shares (excluding standard shares) using default CCS context.

	.EXAMPLE
		PS C:\> Create-CCSADSecurityGroupsForShares -DomainOUPath "OU=ShareGroups,DC=example,DC=com" -GroupFormat "FS_`$sharename`$" -GroupDescriptionFormat "File share: `$sharename`$ (`$localpath`$)" -CreateReadGroup -CreateReadWriteGroup -ExcludeStandardShares -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential -DomainCredential $DomainCredential

		Creates groups in a specific OU with custom format including local path in description.

	.EXAMPLE
		PS C:\> Create-CCSADSecurityGroupsForShares -GroupFormat "RO_`$sharename`$" -GroupDescriptionFormat "Read-only access to `$shareunc`$" -CreateReadGroup -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Creates only read groups for all shares.

	.OUTPUTS
		System.String
		Returns the result message from the CCS Web Service operation.

	.NOTES
		This is an advanced function with support for ShouldProcess, comprehensive error handling, and detailed logging.
		Group name suffixes: _R (read-only), _RW (read/write)
		Available placeholders: $sharename$, $sharecaption$, $shareunc$, $localpath$
	#>
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
	[OutputType([string])]
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
		[ValidateNotNullOrEmpty()]
		[ValidateScript({
				if ($_ -is [System.Management.Automation.PSCredential]) {
					$true
				} else {
					throw "CCSCredential must be a PSCredential object"
				}
			})]
		[Alias('Credential', 'WebServiceCredential')]
		[pscredential]$CCSCredential,

		[Parameter(Mandatory = $false)]
		[ValidateNotNull()]
		[Alias('ADCredential')]
		[pscredential]$DomainCredential,

		[Parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			HelpMessage = 'Enter the group name format (use $sharename$ or $sharecaption$ as placeholders)'
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('Format', 'NameFormat')]
		[string]$GroupFormat,

		[Parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			HelpMessage = 'Enter the group description format (use $sharename$, $sharecaption$, $shareunc$, or $localpath$ as placeholders)'
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('DescriptionFormat', 'Description')]
		[string]$GroupDescriptionFormat,

		[Parameter(Mandatory = $false)]
		[Alias('Read', 'ReadOnly')]
		[switch]$CreateReadGroup,

		[Parameter(Mandatory = $false)]
		[Alias('ReadWrite', 'RW')]
		[switch]$CreateReadWriteGroup,

		[Parameter(Mandatory = $false)]
		[Alias('ExcludeStandard', 'SkipStandardShares')]
		[switch]$ExcludeStandardShares,

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
		Write-Verbose "[$FunctionName] GroupFormat: $GroupFormat"
		Write-Verbose "[$FunctionName] GroupDescriptionFormat: $GroupDescriptionFormat"
		Write-Verbose "[$FunctionName] CreateReadGroup: $CreateReadGroup"
		Write-Verbose "[$FunctionName] CreateReadWriteGroup: $CreateReadWriteGroup"
		Write-Verbose "[$FunctionName] ExcludeStandardShares: $ExcludeStandardShares"

		# Validate that at least one group type is selected
		if (-not $CreateReadGroup -and -not $CreateReadWriteGroup) {
			$msg = "At least one of CreateReadGroup or CreateReadWriteGroup must be specified"
			Write-Error $msg
			throw $msg
		}

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
					$SecurePassword = ConvertTo-SecureString $DomainCredential.GetNetworkCredential().Password -AsPlainText -Force
					$ADPassword = Get-CCSEncryptedPassword -SecureString $SecurePassword -ErrorAction Stop
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
			if ($Global:Cs) {
				$Global:Cs.Job_WriteLog("$FunctionName Processing: DomainOUPath=$DomainOUPath, Domain=$Domain, GroupFormat=$GroupFormat, CreateReadGroup=$CreateReadGroup, CreateReadWriteGroup=$CreateReadWriteGroup, ExcludeStandardShares=$ExcludeStandardShares")
			}

			# ShouldProcess support
			$WhatIfMessage = "Create security groups for shares in domain '$Domain' using format '$GroupFormat'"
			if ($PSCmdlet.ShouldProcess($Domain, $WhatIfMessage)) {
				Write-Verbose "[$FunctionName] Calling ActiveDirectory_CreateSecurityGroupsForShares"

				$Result = $CCS.ActiveDirectory_CreateSecurityGroupsForShares(
					$DomainOUPath,
					$Domain,
					$ADUsername,
					$ADPassword,
					$GroupFormat,
					$GroupDescriptionFormat,
					$CreateReadGroup.IsPresent,
					$CreateReadWriteGroup.IsPresent,
					$ExcludeStandardShares.IsPresent
				)
				Write-Debug "Result from CCS Web Service: $Result"

				if ($Global:Cs) {
					$Global:Cs.Job_WriteLog("$FunctionName Result: $Result")
				}

				Write-Verbose "[$FunctionName] Result: $Result"

				# Check for errors in result
				$IsError = Invoke-CCSIsError -Result $Result

				Write-Debug "IsError evaluation for result: $IsError"
				if ($IsError) {
					# Determine appropriate error category based on result message
					$ErrorCat = [System.Management.Automation.ErrorCategory]::OperationStopped
					$RecommendedActionText = "Verify the domain and OU path are correct."

					if ($Result -like '*does not exist*' -or $Result -like '*not found*') {
						$ErrorCat = [System.Management.Automation.ErrorCategory]::ObjectNotFound
						$RecommendedActionText = "Verify that the domain and OU path exist in Active Directory."
					} elseif ($Result -like '*unwilling to process*' -or $Result -like '*permission*' -or $Result -like '*access*denied*') {
						$ErrorCat = [System.Management.Automation.ErrorCategory]::PermissionDenied
						$RecommendedActionText = "Check that the domain credentials have sufficient permissions to create security groups."
					} elseif ($Result -like '*already exists*') {
						$ErrorCat = [System.Management.Automation.ErrorCategory]::ResourceExists
						$RecommendedActionText = "One or more groups already exist. Consider using different group format."
					} elseif ($Result -like '*invalid*format*') {
						$ErrorCat = [System.Management.Automation.ErrorCategory]::InvalidArgument
						$RecommendedActionText = "Check the GroupFormat and GroupDescriptionFormat parameters for valid placeholders."
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
						-ErrorMessage "Failed to create security groups for shares: $Result" `
						-ErrorCategory $ErrorCat `
						-TargetObject $Domain `
						-FunctionName $FunctionName `
						-RecommendedAction $RecommendedActionText `
						-Throw:$ShouldThrow
				} else {
					Write-Verbose "[$FunctionName] Successfully created security groups for shares"
					Write-Output $Result
				}
			} else {
				Write-Verbose "[$FunctionName] WhatIf: Would create security groups for shares in domain '$Domain'"
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
				-ErrorMessage "Exception occurred while creating security groups for shares: $_" `
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
			$Global:Cs.Job_WriteLog("$FunctionName Summary - Completed")
		}
	}
}
