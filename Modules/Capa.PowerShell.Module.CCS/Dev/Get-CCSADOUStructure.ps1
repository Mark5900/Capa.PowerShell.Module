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
