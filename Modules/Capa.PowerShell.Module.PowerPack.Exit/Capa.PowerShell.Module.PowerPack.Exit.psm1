
<#
	.SYNOPSIS
		Set error code that the application is already installed.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit_ApplicationAlreadyInstalled

	.NOTES
		Custom command.
#>
function Exit_ApplicationAlreadyInstalled {
	Exit-PpScript 3330
}


<#
	.SYNOPSIS
		Set error code that the command failed.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit-PpCommandFailed

	.NOTES
		Custom command.

#>
function Exit-PpCommandFailed {
	Exit-PpScript 3305
}


<#
	.SYNOPSIS
		Set error code that the command handling failed.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit_CommandHandlingFailed

	.NOTES
		Custom command.
#>
function Exit_CommandHandlingFailed {
	Exit-PpScript 3306
}


<#
	.SYNOPSIS
		Set error code that the command was not delivered.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit-PpCommandNotDelivered

	.NOTES
		Custom command.
#>
function Exit-PpCommandNotDelivered {
	Exit-PpScript 3302
}


<#
	.SYNOPSIS
		Set error code that the command is not recognized.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit-PpCommandNotRecognized

	.NOTES
		Custom command.
#>
function Exit-PpCommandNotRecognized {
	Exit-PpScript 3307
}


<#
	.SYNOPSIS
		Set error code that the command is obsolete.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit-PpCommandObsolete

	.NOTES
		Custom command.

#>
function Exit-PpCommandObsolete {
	Exit-PpScript 3303
}


<#
	.SYNOPSIS
		Set error code that the command succeded.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit-PpCommandSucceded

	.NOTES
		Custom command.

#>
function Exit-PpCommandSucceded {
	Exit-PpScript 3300
}


<#
	.SYNOPSIS
		Set error code that the command timed out.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit-PpCommandTimedOut

	.NOTES
		Custom command.
#>
function Exit-PpCommandTimedOut {
	Exit-PpScript 3304
}


<#
	.SYNOPSIS
		Set error code that there is missing disk space.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit-PpMissingDiskSpace

	.NOTES
		Custom command.
#>
function Exit-PpMissingDiskSpace {
	Exit-PpScript 3333
}


<#
	.SYNOPSIS
		Set error code that the module was not found.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit-PpModuleNotFound

	.NOTES
		Custom command.
#>
function Exit-PpModuleNotFound {
	Exit-PpScript 3301
}


<#
	.SYNOPSIS
		Set error code that the package is cancelled.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit-PpPackageCancelled

	.NOTES
		Custom command.
#>
function Exit-PpPackageCancelled {
	Exit-PpScript 3328
}


<#
	.SYNOPSIS
		Set error code that the package failed to install.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit-PpPackageFailedInstall

	.NOTES
		Custom command.
#>
function Exit-PpPackageFailedInstall {
	Exit-PpScript 3329
}


<#
	.SYNOPSIS
		Set error code that the package failed to uninstall.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit-PpPackageFailedUninstall

	.NOTES
		Custom command.
#>
function Exit-PpPackageFailedUninstall {
	Exit-PpScript 3332
}


<#
	.SYNOPSIS
		Set error code that the package is not compliant.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit-PpPackageNotCompliant

	.NOTES
		Custom command.
#>
function Exit-PpPackageNotCompliant {
	Exit-PpScript 3327
}


<#
	.SYNOPSIS
		Set error code that the PowerShell execution failed.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit-PpPowerShellExecutionFailed

	.NOTES
		Custom command.
#>
function Exit-PpPowerShellExecutionFailed {
	Exit-PpScript 3311
}


<#
	.SYNOPSIS
		Set error code that a reboot is requested.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit-PpRebootRequested

	.NOTES
		Custom command.
#>
function Exit-PpRebootRequested {
	Exit-PpScript 3010
}


<#
	.SYNOPSIS
		Set package retry later.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package retry later.

	.EXAMPLE
		Exit_RetryLater

	.NOTES
		Custom command.
#>
function Exit_RetryLater {
	Exit-PpScript 3326
}


<#
    .SYNOPSIS
        Exit the script with a given exit code and message.

    .DESCRIPTION
        Exit the script with a given exit code and message.

    .PARAMETER ExitCode
        The exit code to exit the script with.

    .PARAMETER ExitMessage
        The message to write to the log before exiting the script.

    .EXAMPLE
        Exit-PpScript -ExitCode 0 -ExitMessage "Script ended successfully"

    .EXAMPLE
        Exit-PpScript -ExitCode 3305

    .NOTES
        Command from PSlib.psm1
#>
function Exit-PpScript() {
	[CmdletBinding()]
	Param(
		[Parameter(Mandatory = $true)]
		$ExitCode,
		[Parameter(Mandatory = $false)]
		[string]$ExitMessage
	)
	$cs.AutoSectionHeader = $false
	if ($ExitMessage) { 
		Job_WriteLog -Text $ExitMessage
	}
    
	$IgnoreAndContinueErrors = @(3010)

	if ($ExitCode.count -eq 0) { 
		$ExitNumber = 0
		[string]$ErrorMessage = "SCRIPT ENDED WITH EXITCODE: $($ExitNumber)" 
	} elseif ($ExitCode -is [System.Collections.ArrayList]) {
		$ExitNumber = $ExitCode[0].Exception.HResult
		if (!$IgnoreAndContinueErrors.Contains($ExitNumber)) { 
			Job_WriteLog -Text "$($ExitCode[0].Exception.Message)"
		}
		$ErrorMessage = "SCRIPT ENDED WITH EXITCODE: $($ExitNumber) - in line: $($ExitCode[0].InvocationInfo.ScriptLineNumber)"
	} else {
		# Must be integer - handle as such
		if ([string]::IsNullOrWhiteSpace($ExitCode)) { 
			$ExitCode = 0 
		}
		if ($IgnoreAndContinueErrors.Contains($ExitCode)) {
			$Ex = New-Object System.ApplicationException
			$Ex.hresult = $ExitCode
			Write-Error -Exception $Ex -ErrorAction SilentlyContinue
			return
		} else {
			$ExitNumber = $ExitCode
			[string]$ErrorMessage = "SCRIPT ENDED WITH EXITCODE: $($ExitNumber)"
		}
	}
    
	Job_WriteLog -Text $ErrorMessage
	if ($InputObject) {
		$InputObject.ExitCode = $ExitNumber 
	}
	exit $ExitNumber
}


