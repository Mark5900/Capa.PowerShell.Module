
function Add-CCSADComputerToSecurityGroup {
	<#
	.SYNOPSIS
		Adds a computer to a security group in Active Directory using the CCS Web Service.

	.DESCRIPTION
		Adds a computer to a security group in Active Directory using the CCS Web Service.
		This advanced function includes comprehensive error handling, input validation, and supports pipeline input.

	.PARAMETER ComputerName
		The name of the computer to be added to the security group.
		Supports pipeline input and accepts multiple computer names.

	.PARAMETER SecurityGroupName
		The name of the security group to which the computer will be added.

	.PARAMETER DomainOUPath
		The Organizational Unit (OU) path in which the computer resides.
		If not specified, searches the entire domain.
		Supports both standard DN format (OU=Computers,DC=example,DC=com) and LDAP format (LDAP://DC01.example.local/OU=Computers,DC=example,DC=com).

	.PARAMETER Domain
		The domain in which the computer resides.
		Must be a valid domain name format.

	.PARAMETER Url
		The URL of the CCS Web Service.
		Must be a valid URI format. Example: "https://example.com/CCSWebservice/CCS.asmx"

	.PARAMETER CCSCredential
		The credentials used to authenticate with the CCS Web Service.

	.PARAMETER DomainCredential
		The credentials of an account with permissions to add the computer to the security group.
		If not defined, it will run in the CCS Web Service context.

	.PARAMETER PasswordIsEncrypted
		Indicates if the password in the DomainCredential is encrypted. Default is $false.

	.EXAMPLE
		PS C:\> Add-CCSADComputerToSecurityGroup -ComputerName "TestPC" -SecurityGroupName "TestGroup" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Adds TestPC to TestGroup using default CCS context.

	.EXAMPLE
		PS C:\> Add-CCSADComputerToSecurityGroup -ComputerName "TestPC" -SecurityGroupName "TestGroup" -DomainOUPath "OU=Computers,DC=example,DC=com" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential -DomainCredential $DomainCredential

		Adds TestPC to TestGroup using specific domain credentials and OU path.

	.EXAMPLE
		PS C:\> "PC01", "PC02", "PC03" | Add-CCSADComputerToSecurityGroup -SecurityGroupName "TestGroup" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Adds multiple computers to TestGroup using pipeline input.

	.EXAMPLE
		PS C:\> Add-CCSADComputerToSecurityGroup -ComputerName "TestPC" -SecurityGroupName "TestGroup" -DomainOUPath "LDAP://DC01.Firmax.local/DC=FirmaX,DC=local" -Domain "Firmax.local" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Adds TestPC to TestGroup using LDAP format for the OU path. The LDAP path will be automatically converted to standard DN format.

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
			HelpMessage = 'Enter the computer name to add to the security group'
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('Name', 'Computer', 'CN')]
		[string[]]$ComputerName,

		[Parameter(
			Mandatory = $true,
			Position = 1,
			ValueFromPipelineByPropertyName = $true,
			HelpMessage = 'Enter the security group name'
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('GroupName', 'Group')]
		[string]$SecurityGroupName,

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
		Write-Verbose "[$FunctionName] SecurityGroupName: $SecurityGroupName"
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
		foreach ($Computer in $ComputerName) {
			$ProcessedCount++

			try {
				Write-Verbose "[$FunctionName] Processing computer: $Computer ($ProcessedCount)"

				if ($Global:Cs) {
					$Global:Cs.Job_WriteLog("$FunctionName Processing: ComputerName=$Computer, SecurityGroupName=$SecurityGroupName, DomainOUPath=$DomainOUPath, Domain=$Domain")
				}

				# ShouldProcess support
				$WhatIfMessage = "Add computer '$Computer' to security group '$SecurityGroupName' in domain '$Domain'"
				if ($PSCmdlet.ShouldProcess($Computer, $WhatIfMessage)) {
					Write-Verbose "[$FunctionName] Calling ActiveDirectory_AddComputerToSecurityGroup for $Computer"

					$Result = $CCS.ActiveDirectory_AddComputerToSecurityGroup(
						$Computer,
						$SecurityGroupName,
						$DomainOUPath,
						$Domain,
						$ADUsername,
						$ADPassword
					)
                    Write-Debug "Result from CCS Web Service: $Result"

					if ($Global:Cs) {
						$Global:Cs.Job_WriteLog("$FunctionName Result for $Computer : $Result")
					}

					Write-Verbose "[$FunctionName] Result for $Computer : $Result"

					# Check for errors in result
					$IsError = Invoke-CCSIsError -Result $Result

                    Write-Debug "IsError evaluation for result: $IsError"
					if ($IsError) {
						$FailureCount++

						# Determine appropriate error category based on result message
						$ErrorCat = [System.Management.Automation.ErrorCategory]::OperationStopped
						$RecommendedActionText = "Verify the computer and security group names are correct."

						if ($Result -like '*does not exist*') {
							$ErrorCat = [System.Management.Automation.ErrorCategory]::ObjectNotFound
							$RecommendedActionText = "Verify that the computer '$Computer' and security group '$SecurityGroupName' exist in Active Directory."
						} elseif ($Result -like '*unwilling to process*') {
							$ErrorCat = [System.Management.Automation.ErrorCategory]::PermissionDenied
							$RecommendedActionText = "Check that the domain credentials have sufficient permissions to modify the security group."
						} elseif ($Result -like '*already a member*') {
							$ErrorCat = [System.Management.Automation.ErrorCategory]::ResourceExists
					$RecommendedActionText = "The computer is already a member of the security group."
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
					-ErrorMessage "Failed to add computer '$Computer' to security group '$SecurityGroupName': $Result" `
					-ErrorCategory $ErrorCat `
					-TargetObject $Computer `
					-FunctionName $FunctionName `
					-RecommendedAction $RecommendedActionText `
					-Throw:$ShouldThrow
					} else {
						$SuccessCount++
						Write-Verbose "[$FunctionName] Successfully added $Computer to $SecurityGroupName"
						Write-Output $Result
					}
				} else {
					Write-Verbose "[$FunctionName] WhatIf: Would add $Computer to $SecurityGroupName"
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
				-ErrorMessage "Exception occurred while processing computer '$Computer': $_" `
				-ErrorCategory InvalidOperation `
				-TargetObject $Computer `
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


function Add-CCSADGlobalSecurityGroup {
	<#
	.SYNOPSIS
		Creates a global security group in Active Directory using the CCS Web Service.

	.DESCRIPTION
		Creates a global security group in Active Directory using the CCS Web Service.
		This advanced function includes comprehensive error handling, input validation, and supports pipeline input.

	.PARAMETER GroupName
		The name of the security group to be created. Supports pipeline input and accepts multiple group names.

	.PARAMETER Description
		A description for the security group.

	.PARAMETER DomainOUPath
		The Organizational Unit (OU) path in which the security group will be created.
		Supports both standard DN format (OU=Groups,DC=example,DC=com) and LDAP format (LDAP://DC01.example.local/OU=Groups,DC=example,DC=com).

	.PARAMETER Domain
		The domain in which the security group will be created. Must be a valid domain name format.

	.PARAMETER Url
		The URL of the CCS Web Service. Must be a valid URI format. Example: "https://example.com/CCSWebservice/CCS.asmx"

	.PARAMETER CCSCredential
		The credentials used to authenticate with the CCS Web Service.

	.PARAMETER DomainCredential
		The credentials of an account with permissions to create the security group. If not defined, it will run in the CCS Web Service context.

	.PARAMETER PasswordIsEncrypted
		Indicates if the password in the DomainCredential is encrypted. Default is $false.

	.EXAMPLE
		PS C:\> Add-CCSADGlobalSecurityGroup -GroupName "TestGroup" -Description "Test Description" -DomainOUPath "OU=Groups,DC=example,DC=com" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

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
				$WhatIfMessage = "Create global security group '$Group' in domain '$Domain'"
				if ($PSCmdlet.ShouldProcess($Group, $WhatIfMessage)) {
					Write-Verbose "[$FunctionName] Calling ActiveDirectory_AddGlobalSecurityGroup for $Group"

					$Result = $CCS.ActiveDirectory_AddGlobalSecurityGroup(
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
							-ErrorMessage "Failed to create global security group '$Group': $Result" `
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


function Add-CCSADUniversalSecurityGroup {
	<#
	.SYNOPSIS
		Creates a universal security group in Active Directory using the CCS Web Service.

	.DESCRIPTION
		Creates a universal security group in Active Directory using the CCS Web Service.
		This advanced function includes comprehensive error handling, input validation, and supports pipeline input.

	.PARAMETER GroupName
		The name of the security group to be created. Supports pipeline input and accepts multiple group names.

	.PARAMETER Description
		A description for the security group.

	.PARAMETER DomainOUPath
		The Organizational Unit (OU) path in which the security group will be created.
		Supports both standard DN format (OU=Groups,DC=example,DC=com) and LDAP format (LDAP://DC01.example.local/OU=Groups,DC=example,DC=com).

	.PARAMETER Domain
		The domain in which the security group will be created. Must be a valid domain name format.

	.PARAMETER Url
		The URL of the CCS Web Service. Must be a valid URI format. Example: "https://example.com/CCSWebservice/CCS.asmx"

	.PARAMETER CCSCredential
		The credentials used to authenticate with the CCS Web Service.

	.PARAMETER DomainCredential
		The credentials of an account with permissions to create the security group. If not defined, it will run in the CCS Web Service context.

	.PARAMETER PasswordIsEncrypted
		Indicates if the password in the DomainCredential is encrypted. Default is $false.

	.EXAMPLE
		PS C:\> Add-CCSADUniversalSecurityGroup -GroupName "TestGroup" -Description "Test Description" -DomainOUPath "OU=Groups,DC=example,DC=com" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

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
				$WhatIfMessage = "Create universal security group '$Group' in domain '$Domain'"
				if ($PSCmdlet.ShouldProcess($Group, $WhatIfMessage)) {
					Write-Verbose "[$FunctionName] Calling ActiveDirectory_AddUniversalSecurityGroup for $Group"

					$Result = $CCS.ActiveDirectory_AddUniversalSecurityGroup(
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
							-ErrorMessage "Failed to create universal security group '$Group': $Result" `
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


function Add-CCSADUserToSecurityGroup {
	<#
	.SYNOPSIS
		Adds a user to a security group in Active Directory using the CCS Web Service.

	.DESCRIPTION
		Adds a user to a security group in Active Directory using the CCS Web Service.
		This advanced function includes comprehensive error handling, input validation, and supports pipeline input.

	.PARAMETER UserName
		The username of the user to be added to the security group.
		Supports pipeline input and accepts multiple user names.

	.PARAMETER SecurityGroupName
		The name of the security group to which the user will be added.

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
		The credentials of an account with permissions to add the user to the security group.
		If not defined, it will run in the CCS Web Service context.

	.PARAMETER PasswordIsEncrypted
		Indicates if the password in the DomainCredential is encrypted. Default is $false.

	.EXAMPLE
		PS C:\> Add-CCSADUserToSecurityGroup -UserName "jdoe" -SecurityGroupName "Domain Users" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Adds user jdoe to Domain Users group using default CCS context.

	.EXAMPLE
		PS C:\> Add-CCSADUserToSecurityGroup -UserName "jdoe" -SecurityGroupName "Domain Users" -DomainOUPath "OU=Users,DC=example,DC=com" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential -DomainCredential $DomainCredential

		Adds user jdoe to Domain Users group using specific domain credentials and OU path.

	.EXAMPLE
		PS C:\> "jdoe", "asmith", "bwilson" | Add-CCSADUserToSecurityGroup -SecurityGroupName "Domain Users" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Adds multiple users to Domain Users group using pipeline input.

	.EXAMPLE
		PS C:\> Add-CCSADUserToSecurityGroup -UserName "jdoe" -SecurityGroupName "Domain Users" -DomainOUPath "LDAP://DC01.Firmax.local/OU=Users,DC=FirmaX,DC=local" -Domain "Firmax.local" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Adds user jdoe to Domain Users group using LDAP format for the OU path. The LDAP path will be automatically converted to standard DN format.

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
			HelpMessage = 'Enter the username to add to the security group'
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('Name', 'User', 'SamAccountName')]
		[string[]]$UserName,

		[Parameter(
			Mandatory = $true,
			Position = 1,
			ValueFromPipelineByPropertyName = $true,
			HelpMessage = 'Enter the security group name'
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('GroupName', 'Group')]
		[string]$SecurityGroupName,

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
		Write-Verbose "[$FunctionName] SecurityGroupName: $SecurityGroupName"
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
		foreach ($User in $UserName) {
			$ProcessedCount++

			try {
				Write-Verbose "[$FunctionName] Processing user: $User ($ProcessedCount)"

				if ($Global:Cs) {
					$Global:Cs.Job_WriteLog("$FunctionName Processing: UserName=$User, SecurityGroupName=$SecurityGroupName, DomainOUPath=$DomainOUPath, Domain=$Domain")
				}

				# ShouldProcess support
				$WhatIfMessage = "Add user '$User' to security group '$SecurityGroupName' in domain '$Domain'"
				if ($PSCmdlet.ShouldProcess($User, $WhatIfMessage)) {
					Write-Verbose "[$FunctionName] Calling ActiveDirectory_AddUserToSecurityGroup for $User"

					$Result = $CCS.ActiveDirectory_AddUserToSecurityGroup(
						$User,
						$SecurityGroupName,
						$DomainOUPath,
						$Domain,
						$ADUsername,
						$ADPassword
					)
					Write-Debug "Result from CCS Web Service: $Result"

					if ($Global:Cs) {
						$Global:Cs.Job_WriteLog("$FunctionName Result for $User : $Result")
					}

					Write-Verbose "[$FunctionName] Result for $User : $Result"

					# Check for errors in result
					$IsError = Invoke-CCSIsError -Result $Result

					Write-Debug "IsError evaluation for result: $IsError"
					if ($IsError) {
						$FailureCount++

						# Determine appropriate error category based on result message
						$ErrorCat = [System.Management.Automation.ErrorCategory]::OperationStopped
						$RecommendedActionText = "Verify the user and security group names are correct."

						if ($Result -like '*does not exist*') {
							$ErrorCat = [System.Management.Automation.ErrorCategory]::ObjectNotFound
							$RecommendedActionText = "Verify that the user '$User' and security group '$SecurityGroupName' exist in Active Directory."
						} elseif ($Result -like '*unwilling to process*') {
							$ErrorCat = [System.Management.Automation.ErrorCategory]::PermissionDenied
							$RecommendedActionText = "Check that the domain credentials have sufficient permissions to modify the security group."
						} elseif ($Result -like '*already a member*') {
							$ErrorCat = [System.Management.Automation.ErrorCategory]::ResourceExists
							$RecommendedActionText = "The user is already a member of the security group."
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
							-ErrorMessage "Failed to add user '$User' to security group '$SecurityGroupName': $Result" `
							-ErrorCategory $ErrorCat `
							-TargetObject $User `
							-FunctionName $FunctionName `
							-RecommendedAction $RecommendedActionText `
							-Throw:$ShouldThrow
					} else {
						$SuccessCount++
						Write-Verbose "[$FunctionName] Successfully added $User to $SecurityGroupName"
						Write-Output $Result
					}
				} else {
					Write-Verbose "[$FunctionName] WhatIf: Would add $User to $SecurityGroupName"
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


function Get-CCSADComputerOU {
	<#
	.SYNOPSIS
		Gets the Organizational Unit (OU) path of a computer in Active Directory using the CCS Web Service.

	.DESCRIPTION
		Retrieves the OU path where a computer resides in Active Directory using the CCS Web Service.
		This advanced function includes comprehensive error handling, input validation, and supports pipeline input.

	.PARAMETER ComputerName
		The name of the computer to retrieve the OU path for.
		Supports pipeline input and accepts multiple computer names.

	.PARAMETER DomainOUPath
		The Organizational Unit (OU) path to search within.
		If not specified, searches the entire domain.
		Supports both standard DN format (OU=Computers,DC=example,DC=com) and LDAP format (LDAP://DC01.example.local/OU=Computers,DC=example,DC=com).

	.PARAMETER Domain
		The domain in which the computer resides.
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
		PS C:\> Get-CCSADComputerOU -ComputerName "TestPC" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Gets the OU path for TestPC using default CCS context.

	.EXAMPLE
		PS C:\> Get-CCSADComputerOU -ComputerName "TestPC" -DomainOUPath "OU=Computers,DC=example,DC=com" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential -DomainCredential $DomainCredential

		Gets the OU path for TestPC using specific domain credentials and limiting search to specific OU.

	.EXAMPLE
		PS C:\> "PC01", "PC02", "PC03" | Get-CCSADComputerOU -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Gets the OU paths for multiple computers using pipeline input.

	.EXAMPLE
		PS C:\> Get-CCSADComputerOU -ComputerName "TestPC" -DomainOUPath "LDAP://DC01.Firmax.local/DC=FirmaX,DC=local" -Domain "Firmax.local" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Gets the OU path for TestPC using LDAP format for the search path. The LDAP path will be automatically converted to standard DN format.

	.OUTPUTS
		System.String
		Returns the OU path where the computer resides in Distinguished Name format.

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
			HelpMessage = 'Enter the computer name to retrieve the OU path for'
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('Name', 'Computer', 'CN')]
		[string[]]$ComputerName,

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

		$ProcessedCount = 0
		$SuccessCount = 0
		$FailureCount = 0
	}

	process {
		foreach ($Computer in $ComputerName) {
			$ProcessedCount++

			try {
				Write-Verbose "[$FunctionName] Processing computer: $Computer ($ProcessedCount)"

				if ($Global:Cs) {
					$Global:Cs.Job_WriteLog("$FunctionName Processing: ComputerName=$Computer, DomainOUPath=$DomainOUPath, Domain=$Domain")
				}

				Write-Verbose "[$FunctionName] Calling ActiveDirectory_GetComputerOU for $Computer"

				$Result = $CCS.ActiveDirectory_GetComputerOU(
					$Computer,
					$DomainOUPath,
					$Domain,
					$ADUsername,
					$ADPassword
				)

				Write-Debug "[$FunctionName] Result from CCS Web Service: $Result"

				if ($Global:Cs) {
					$Global:Cs.Job_WriteLog("$FunctionName Result for $Computer : $Result")
				}

				Write-Verbose "[$FunctionName] OU path for $Computer : $Result"

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
						-ErrorMessage "Failed to get OU path for computer '$Computer': $Result" `
						-ErrorCategory ObjectNotFound `
						-TargetObject $Computer `
						-FunctionName $FunctionName `
						-RecommendedAction "Verify the computer name is correct and exists in Active Directory. Check domain credentials if provided." `
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
					-ErrorMessage "Exception occurred while processing computer '$Computer': $_" `
					-ErrorCategory InvalidOperation `
					-TargetObject $Computer `
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


function Get-CCSADDescriptionForGroup {
	<#
	.SYNOPSIS
		Gets the description of a security group from Active Directory using the CCS Web Service.

	.DESCRIPTION
		Retrieves the description of a security group from Active Directory using the CCS Web Service.
		This advanced function includes comprehensive error handling, input validation, and supports pipeline input.

	.PARAMETER GroupName
		The name of the security group to retrieve the description for.
		Supports pipeline input and accepts multiple group names.

	.PARAMETER DomainOUPath
		The Organizational Unit (OU) path in which the group resides.
		If not specified, searches the entire domain.
		Supports both standard DN format (OU=Groups,DC=example,DC=com) and LDAP format (LDAP://DC01.example.local/OU=Groups,DC=example,DC=com).

	.PARAMETER Domain
		The domain in which the group resides.
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
		PS C:\> Get-CCSADDescriptionForGroup -GroupName "TestGroup" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Gets the description for TestGroup using default CCS context.

	.EXAMPLE
		PS C:\> Get-CCSADDescriptionForGroup -GroupName "TestGroup" -DomainOUPath "OU=Groups,DC=example,DC=com" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential -DomainCredential $DomainCredential

		Gets the description for TestGroup using specific domain credentials and OU path.

	.EXAMPLE
		PS C:\> "Group01", "Group02", "Group03" | Get-CCSADDescriptionForGroup -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Gets the descriptions for multiple groups using pipeline input.

	.EXAMPLE
		PS C:\> Get-CCSADDescriptionForGroup -GroupName "TestGroup" -DomainOUPath "LDAP://DC01.Firmax.local/OU=Groups,DC=FirmaX,DC=local" -Domain "Firmax.local" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Gets the description for TestGroup using LDAP format for the OU path. The LDAP path will be automatically converted to standard DN format.

	.OUTPUTS
		System.String
		Returns the description of the security group.

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
			HelpMessage = 'Enter the security group name to retrieve the description for'
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('Group', 'Name', 'SamAccountName')]
		[string[]]$GroupName,

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
					$Global:Cs.Job_WriteLog("$FunctionName Processing: GroupName=$Group, DomainOUPath=$DomainOUPath, Domain=$Domain")
				}

				Write-Verbose "[$FunctionName] Calling ActiveDirectory_GetDescriptionForGroup for $Group"

				$Result = $CCS.ActiveDirectory_GetDescriptionForGroup(
					$Group,
					$DomainOUPath,
					$Domain,
					$ADUsername,
					$ADPassword
				)

				Write-Debug "[$FunctionName] Result from CCS Web Service: $Result"

				if ($Global:Cs) {
					$Global:Cs.Job_WriteLog("$FunctionName Result for $Group : $Result")
				}

				Write-Verbose "[$FunctionName] Description for $Group : $Result"

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
						-ErrorMessage "Failed to get description for group '$Group': $Result" `
						-ErrorCategory ObjectNotFound `
						-TargetObject $Group `
						-FunctionName $FunctionName `
						-RecommendedAction "Verify the group name is correct and exists in Active Directory. Check domain credentials if provided." `
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


function Get-CCSADDisplayNameForUser {
	<#
	.SYNOPSIS
		Gets the display name of a user from Active Directory using the CCS Web Service.

	.DESCRIPTION
		Retrieves the display name of a user from Active Directory using the CCS Web Service.
		This advanced function includes comprehensive error handling, input validation, and supports pipeline input.

	.PARAMETER UserName
		The username of the user to retrieve the display name for.
		Supports pipeline input and accepts multiple usernames.

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
		PS C:\> Get-CCSADDisplayNameForUser -UserName "jdoe" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Gets the display name for user jdoe using default CCS context.

	.EXAMPLE
		PS C:\> Get-CCSADDisplayNameForUser -UserName "jdoe" -DomainOUPath "OU=Users,DC=example,DC=com" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential -DomainCredential $DomainCredential

		Gets the display name for user jdoe using specific domain credentials and OU path.

	.EXAMPLE
		PS C:\> "jdoe", "asmith", "bjones" | Get-CCSADDisplayNameForUser -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Gets the display names for multiple users using pipeline input.

	.EXAMPLE
		PS C:\> Get-CCSADDisplayNameForUser -UserName "jdoe" -DomainOUPath "LDAP://DC01.Firmax.local/OU=Users,DC=FirmaX,DC=local" -Domain "Firmax.local" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Gets the display name for user jdoe using LDAP format for the OU path. The LDAP path will be automatically converted to standard DN format.

	.OUTPUTS
		System.String
		Returns the display name of the user.

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
			HelpMessage = 'Enter the username to retrieve the display name for'
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('User', 'SamAccountName', 'Identity')]
		[string[]]$UserName,

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
					$Global:Cs.Job_WriteLog("$FunctionName Processing: UserName=$User, DomainOUPath=$DomainOUPath, Domain=$Domain")
				}

				Write-Verbose "[$FunctionName] Calling ActiveDirectory_GetDisplayNameForUser for $User"

				$Result = $CCS.ActiveDirectory_GetDisplayNameForUser(
					$User,
					$DomainOUPath,
					$Domain,
					$ADUsername,
					$ADPassword
				)

				Write-Debug "[$FunctionName] Result from CCS Web Service: $Result"

				if ($Global:Cs) {
					$Global:Cs.Job_WriteLog("$FunctionName Result for $User : $Result")
				}

				Write-Verbose "[$FunctionName] Display name for $User : $Result"

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
						-ErrorMessage "Failed to get display name for user '$User': $Result" `
						-ErrorCategory ObjectNotFound `
						-TargetObject $User `
						-FunctionName $FunctionName `
						-RecommendedAction "Verify the username is correct and exists in Active Directory. Check domain credentials if provided." `
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


function Get-CCSADEmailForUser {
	<#
	.SYNOPSIS
		Gets the email address of a user from Active Directory using the CCS Web Service.

	.DESCRIPTION
		Retrieves the email address of a user from Active Directory using the CCS Web Service.
		This advanced function includes comprehensive error handling, input validation, and supports pipeline input.

	.PARAMETER UserName
		The username of the user to retrieve the email address for.
		Supports pipeline input and accepts multiple usernames.

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
		PS C:\> Get-CCSADEmailForUser -UserName "jdoe" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Gets the email address for user jdoe using default CCS context.

	.EXAMPLE
		PS C:\> Get-CCSADEmailForUser -UserName "jdoe" -DomainOUPath "OU=Users,DC=example,DC=com" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential -DomainCredential $DomainCredential

		Gets the email address for user jdoe using specific domain credentials and OU path.

	.EXAMPLE
		PS C:\> "jdoe", "asmith", "bjones" | Get-CCSADEmailForUser -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Gets the email addresses for multiple users using pipeline input.

	.EXAMPLE
		PS C:\> Get-CCSADEmailForUser -UserName "jdoe" -DomainOUPath "LDAP://DC01.Firmax.local/OU=Users,DC=FirmaX,DC=local" -Domain "Firmax.local" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Gets the email address for user jdoe using LDAP format for the OU path. The LDAP path will be automatically converted to standard DN format.

	.OUTPUTS
		System.String
		Returns the email address of the user.

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
			HelpMessage = 'Enter the username to retrieve the email address for'
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('User', 'SamAccountName', 'Identity')]
		[string[]]$UserName,

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
					$Global:Cs.Job_WriteLog("$FunctionName Processing: UserName=$User, DomainOUPath=$DomainOUPath, Domain=$Domain")
				}

				Write-Verbose "[$FunctionName] Calling ActiveDirectory_GetEmailForUser for $User"

				$Result = $CCS.ActiveDirectory_GetEmailForUser(
					$User,
					$DomainOUPath,
					$Domain,
					$ADUsername,
					$ADPassword
				)

				Write-Debug "[$FunctionName] Result from CCS Web Service: $Result"

				if ($Global:Cs) {
					$Global:Cs.Job_WriteLog("$FunctionName Result for $User : $Result")
				}

				Write-Verbose "[$FunctionName] Email address for $User : $Result"

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
						-ErrorMessage "Failed to get email address for user '$User': $Result" `
						-ErrorCategory ObjectNotFound `
						-TargetObject $User `
						-FunctionName $FunctionName `
						-RecommendedAction "Verify the username is correct and exists in Active Directory. Check that the user has an email address configured. Check domain credentials if provided." `
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


function Get-CCSADOUStructure {
	<#
	.SYNOPSIS
		Retrieves the Organizational Unit (OU) structure from Active Directory using the CCS Web Service.

	.DESCRIPTION
		Retrieves the hierarchical Organizational Unit (OU) structure from Active Directory using the CCS Web Service.
		Returns a nested structure of OUs with their names, paths, and child OUs.
		This advanced function includes comprehensive error handling and input validation.

	.PARAMETER DomainTopPath
		The top-level domain path to start the OU structure retrieval from.
		Must be in DN format (DC=example,DC=com).
		If not specified, retrieves from the root of the domain.

	.PARAMETER Domain
		The domain to query for OU structure.
		Must be a valid domain name format.

	.PARAMETER Url
		The URL of the CCS Web Service.
		Must be a valid URI format. Example: "https://example.com/CCSWebservice/CCS.asmx"

	.PARAMETER CCSCredential
		The credentials used to authenticate with the CCS Web Service.

	.PARAMETER DomainCredential
		The credentials of an account with permissions to query Active Directory.
		If not defined, it will run in the CCS Web Service context.

	.PARAMETER ExcludedOUNames
		An array of OU names to exclude from the structure.
		OUs with these names will not be included in the results.

	.PARAMETER PasswordIsEncrypted
		Indicates if the password in the DomainCredential is encrypted. Default is $false.

	.EXAMPLE
		PS C:\> Get-CCSADOUStructure -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Retrieves the complete OU structure for the domain using default CCS context.

	.EXAMPLE
		PS C:\> Get-CCSADOUStructure -DomainTopPath "DC=example,DC=com" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential -DomainCredential $DomainCredential

		Retrieves the OU structure starting from the domain root using specific domain credentials.

	.EXAMPLE
		PS C:\> Get-CCSADOUStructure -DomainTopPath "OU=IT,DC=example,DC=com" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Retrieves the OU structure starting from a specific OU.

	.EXAMPLE
		PS C:\> Get-CCSADOUStructure -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential -ExcludedOUNames @("Test", "Archive")

		Retrieves the OU structure excluding OUs named "Test" or "Archive".

	.OUTPUTS
		System.Collections.Generic.List[PSCustomObject]
		Returns a hierarchical list of OU structures containing:
		- Name: OU name
		- Path: Full DN path
		- Children: Nested list of child OUs

	.NOTES
		This is an advanced function with comprehensive error handling.
		The function returns a hierarchical structure that can be traversed to view the complete OU tree.
	#>
	[CmdletBinding()]
	[OutputType([System.Collections.Generic.List[PSCustomObject]])]
	param (
		[Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
		[ValidateScript({
				if ([string]::IsNullOrEmpty($_)) {
					return $true
				}
				# Support standard DN format: OU=...,DC=...,DC=... or DC=...,DC=...
				if ($_ -match '^(OU=.*,)?(DC=.+)(,DC=.+)*$') {
					return $true
				}
				throw "DomainTopPath must be in format 'OU=...,DC=...,DC=...' or 'DC=...,DC=...' or empty"
			})]
		[Alias('TopPath', 'BasePath', 'SearchBase')]
		[string]$DomainTopPath = '',

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
		[ValidateNotNull()]
		[Alias('Exclude', 'ExcludeOUs')]
		[string[]]$ExcludedOUNames,

		[Parameter(Mandatory = $false)]
		[Alias('Encrypted')]
		[switch]$PasswordIsEncrypted
	)

	begin {
		$FunctionName = $PSCmdlet.MyInvocation.MyCommand.Name

		Write-Verbose "[$FunctionName] Starting function execution"
		Write-Verbose "[$FunctionName] Domain: $Domain"
		Write-Verbose "[$FunctionName] DomainTopPath: $DomainTopPath"
		Write-Verbose "[$FunctionName] URL: $Url"

		# Initialize CCS connection once in begin block
		try {
			Write-Verbose "[$FunctionName] Initializing CCS Web Service connection"
			$CCS = Initialize-CCS -Url $Url -WebServiceCredential $CCSCredential -ErrorAction Stop
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
				-ErrorMessage "Failed to initialize CCS Web Service: $_" `
				-ErrorCategory ConnectionError `
				-TargetObject $Url `
				-FunctionName $FunctionName `
				-Exception $_.Exception `
				-RecommendedAction "Verify the URL is correct and the CCS Web Service is accessible. Check credentials." `
				-Throw:$ShouldThrow
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
				# Determine if we should throw based on the ErrorAction preference
				$ShouldThrow = $false
				if ($PSBoundParameters.ContainsKey('ErrorAction')) {
					$ShouldThrow = $PSBoundParameters['ErrorAction'] -eq 'Stop'
				} else {
					$ShouldThrow = $ErrorActionPreference -eq 'Stop'
				}

				Invoke-CCSErrorHandling `
					-ErrorMessage "Failed to process domain credential password: $_" `
					-ErrorCategory SecurityError `
					-FunctionName $FunctionName `
					-Exception $_.Exception `
					-RecommendedAction "Ensure the domain credential is valid and the password can be encrypted." `
					-Throw:$ShouldThrow
				return
			}
		} else {
			Write-Verbose "[$FunctionName] No domain credential provided, using CCS Web Service context"
		}
	}

	process {
		try {
			Write-Verbose "[$FunctionName] Querying Active Directory for OU structure"

			if ($Global:Cs) {
				$Global:Cs.Job_WriteLog("$FunctionName Processing: DomainTopPath=$DomainTopPath, Domain=$Domain")
			}

			Write-Verbose "[$FunctionName] Calling ActiveDirectory_Get_OU_Structure"

			$Result = $CCS.ActiveDirectory_Get_OU_Structure(
				$DomainTopPath,
				$ADUsername,
				$ADPassword,
				$ExcludedOUNames
			)

			Write-Debug "Result from CCS Web Service: $($Result.Count) OUs retrieved"

			if ($Global:Cs) {
				$Global:Cs.Job_WriteLog("$FunctionName Result: Retrieved $($Result.Count) OUs")
			}

			Write-Verbose "[$FunctionName] Retrieved $($Result.Count) OUs"

			# Check if result is null or empty
			if ($null -eq $Result) {
				Invoke-CCSErrorHandling `
					-ErrorMessage "No data returned from CCS Web Service" `
					-ErrorCategory ObjectNotFound `
					-TargetObject $Domain `
					-FunctionName $FunctionName `
					-RecommendedAction "Verify the domain and top path are correct."
				return
			}

			# Recursive function to convert the OU structure to PSCustomObject
			function ConvertTo-OUStructure {
				param($OU)

				$OUObject = [PSCustomObject]@{
					Name     = $OU.Name
					Path     = $OU.Path
					Children = @()
				}

				# Add custom type name for formatting
				$OUObject.PSObject.TypeNames.Insert(0, 'CCS.ActiveDirectoryOUStructure')

				# Recursively process children
				if ($OU.Children -and $OU.Children.Count -gt 0) {
					foreach ($Child in $OU.Children) {
						$OUObject.Children += ConvertTo-OUStructure -OU $Child
					}
				}

				return $OUObject
			}

			# Convert the result to PSCustomObject for better PowerShell compatibility
			foreach ($OU in $Result) {
				$OUStructure = ConvertTo-OUStructure -OU $OU
				Write-Output $OUStructure
			}

			Write-Verbose "[$FunctionName] Successfully retrieved OU structure with $($Result.Count) top-level OUs"

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
				-ErrorMessage "Exception occurred while retrieving OU structure: $_" `
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


function Get-CCSADSid {
	<#
	.SYNOPSIS
		Retrieves the Security Identifier (SID) for a computer in Active Directory using the CCS Web Service.

	.DESCRIPTION
		Retrieves the Security Identifier (SID) for a computer in Active Directory using the CCS Web Service.
		This advanced function includes comprehensive error handling, input validation, and supports pipeline input.

	.PARAMETER ComputerName
		The name of the computer to retrieve the SID for.
		Supports pipeline input and accepts multiple computer names.

	.PARAMETER DomainOUPath
		The Organizational Unit (OU) path in which the computer resides.
		If not specified, searches the entire domain.
		Supports both standard DN format (OU=Computers,DC=example,DC=com) and LDAP format (LDAP://DC01.example.local/OU=Computers,DC=example,DC=com).

	.PARAMETER Domain
		The domain in which the computer resides.
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
		PS C:\> Get-CCSADSid -ComputerName "TestPC" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Retrieves the SID for TestPC using default CCS context.

	.EXAMPLE
		PS C:\> Get-CCSADSid -ComputerName "TestPC" -DomainOUPath "OU=Computers,DC=example,DC=com" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential -DomainCredential $DomainCredential

		Retrieves the SID for TestPC using specific domain credentials and OU path.

	.EXAMPLE
		PS C:\> "PC01", "PC02", "PC03" | Get-CCSADSid -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Retrieves SIDs for multiple computers using pipeline input.

	.EXAMPLE
		PS C:\> Get-CCSADSid -ComputerName "TestPC" -DomainOUPath "LDAP://DC01.Firmax.local/DC=FirmaX,DC=local" -Domain "Firmax.local" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Retrieves the SID using LDAP format for the OU path. The LDAP path will be automatically converted to standard DN format.

	.OUTPUTS
		System.String
		Returns the Security Identifier (SID) for the specified computer.

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
			HelpMessage = 'Enter the computer name to retrieve the SID for'
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('Name', 'Computer', 'CN')]
		[string[]]$ComputerName,

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

		$ProcessedCount = 0
		$SuccessCount = 0
		$FailureCount = 0
	}

	process {
		foreach ($Computer in $ComputerName) {
			$ProcessedCount++

			try {
				Write-Verbose "[$FunctionName] Processing computer: $Computer ($ProcessedCount)"

				if ($Global:Cs) {
					$Global:Cs.Job_WriteLog("$FunctionName Processing: ComputerName=$Computer, DomainOUPath=$DomainOUPath, Domain=$Domain")
				}

				Write-Verbose "[$FunctionName] Calling ActiveDirectory_GetSID for $Computer"

				$Result = $CCS.ActiveDirectory_GetSID(
					$Computer,
					$DomainOUPath,
					$Domain,
					$ADUsername,
					$ADPassword
				)

				Write-Debug "Result from CCS Web Service: $Result"

				if ($Global:Cs) {
					$Global:Cs.Job_WriteLog("$FunctionName Result for $Computer : $Result")
				}

				Write-Verbose "[$FunctionName] Result for $Computer : $Result"

				# Check for errors in result
				$IsError = Invoke-CCSIsError -Result $Result

				Write-Debug "IsError evaluation for result: $IsError"
				if ($IsError) {
					$FailureCount++

					# Determine appropriate error category based on result message
					$ErrorCat = [System.Management.Automation.ErrorCategory]::OperationStopped
					$RecommendedActionText = "Verify the computer name is correct."

					if ($Result -like '*does not exist*') {
						$ErrorCat = [System.Management.Automation.ErrorCategory]::ObjectNotFound
						$RecommendedActionText = "Verify that the computer '$Computer' exists in Active Directory."
					} elseif ($Result -like '*unwilling to process*') {
						$ErrorCat = [System.Management.Automation.ErrorCategory]::PermissionDenied
						$RecommendedActionText = "Check that the domain credentials have sufficient permissions to query Active Directory."
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
						-ErrorMessage "Failed to retrieve SID for computer '$Computer': $Result" `
						-ErrorCategory $ErrorCat `
						-TargetObject $Computer `
						-FunctionName $FunctionName `
						-RecommendedAction $RecommendedActionText `
						-Throw:$ShouldThrow
				} else {
					$SuccessCount++
					Write-Verbose "[$FunctionName] Successfully retrieved SID for $Computer"
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
					-ErrorMessage "Exception occurred while processing computer '$Computer': $_" `
					-ErrorCategory InvalidOperation `
					-TargetObject $Computer `
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


function Get-CCSEncryptedPassword {
	<#
	.SYNOPSIS
		Encrypts a SecureString using the InstallationScreen.exe utility for CCS Webservice use.

	.DESCRIPTION
		Takes a SecureString and uses the InstallationScreen.exe utility to encrypt it. Returns the encrypted string, suitable for use with CCS Webservice operations. Includes robust error handling, parameter validation, and advanced function features.

	.PARAMETER SecureString
		The SecureString to encrypt. Must not be empty.

	.EXAMPLE
		$secure = ConvertTo-SecureString "Admin1234" -AsPlainText -Force
		Get-CCSEncryptedPassword -SecureString $secure

	.OUTPUTS
		System.String. The encrypted string.

	.NOTES
		Advanced function with CmdletBinding, error handling, and pipeline support.
	#>
	[CmdletBinding(SupportsShouldProcess = $false, ConfirmImpact = 'None')]
	[OutputType([string])]
	param (
		[Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'Enter the SecureString to encrypt')]
		[ValidateNotNull()]
		[Alias('Password','Secret')]
		[System.Security.SecureString]$SecureString
	)

	begin {
		$FunctionName = $PSCmdlet.MyInvocation.MyCommand.Name
		$ExePath = Join-Path $PSScriptRoot 'Dependencies' 'InstallationScreen.exe'
		$OutputPath = Join-Path $env:TEMP 'InstallationScreen.log'
		Write-Verbose "[$FunctionName] Using InstallationScreen.exe at: $ExePath"
	}

	process {
		# Convert SecureString to plain text
		try {
			$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecureString)
			$Plain = [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($BSTR)
		} catch {
			$msg = "[$FunctionName] Failed to convert SecureString to plain text: $_"
			Write-Error $msg
			throw $msg
		} finally {
			if ($BSTR) { [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR) }
		}
		Write-Verbose "[$FunctionName] Encrypting string (length: $($Plain.Length))"
		if ([string]::IsNullOrWhiteSpace($Plain)) {
			$msg = "Input SecureString is empty or whitespace."
			Write-Error $msg
			throw $msg
		}
		if (-not (Test-Path $ExePath)) {
			$msg = "InstallationScreen.exe not found at $ExePath"
			Write-Error $msg
			throw $msg
		}
		if (Test-Path $OutputPath) {
			Remove-Item $OutputPath -Force -ErrorAction SilentlyContinue
		}
		$Arguments = "power $Plain"
		try {
			Write-Debug "[$FunctionName] Running: $ExePath $Arguments"
			$proc = Start-Process -FilePath $ExePath -ArgumentList $Arguments -Wait -RedirectStandardOutput $OutputPath -NoNewWindow -PassThru
			if ($proc.ExitCode -ne 0) {
				$msg = "InstallationScreen.exe exited with code $($proc.ExitCode)"
				Write-Error $msg
				throw $msg
			}
			if (-not (Test-Path $OutputPath)) {
				$msg = "Output file not created: $OutputPath"
				Write-Error $msg
				throw $msg
			}
			$Output = Get-Content $OutputPath -Raw
			$Encrypted = $Output.Trim() -replace '\r?\n', ''
			if ([string]::IsNullOrWhiteSpace($Encrypted)) {
				$msg = "No encrypted output returned from InstallationScreen.exe."
				Write-Error $msg
				throw $msg
			}
			Write-Verbose "[$FunctionName] Encrypted string: $Encrypted"
			Write-Output $Encrypted
		} catch {
			$msg = "[$FunctionName] Failed to encrypt string: $_"
			Write-Error $msg
			throw $msg
		} finally {
			if (Test-Path $OutputPath) {
				Remove-Item $OutputPath -Force -ErrorAction SilentlyContinue
			}
		}
	}
}


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


function Invoke-CCSErrorHandling {
	<#
	.SYNOPSIS
		Throws a structured error with proper error records for CCS operations.

	.DESCRIPTION
		This function creates and throws a properly formatted PowerShell error with appropriate
		error categories, target objects, and detailed error messages. It also logs to the global
		Cs object if available and supports different error severity levels.

	.PARAMETER ErrorMessage
		The main error message to display.

	.PARAMETER ErrorCategory
		The PowerShell error category. Default is 'OperationStopped'.
		Valid values: NotSpecified, OpenError, CloseError, DeviceError, DeadlockDetected, InvalidArgument,
		InvalidData, InvalidOperation, InvalidResult, InvalidType, MetadataError, NotImplemented,
		NotInstalled, ObjectNotFound, OperationStopped, OperationTimeout, SyntaxError, ParserError,
		PermissionDenied, ResourceBusy, ResourceExists, ResourceUnavailable, ReadError, WriteError,
		FromStdErr, SecurityError, ProtocolError, ConnectionError, AuthenticationError, LimitsExceeded,
		QuotaExceeded, NotEnabled.

	.PARAMETER TargetObject
		The object that was being processed when the error occurred.

	.PARAMETER FunctionName
		The name of the function where the error occurred. If not specified, uses the calling function's name.

	.PARAMETER Exception
		An existing exception object to wrap in the error record.

	.PARAMETER RecommendedAction
		Recommended action for the user to resolve the error.

	.PARAMETER LogToCs
		Whether to log the error to the global Cs object. Default is $true.

	.PARAMETER Throw
		Whether to throw the error (terminating) or write it as a non-terminating error. Default is $true (throw).

	.EXAMPLE
		PS C:\> Invoke-CCSErrorHandling -ErrorMessage "Failed to connect to CCS Web Service" -ErrorCategory ConnectionError -TargetObject $Url

		Throws a connection error with the specified message.

	.EXAMPLE
		PS C:\> Invoke-CCSErrorHandling -ErrorMessage "Computer not found in AD" -ErrorCategory ObjectNotFound -TargetObject $ComputerName -RecommendedAction "Verify the computer name exists in Active Directory"

		Throws an object not found error with a recommended action.

	.EXAMPLE
		PS C:\> Invoke-CCSErrorHandling -ErrorMessage "Invalid credentials" -ErrorCategory AuthenticationError -Throw:$false

		Writes a non-terminating authentication error.

	.OUTPUTS
		None. This function either throws a terminating error or writes a non-terminating error.

	.NOTES
		This function provides consistent error handling across all CCS module functions.
	#>
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true, Position = 0)]
		[ValidateNotNullOrEmpty()]
		[string]$ErrorMessage,

		[Parameter(Mandatory = $false)]
		[ValidateSet(
			'NotSpecified', 'OpenError', 'CloseError', 'DeviceError', 'DeadlockDetected',
			'InvalidArgument', 'InvalidData', 'InvalidOperation', 'InvalidResult', 'InvalidType',
			'MetadataError', 'NotImplemented', 'NotInstalled', 'ObjectNotFound', 'OperationStopped',
			'OperationTimeout', 'SyntaxError', 'ParserError', 'PermissionDenied', 'ResourceBusy',
			'ResourceExists', 'ResourceUnavailable', 'ReadError', 'WriteError', 'FromStdErr',
			'SecurityError', 'ProtocolError', 'ConnectionError', 'AuthenticationError',
			'LimitsExceeded', 'QuotaExceeded', 'NotEnabled'
		)]
		[System.Management.Automation.ErrorCategory]$ErrorCategory = [System.Management.Automation.ErrorCategory]::OperationStopped,

		[Parameter(Mandatory = $false)]
		[object]$TargetObject,

		[Parameter(Mandatory = $false)]
		[string]$FunctionName,

		[Parameter(Mandatory = $false)]
		[System.Exception]$Exception,

		[Parameter(Mandatory = $false)]
		[string]$RecommendedAction,

		[Parameter(Mandatory = $false)]
		[bool]$LogToCs = $true,

		[Parameter(Mandatory = $false)]
		[bool]$Throw = $true
	)

	# Get the calling function name if not provided
	if (-not $FunctionName) {
		$CallingFunction = (Get-PSCallStack)[1]
		if ($CallingFunction.Command) {
			$FunctionName = $CallingFunction.Command
		} else {
			$FunctionName = 'Unknown'
		}
	}

	# Format the full error message
	$FullErrorMessage = "[$FunctionName] $ErrorMessage"

	# Log to global Cs object if available and requested
	if ($LogToCs -and $Global:Cs) {
		try {
			$Global:Cs.Job_WriteLog("ERROR: $FullErrorMessage", $true)
		} catch {
			# Silently continue if logging fails
			Write-Verbose "Failed to log to Cs object: $_"
		}
	}

	# Create or use the exception
	if (-not $Exception) {
		$Exception = New-Object System.InvalidOperationException($FullErrorMessage)
	}

	# Create the error record
	$ErrorRecord = New-Object System.Management.Automation.ErrorRecord(
		$Exception,
		"CCS.$FunctionName.$ErrorCategory",
		$ErrorCategory,
		$TargetObject
	)

	# Add recommended action if provided
	if ($RecommendedAction) {
		$ErrorRecord.ErrorDetails = New-Object System.Management.Automation.ErrorDetails($ErrorMessage)
		$ErrorRecord.ErrorDetails.RecommendedAction = $RecommendedAction
	}

	# Add category message for better context
	$ErrorRecord.CategoryInfo.Activity = $FunctionName
	$ErrorRecord.CategoryInfo.Reason = $Exception.GetType().Name

	# Either throw or write the error
	if ($Throw) {
		throw $ErrorRecord
	} else {
		Write-Error -ErrorRecord $ErrorRecord
	}
}


function Invoke-CCSIsError {
	param (
		[Parameter(Mandatory = $true)]
		[string]$Result
	)

	switch -Wildcard ($Result) {
		'*does not exist*' {
			return $true
		}
		'The server is unwilling to process the request*' {
			return $true
		}
        "Computer does not exist*" {
            return $true
        }
        "The server is not operational*" {
            return $true
        }
		default {
			return $false
		}
	}
}


function Move-CCSADComputer {
	<#
	.SYNOPSIS
		Moves a computer to a different Organizational Unit (OU) in Active Directory using the CCS Web Service.

	.DESCRIPTION
		Moves a computer to a different Organizational Unit (OU) in Active Directory using the CCS Web Service.
		This advanced function includes comprehensive error handling, input validation, and supports pipeline input.

	.PARAMETER ComputerName
		The name of the computer to be moved.
		Supports pipeline input and accepts multiple computer names.

	.PARAMETER DestinationOU
		The Distinguished Name (DN) of the destination Organizational Unit where the computer will be moved.
		Must be in format: OU=Computers,DC=example,DC=com

	.PARAMETER DomainOUPath
		The Organizational Unit (OU) path where the computer currently resides.
		If not specified, searches the entire domain.
		Supports both standard DN format (OU=Computers,DC=example,DC=com) and LDAP format (LDAP://DC01.example.local/OU=Computers,DC=example,DC=com).

	.PARAMETER Domain
		The domain in which the computer resides.
		Must be a valid domain name format.

	.PARAMETER Url
		The URL of the CCS Web Service.
		Must be a valid HTTPS URI format. Example: "https://example.com/CCSWebservice/CCS.asmx"

	.PARAMETER CCSCredential
		The credentials used to authenticate with the CCS Web Service.

	.PARAMETER DomainCredential
		The credentials of an account with permissions to move the computer.
		If not defined, it will run in the CCS Web Service context.

	.PARAMETER PasswordIsEncrypted
		Indicates if the password in the DomainCredential is encrypted. Default is $false.

	.EXAMPLE
		PS C:\> Move-CCSADComputer -ComputerName "TestPC" -DestinationOU "OU=NewLocation,DC=example,DC=com" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Moves TestPC to the NewLocation OU using default CCS context.

	.EXAMPLE
		PS C:\> Move-CCSADComputer -ComputerName "TestPC" -DestinationOU "OU=NewLocation,DC=example,DC=com" -DomainOUPath "OU=OldLocation,DC=example,DC=com" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential -DomainCredential $DomainCredential

		Moves TestPC from OldLocation OU to NewLocation OU using specific domain credentials.

	.EXAMPLE
		PS C:\> "PC01", "PC02", "PC03" | Move-CCSADComputer -DestinationOU "OU=NewLocation,DC=example,DC=com" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Moves multiple computers to NewLocation OU using pipeline input.

	.EXAMPLE
		PS C:\> Move-CCSADComputer -ComputerName "TestPC" -DestinationOU "OU=Workstations,DC=Firmax,DC=local" -DomainOUPath "LDAP://DC01.Firmax.local/DC=Firmax,DC=local" -Domain "Firmax.local" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Moves TestPC to Workstations OU using LDAP format for the current OU path.

	.OUTPUTS
		System.String
		Returns the result message from the CCS Web Service operation.

	.NOTES
		This is an advanced function with support for ShouldProcess, pipeline input, and comprehensive error handling.
	#>
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
	[OutputType([string])]
	param (
		[Parameter(
			Mandatory = $true,
			Position = 0,
			ValueFromPipeline = $true,
			ValueFromPipelineByPropertyName = $true,
			HelpMessage = 'Enter the computer name to move'
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('Name', 'Computer', 'CN')]
		[string[]]$ComputerName,

		[Parameter(
			Mandatory = $true,
			Position = 1,
			ValueFromPipelineByPropertyName = $true,
			HelpMessage = 'Enter the destination OU Distinguished Name'
		)]
		[ValidateNotNullOrEmpty()]
		[ValidateScript({
				# Must be in DN format: OU=...,DC=...,DC=...
				if ($_ -match '^(OU=.*,)?(DC=.+)(,DC=.+)*$') {
					return $true
				}
				throw "DestinationOU must be in Distinguished Name format: 'OU=...,DC=...,DC=...'"
			})]
		[Alias('TargetOU', 'OU', 'Target')]
		[string]$DestinationOU,

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
		[Alias('SourceOU', 'Path', 'CurrentOU')]
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
		Write-Verbose "[$FunctionName] DestinationOU: $DestinationOU"
		Write-Verbose "[$FunctionName] Domain: $Domain"
		Write-Verbose "[$FunctionName] DomainOUPath: $DomainOUPath"
		Write-Verbose "[$FunctionName] URL: $Url"

		# Initialize CCS connection once in begin block
		try {
			Write-Verbose "[$FunctionName] Initializing CCS Web Service connection"
			$CCS = Initialize-CCS -Url $Url -WebServiceCredential $CCSCredential -ErrorAction Stop
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
				-ErrorMessage "Failed to initialize CCS Web Service: $_" `
				-ErrorCategory ConnectionError `
				-TargetObject $Url `
				-FunctionName $FunctionName `
				-Exception $_.Exception `
				-RecommendedAction "Verify the URL is correct and the CCS Web Service is accessible. Check credentials." `
				-Throw:$ShouldThrow
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
				# Determine if we should throw based on the ErrorAction preference
				$ShouldThrow = $false
				if ($PSBoundParameters.ContainsKey('ErrorAction')) {
					$ShouldThrow = $PSBoundParameters['ErrorAction'] -eq 'Stop'
				} else {
					$ShouldThrow = $ErrorActionPreference -eq 'Stop'
				}

				Invoke-CCSErrorHandling `
					-ErrorMessage "Failed to process domain credential password: $_" `
					-ErrorCategory SecurityError `
					-FunctionName $FunctionName `
					-Exception $_.Exception `
					-RecommendedAction "Ensure the domain credential is valid and the password can be encrypted." `
					-Throw:$ShouldThrow
				return
			}
		} else {
			Write-Verbose "[$FunctionName] No domain credential provided, using CCS Web Service context"
		}

		$ProcessedCount = 0
		$SuccessCount = 0
		$FailureCount = 0
	}

	process {
		foreach ($Computer in $ComputerName) {
			$ProcessedCount++

			try {
				Write-Verbose "[$FunctionName] Processing computer: $Computer ($ProcessedCount)"

				if ($Global:Cs) {
					$Global:Cs.Job_WriteLog("$FunctionName Processing: ComputerName=$Computer, DestinationOU=$DestinationOU, DomainOUPath=$DomainOUPath, Domain=$Domain")
				}

				# ShouldProcess support
				$WhatIfMessage = "Move computer '$Computer' to OU '$DestinationOU' in domain '$Domain'"
				if ($PSCmdlet.ShouldProcess($Computer, $WhatIfMessage)) {
					Write-Verbose "[$FunctionName] Calling ActiveDirectory_MoveComputerToOU for $Computer"

					$Result = $CCS.ActiveDirectory_MoveComputerToOU(
						$Computer,
						$DestinationOU,
						$DomainOUPath,
						$Domain,
						$ADUsername,
						$ADPassword
					)
					Write-Debug "Result from CCS Web Service: $Result"

					if ($Global:Cs) {
						$Global:Cs.Job_WriteLog("$FunctionName Result for $Computer : $Result")
					}

					Write-Verbose "[$FunctionName] Result for $Computer : $Result"

					# Check for errors in result
					$IsError = Invoke-CCSIsError -Result $Result

					Write-Debug "IsError evaluation for result: $IsError"
					if ($IsError) {
						$FailureCount++

						# Determine appropriate error category based on result message
						$ErrorCat = [System.Management.Automation.ErrorCategory]::OperationStopped
						$RecommendedActionText = "Verify the computer name and destination OU are correct."

						if ($Result -like '*does not exist*') {
							$ErrorCat = [System.Management.Automation.ErrorCategory]::ObjectNotFound
							$RecommendedActionText = "Verify that the computer '$Computer' and destination OU '$DestinationOU' exist in Active Directory."
						} elseif ($Result -like '*unwilling to process*' -or $Result -like '*Access is denied*') {
							$ErrorCat = [System.Management.Automation.ErrorCategory]::PermissionDenied
							$RecommendedActionText = "Check that the domain credentials have sufficient permissions to move the computer."
						} elseif ($Result -like '*already exists*') {
							$ErrorCat = [System.Management.Automation.ErrorCategory]::ResourceExists
							$RecommendedActionText = "The computer already exists in the destination OU."
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
							-ErrorMessage "Failed to move computer '$Computer' to OU '$DestinationOU': $Result" `
							-ErrorCategory $ErrorCat `
							-TargetObject $Computer `
							-FunctionName $FunctionName `
							-RecommendedAction $RecommendedActionText `
							-Throw:$ShouldThrow
					} else {
						$SuccessCount++
						Write-Verbose "[$FunctionName] Successfully moved $Computer to $DestinationOU"
						Write-Output $Result
					}
				} else {
					Write-Verbose "[$FunctionName] WhatIf: Would move $Computer to $DestinationOU"
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
					-ErrorMessage "Exception occurred while processing computer '$Computer': $_" `
					-ErrorCategory InvalidOperation `
					-TargetObject $Computer `
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


function Remove-CCSADComputer {
	<#
	.SYNOPSIS
		Removes a computer from Active Directory using the CCS Web Service.

	.DESCRIPTION
		Removes a computer from Active Directory using the CCS Web Service.
		This advanced function includes comprehensive error handling, input validation, and supports pipeline input.

	.PARAMETER ComputerName
		The name of the computer to be removed from Active Directory.
		Supports pipeline input and accepts multiple computer names.

	.PARAMETER DomainOUPath
		The Organizational Unit (OU) path in which the computer resides.
		If not specified, searches the entire domain.
		Supports both standard DN format (OU=Computers,DC=example,DC=com) and LDAP format (LDAP://DC01.example.local/OU=Computers,DC=example,DC=com).

	.PARAMETER Domain
		The domain in which the computer resides.
		Must be a valid domain name format.

	.PARAMETER Url
		The URL of the CCS Web Service.
		Must be a valid HTTPS URI format. Example: "https://example.com/CCSWebservice/CCS.asmx"

	.PARAMETER CCSCredential
		The credentials used to authenticate with the CCS Web Service.

	.PARAMETER DomainCredential
		The credentials of an account with permissions to remove the computer from Active Directory.
		If not defined, it will run in the CCS Web Service context.

	.PARAMETER PasswordIsEncrypted
		Indicates if the password in the DomainCredential is encrypted. Default is $false.

	.EXAMPLE
		PS C:\> Remove-CCSADComputer -ComputerName "TestPC" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Removes TestPC using default CCS context.

	.EXAMPLE
		PS C:\> Remove-CCSADComputer -ComputerName "TestPC" -DomainOUPath "OU=Computers,DC=example,DC=com" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential -DomainCredential $DomainCredential

		Removes TestPC using specific domain credentials and OU path.

	.EXAMPLE
		PS C:\> "PC01", "PC02", "PC03" | Remove-CCSADComputer -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Removes multiple computers using pipeline input.

	.EXAMPLE
		PS C:\> Remove-CCSADComputer -ComputerName "TestPC" -DomainOUPath "LDAP://DC01.Firmax.local/OU=Computers,DC=Firmax,DC=local" -Domain "Firmax.local" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential -DomainCredential $DomainCredential

		Removes TestPC using LDAP format for the OU path. The LDAP path will be automatically converted to standard DN format.

	.OUTPUTS
		System.String
		Returns the result message from the CCS Web Service operation.

	.NOTES
		This is an advanced function with support for ShouldProcess, pipeline input, and comprehensive error handling.
	#>
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
	[OutputType([string])]
	param (
		[Parameter(
			Mandatory = $true,
			Position = 0,
			ValueFromPipeline = $true,
			ValueFromPipelineByPropertyName = $true,
			HelpMessage = 'Enter the computer name to remove from Active Directory'
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('Name', 'Computer', 'CN')]
		[string[]]$ComputerName,

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

		$ProcessedCount = 0
		$SuccessCount = 0
		$FailureCount = 0
	}

	process {
		foreach ($Computer in $ComputerName) {
			$ProcessedCount++

			try {
				Write-Verbose "[$FunctionName] Processing computer: $Computer ($ProcessedCount)"

				if ($Global:Cs) {
					$Global:Cs.Job_WriteLog("$FunctionName Processing: ComputerName=$Computer, DomainOUPath=$DomainOUPath, Domain=$Domain")
				}

				# ShouldProcess support
				$WhatIfMessage = "Remove computer '$Computer' from Active Directory in domain '$Domain'"
				if ($PSCmdlet.ShouldProcess($Computer, $WhatIfMessage)) {
					Write-Verbose "[$FunctionName] Calling ActiveDirectory_RemoveComputer for $Computer"

					$Result = $CCS.ActiveDirectory_RemoveComputer(
						$Computer,
						$DomainOUPath,
						$Domain,
						$ADUsername,
						$ADPassword
					)
					Write-Debug "Result from CCS Web Service: $Result"

					if ($Global:Cs) {
						$Global:Cs.Job_WriteLog("$FunctionName Result for $Computer : $Result")
					}

					Write-Verbose "[$FunctionName] Result for $Computer : $Result"

					# Check for errors in result
					$IsError = Invoke-CCSIsError -Result $Result

					Write-Debug "IsError evaluation for result: $IsError"
					if ($IsError) {
						$FailureCount++

						# Determine appropriate error category based on result message
						$ErrorCat = [System.Management.Automation.ErrorCategory]::OperationStopped
						$RecommendedActionText = "Verify the computer name is correct."

						if ($Result -like '*does not exist*') {
							$ErrorCat = [System.Management.Automation.ErrorCategory]::ObjectNotFound
							$RecommendedActionText = "Verify that the computer '$Computer' exists in Active Directory."
						} elseif ($Result -like '*unwilling to process*') {
							$ErrorCat = [System.Management.Automation.ErrorCategory]::PermissionDenied
							$RecommendedActionText = "Check that the domain credentials have sufficient permissions to remove the computer."
						} elseif ($Result -like '*access*denied*' -or $Result -like '*permission*') {
							$ErrorCat = [System.Management.Automation.ErrorCategory]::PermissionDenied
							$RecommendedActionText = "Verify that the credentials have sufficient permissions to remove the computer."
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
							-ErrorMessage "Failed to remove computer '$Computer' from Active Directory: $Result" `
							-ErrorCategory $ErrorCat `
							-TargetObject $Computer `
							-FunctionName $FunctionName `
							-RecommendedAction $RecommendedActionText `
							-Throw:$ShouldThrow
					} else {
						$SuccessCount++
						Write-Verbose "[$FunctionName] Successfully removed $Computer from Active Directory"
						Write-Output $Result
					}
				} else {
					Write-Verbose "[$FunctionName] WhatIf: Would remove $Computer from Active Directory"
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
					-ErrorMessage "Exception occurred while processing computer '$Computer': $_" `
					-ErrorCategory InvalidOperation `
					-TargetObject $Computer `
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


function Remove-CCSADComputerFromSecurityGroup {
	<#
	.SYNOPSIS
		Removes a computer from a security group in Active Directory using the CCS Web Service.

	.DESCRIPTION
		Removes a computer from a security group in Active Directory using the CCS Web Service.
		This advanced function includes comprehensive error handling, input validation, and supports pipeline input.

	.PARAMETER ComputerName
		The name of the computer to be removed from the security group.
		Supports pipeline input and accepts multiple computer names.

	.PARAMETER SecurityGroupName
		The name of the security group from which the computer will be removed.

	.PARAMETER DomainOUPath
		The Organizational Unit (OU) path in which the computer resides.
		If not specified, searches the entire domain.
		Supports both standard DN format (OU=Computers,DC=example,DC=com) and LDAP format (LDAP://DC01.example.local/OU=Computers,DC=example,DC=com).

	.PARAMETER Domain
		The domain in which the computer resides.
		Must be a valid domain name format.

	.PARAMETER Url
		The URL of the CCS Web Service.
		Must be a valid URI format. Example: "https://example.com/CCSWebservice/CCS.asmx"

	.PARAMETER CCSCredential
		The credentials used to authenticate with the CCS Web Service.

	.PARAMETER DomainCredential
		The credentials of an account with permissions to remove the computer from the security group.
		If not defined, it will run in the CCS Web Service context.

	.PARAMETER PasswordIsEncrypted
		Indicates if the password in the DomainCredential is encrypted. Default is $false.

	.EXAMPLE
		PS C:\> Remove-CCSADComputerFromSecurityGroup -ComputerName "TestPC" -SecurityGroupName "TestGroup" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Removes TestPC from TestGroup using default CCS context.

	.EXAMPLE
		PS C:\> Remove-CCSADComputerFromSecurityGroup -ComputerName "TestPC" -SecurityGroupName "TestGroup" -DomainOUPath "OU=Computers,DC=example,DC=com" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential -DomainCredential $DomainCredential

		Removes TestPC from TestGroup using specific domain credentials and OU path.

	.EXAMPLE
		PS C:\> "PC01", "PC02", "PC03" | Remove-CCSADComputerFromSecurityGroup -SecurityGroupName "TestGroup" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Removes multiple computers from TestGroup using pipeline input.

	.EXAMPLE
		PS C:\> Remove-CCSADComputerFromSecurityGroup -ComputerName "TestPC" -SecurityGroupName "TestGroup" -DomainOUPath "LDAP://DC01.Firmax.local/DC=FirmaX,DC=local" -Domain "Firmax.local" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Removes TestPC from TestGroup using LDAP format for the OU path. The LDAP path will be automatically converted to standard DN format.

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
			HelpMessage = 'Enter the computer name to remove from the security group'
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('Name', 'Computer', 'CN')]
		[string[]]$ComputerName,

		[Parameter(
			Mandatory = $true,
			Position = 1,
			ValueFromPipelineByPropertyName = $true,
			HelpMessage = 'Enter the security group name'
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('GroupName', 'Group')]
		[string]$SecurityGroupName,

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
		Write-Verbose "[$FunctionName] SecurityGroupName: $SecurityGroupName"
		Write-Verbose "[$FunctionName] Domain: $Domain"
		Write-Verbose "[$FunctionName] DomainOUPath: $DomainOUPath"
		Write-Verbose "[$FunctionName] URL: $Url"

		# Initialize CCS connection once in begin block
		try {
			Write-Verbose "[$FunctionName] Initializing CCS Web Service connection"
			$CCS = Initialize-CCS -Url $Url -WebServiceCredential $CCSCredential -ErrorAction Stop
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
				-ErrorMessage "Failed to initialize CCS Web Service: $_" `
				-ErrorCategory ConnectionError `
				-TargetObject $Url `
				-FunctionName $FunctionName `
				-Exception $_.Exception `
				-RecommendedAction "Verify the URL is correct and the CCS Web Service is accessible. Check credentials." `
				-Throw:$ShouldThrow
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
				# Determine if we should throw based on the ErrorAction preference
				$ShouldThrow = $false
				if ($PSBoundParameters.ContainsKey('ErrorAction')) {
					$ShouldThrow = $PSBoundParameters['ErrorAction'] -eq 'Stop'
				} else {
					$ShouldThrow = $ErrorActionPreference -eq 'Stop'
				}

				Invoke-CCSErrorHandling `
					-ErrorMessage "Failed to process domain credential password: $_" `
					-ErrorCategory SecurityError `
					-FunctionName $FunctionName `
					-Exception $_.Exception `
					-RecommendedAction "Ensure the domain credential is valid and the password can be encrypted." `
					-Throw:$ShouldThrow
				return
			}
		} else {
			Write-Verbose "[$FunctionName] No domain credential provided, using CCS Web Service context"
		}

		$ProcessedCount = 0
		$SuccessCount = 0
		$FailureCount = 0
	}

	process {
		foreach ($Computer in $ComputerName) {
			$ProcessedCount++

			try {
				Write-Verbose "[$FunctionName] Processing computer: $Computer ($ProcessedCount)"

				if ($Global:Cs) {
					$Global:Cs.Job_WriteLog("$FunctionName Processing: ComputerName=$Computer, SecurityGroupName=$SecurityGroupName, DomainOUPath=$DomainOUPath, Domain=$Domain")
				}

				# ShouldProcess support
				$WhatIfMessage = "Remove computer '$Computer' from security group '$SecurityGroupName' in domain '$Domain'"
				if ($PSCmdlet.ShouldProcess($Computer, $WhatIfMessage)) {
					Write-Verbose "[$FunctionName] Calling ActiveDirectory_RemoveComputerFromSecurityGroup for $Computer"

					$Result = $CCS.ActiveDirectory_RemoveComputerFromSecurityGroup(
						$Computer,
						$SecurityGroupName,
						$DomainOUPath,
						$Domain,
						$ADUsername,
						$ADPassword
					)
					Write-Debug "Result from CCS Web Service: $Result"

					if ($Global:Cs) {
						$Global:Cs.Job_WriteLog("$FunctionName Result for $Computer : $Result")
					}

					Write-Verbose "[$FunctionName] Result for $Computer : $Result"

					# Check for errors in result
					$IsError = Invoke-CCSIsError -Result $Result

					Write-Debug "IsError evaluation for result: $IsError"
					if ($IsError) {
						$FailureCount++

						# Determine appropriate error category based on result message
						$ErrorCat = [System.Management.Automation.ErrorCategory]::OperationStopped
						$RecommendedActionText = "Verify the computer and security group names are correct."

						if ($Result -like '*does not exist*') {
							$ErrorCat = [System.Management.Automation.ErrorCategory]::ObjectNotFound
							$RecommendedActionText = "Verify that the computer '$Computer' and security group '$SecurityGroupName' exist in Active Directory."
						} elseif ($Result -like '*unwilling to process*') {
							$ErrorCat = [System.Management.Automation.ErrorCategory]::PermissionDenied
							$RecommendedActionText = "Check that the domain credentials have sufficient permissions to modify the security group."
						} elseif ($Result -like '*not a member*') {
							$ErrorCat = [System.Management.Automation.ErrorCategory]::InvalidOperation
							$RecommendedActionText = "The computer is not a member of the security group."
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
							-ErrorMessage "Failed to remove computer '$Computer' from security group '$SecurityGroupName': $Result" `
							-ErrorCategory $ErrorCat `
							-TargetObject $Computer `
							-FunctionName $FunctionName `
							-RecommendedAction $RecommendedActionText `
							-Throw:$ShouldThrow
					} else {
						$SuccessCount++
						Write-Verbose "[$FunctionName] Successfully removed $Computer from $SecurityGroupName"
						Write-Output $Result
					}
				} else {
					Write-Verbose "[$FunctionName] WhatIf: Would remove $Computer from $SecurityGroupName"
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
					-ErrorMessage "Exception occurred while processing computer '$Computer': $_" `
					-ErrorCategory InvalidOperation `
					-TargetObject $Computer `
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


function Remove-CCSADUserFromSecurityGroup {
	<#
	.SYNOPSIS
		Removes a user from a security group in Active Directory using the CCS Web Service.

	.DESCRIPTION
		Removes a user from a security group in Active Directory using the CCS Web Service.
		This advanced function includes comprehensive error handling, input validation, and supports pipeline input.

	.PARAMETER UserName
		The name of the user to be removed from the security group.
		Supports pipeline input and accepts multiple user names.

	.PARAMETER SecurityGroupName
		The name of the security group from which the user will be removed.

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
		The credentials of an account with permissions to remove the user from the security group.
		If not defined, it will run in the CCS Web Service context.

	.PARAMETER PasswordIsEncrypted
		Indicates if the password in the DomainCredential is encrypted. Default is $false.

	.EXAMPLE
		PS C:\> Remove-CCSADUserFromSecurityGroup -UserName "TestUser" -SecurityGroupName "TestGroup" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Removes TestUser from TestGroup using default CCS context.

	.EXAMPLE
		PS C:\> Remove-CCSADUserFromSecurityGroup -UserName "TestUser" -SecurityGroupName "TestGroup" -DomainOUPath "OU=Users,DC=example,DC=com" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential -DomainCredential $DomainCredential

		Removes TestUser from TestGroup using specific domain credentials and OU path.

	.EXAMPLE
		PS C:\> "User01", "User02", "User03" | Remove-CCSADUserFromSecurityGroup -SecurityGroupName "TestGroup" -Domain "example.com" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Removes multiple users from TestGroup using pipeline input.

	.EXAMPLE
		PS C:\> Remove-CCSADUserFromSecurityGroup -UserName "TestUser" -SecurityGroupName "TestGroup" -DomainOUPath "LDAP://DC01.Firmax.local/DC=FirmaX,DC=local" -Domain "Firmax.local" -Url "https://example.com/CCSWebservice/CCS.asmx" -CCSCredential $Credential

		Removes TestUser from TestGroup using LDAP format for the OU path. The LDAP path will be automatically converted to standard DN format.

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
			HelpMessage = 'Enter the user name to remove from the security group'
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('Name', 'User', 'SamAccountName')]
		[string[]]$UserName,

		[Parameter(
			Mandatory = $true,
			Position = 1,
			ValueFromPipelineByPropertyName = $true,
			HelpMessage = 'Enter the security group name'
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('GroupName', 'Group')]
		[string]$SecurityGroupName,

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
		Write-Verbose "[$FunctionName] SecurityGroupName: $SecurityGroupName"
		Write-Verbose "[$FunctionName] Domain: $Domain"
		Write-Verbose "[$FunctionName] DomainOUPath: $DomainOUPath"
		Write-Verbose "[$FunctionName] URL: $Url"

		# Initialize CCS connection once in begin block
		try {
			Write-Verbose "[$FunctionName] Initializing CCS Web Service connection"
			$CCS = Initialize-CCS -Url $Url -WebServiceCredential $CCSCredential -ErrorAction Stop
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
				-ErrorMessage "Failed to initialize CCS Web Service: $_" `
				-ErrorCategory ConnectionError `
				-TargetObject $Url `
				-FunctionName $FunctionName `
				-Exception $_.Exception `
				-RecommendedAction "Verify the URL is correct and the CCS Web Service is accessible. Check credentials." `
				-Throw:$ShouldThrow
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
				# Determine if we should throw based on the ErrorAction preference
				$ShouldThrow = $false
				if ($PSBoundParameters.ContainsKey('ErrorAction')) {
					$ShouldThrow = $PSBoundParameters['ErrorAction'] -eq 'Stop'
				} else {
					$ShouldThrow = $ErrorActionPreference -eq 'Stop'
				}

				Invoke-CCSErrorHandling `
					-ErrorMessage "Failed to process domain credential password: $_" `
					-ErrorCategory SecurityError `
					-FunctionName $FunctionName `
					-Exception $_.Exception `
					-RecommendedAction "Ensure the domain credential is valid and the password can be encrypted." `
					-Throw:$ShouldThrow
				return
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
					$Global:Cs.Job_WriteLog("$FunctionName Processing: UserName=$User, SecurityGroupName=$SecurityGroupName, DomainOUPath=$DomainOUPath, Domain=$Domain")
				}

				# ShouldProcess support
				$WhatIfMessage = "Remove user '$User' from security group '$SecurityGroupName' in domain '$Domain'"
				if ($PSCmdlet.ShouldProcess($User, $WhatIfMessage)) {
					Write-Verbose "[$FunctionName] Calling ActiveDirectory_RemoveUserFromSecurityGroup for $User"

					$Result = $CCS.ActiveDirectory_RemoveUserFromSecurityGroup(
						$User,
						$SecurityGroupName,
						$DomainOUPath,
						$Domain,
						$ADUsername,
						$ADPassword
					)
					Write-Debug "Result from CCS Web Service: $Result"

					if ($Global:Cs) {
						$Global:Cs.Job_WriteLog("$FunctionName Result for $User : $Result")
					}

					Write-Verbose "[$FunctionName] Result for $User : $Result"

					# Check for errors in result
					$IsError = Invoke-CCSIsError -Result $Result

					Write-Debug "IsError evaluation for result: $IsError"
					if ($IsError) {
						$FailureCount++

						# Determine appropriate error category based on result message
						$ErrorCat = [System.Management.Automation.ErrorCategory]::OperationStopped
						$RecommendedActionText = "Verify the user and security group names are correct."

						if ($Result -like '*does not exist*') {
							$ErrorCat = [System.Management.Automation.ErrorCategory]::ObjectNotFound
							$RecommendedActionText = "Verify that the user '$User' and security group '$SecurityGroupName' exist in Active Directory."
						} elseif ($Result -like '*unwilling to process*') {
							$ErrorCat = [System.Management.Automation.ErrorCategory]::PermissionDenied
							$RecommendedActionText = "Check that the domain credentials have sufficient permissions to modify the security group."
						} elseif ($Result -like '*not a member*') {
							$ErrorCat = [System.Management.Automation.ErrorCategory]::InvalidOperation
							$RecommendedActionText = "The user is not a member of the security group."
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
							-ErrorMessage "Failed to remove user '$User' from security group '$SecurityGroupName': $Result" `
							-ErrorCategory $ErrorCat `
							-TargetObject $User `
							-FunctionName $FunctionName `
							-RecommendedAction $RecommendedActionText `
							-Throw:$ShouldThrow
					} else {
						$SuccessCount++
						Write-Verbose "[$FunctionName] Successfully removed $User from $SecurityGroupName"
						Write-Output $Result
					}
				} else {
					Write-Verbose "[$FunctionName] WhatIf: Would remove $User from $SecurityGroupName"
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


