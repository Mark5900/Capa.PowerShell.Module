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
