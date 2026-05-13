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
