
<#
	.SYNOPSIS
		Set error code that the application is already installed.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.PARAMETER ExitMessage
		Exit message to be displayed.

	.EXAMPLE
		Exit-PpApplicationAlreadyInstalled

	.EXAMPLE
		Exit-PpApplicationAlreadyInstalled -ExitMessage "The application is already installed."

	.NOTES
		Custom command.
#>
function Exit-PpApplicationAlreadyInstalled {
	[CmdletBinding()]
	[Alias('Exit_ApplicationAlreadyInstalled')]
	param (
		[Parameter(Mandatory = $false)]
		[string]$ExitMessage
	)
	
	if ($ExitMessage) {
		Exit-PpScript -ExitCode 3330 -ExitMessage $ExitMessage
	} else {
		Exit-PpScript -ExitCode 3330
	}

}


<#
	.SYNOPSIS
		Set error code that the command failed.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit-PpCommandFailed

	.EXAMPLE
		Exit-PpCommandFailed -ExitMessage 'Test where I set ExitMessage'

	.NOTES
		Custom command.

#>
function Exit-PpCommandFailed {
	[CmdletBinding()]
	[Alias('Exit_CommandFailed')]
	param (
		[Parameter(Mandatory = $false)]
		[string]$ExitMessage
	)

	if ($ExitMessage) {
		Exit-PpScript -ExitCode 3305 -ExitMessage $ExitMessage
	} else {
		Exit-PpScript -ExitCode 3305
	}
}


<#
	.SYNOPSIS
		Set error code that the command handling failed.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.PARAMETER ExitMessage
		Exit message to set.

	.EXAMPLE
		Exit-PpCommandHandlingFailed

	.EXAMPLE
		Exit-PpCommandHandlingFailed -ExitMessage 'Test where I set ExitMessage'

	.NOTES
		Custom command.
#>
function Exit-PpCommandHandlingFailed {
	[CmdletBinding()]
	[Alias('Exit_CommandHandlingFailed')]
	param (
		[Parameter(Mandatory = $false)]
		[string]$ExitMessage
	)

	if ($ExitMessage) {
		Exit-PpScript -ExitCode 3306 -ExitMessage $ExitMessage
	} else {
		Exit-PpScript 3306
	}
}


<#
	.SYNOPSIS
		Set error code that the command was not delivered.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.PARAMETER ExitMessage
		Exit message to be displayed.

	.EXAMPLE
		Exit-PpCommandNotDelivered

	.EXAMPLE
		Exit-PpCommandNotDelivered -ExitMessage 'The command was not delivered.'

	.NOTES
		Custom command.
#>
function Exit-PpCommandNotDelivered {
	[CmdletBinding()]
	[Alias('Exit_CommandNotDelivered')]
	param (
		[Parameter(Mandatory = $false)]
		[string]$ExitMessage
	)
	if ($ExitMessage) {
		Exit-PpScript -ExitCode 3302 -ExitMessage $ExitMessage
	} else {
		Exit-PpScript -ExitCode 3302
	}
}


<#
	.SYNOPSIS
		Set error code that the command is not recognized.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.PARAMETER ExitMessage
		Exit message to be displayed.

	.EXAMPLE
		Exit-PpCommandNotRecognized

	.EXAMPLE
		Exit-PpCommandNotRecognized -ExitMessage "The command was not recognized."

	.NOTES
		Custom command.
#>
function Exit-PpCommandNotRecognized {
	[CmdletBinding()]
	[Alias('Exit_CommandNotRecognized')]
	param (
		[Parameter(Mandatory = $false)]
		[string]$ExitMessage
	)

	if ($ExitMessage) {
		Exit-PpScript -ExitCode 3307 -ExitMessage $ExitMessage
	} else {
		Exit-PpScript -ExitCode 3307
	}
}


<#
	.SYNOPSIS
		Set error code that the command is obsolete.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.PARAMETER ExitMessage
		Exit message to display.

	.EXAMPLE
		Exit-PpCommandObsolete

	.EXAMPLE
		Exit-PpCommandObsolete -ExitMessage "This command is obsolete."

	.NOTES
		Custom command.

#>
function Exit-PpCommandObsolete {
	[CmdletBinding()]
	[Alias('Exit_CommandObsolete')]
	param(
		[Parameter(Mandatory = $false)]
		[string]$ExitMessage
	)

	if ($ExitMessage) {
		Exit-PpScript -ExitCode 3303 -ExitMessage $ExitMessage
	} else {
		Exit-PpScript -ExitCode 3303
	}
}


<#
	.SYNOPSIS
		Set error code that the command succeded.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit-PpCommandSucceded

	.EXAMPLE
		Exit-PpCommandSucceded -ExitMessage 'Test where I set ExitMessage'

	.NOTES
		Custom command.

#>
function Exit-PpCommandSucceded {
	[CmdletBinding()]
	[Alias('Exit_CommandSucceded')]
	param (
		[Parameter(Mandatory = $false)]
		[string]$ExitMessage
	)

	if ($ExitMessage) {
		Exit-PpScript -ExitCode 3300 -ExitMessage $ExitMessage
	} else {
		Exit-PpScript -ExitCode 3300
	}
}


<#
	.SYNOPSIS
		Set error code that the command timed out.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit-PpCommandTimedOut

	.EXAMPLE
		Exit-PpCommandTimedOut -ExitMessage 'Test where I set ExitMessage'

	.NOTES
		Custom command.
#>
function Exit-PpCommandTimedOut {
	[CmdletBinding()]
	[Alias('Exit_CommandTimedOut')]
	param (
		[Parameter(Mandatory = $false)]
		[string]$ExitMessage
	)

	if ($ExitMessage) {
		Exit-PpScript -ExitCode 3304 -ExitMessage $ExitMessage
	} else {
		Exit-PpScript -ExitCode 3304
	}
}


<#
	.SYNOPSIS
		Set error code that there is missing disk space.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit-PpMissingDiskSpace

	.EXAMPLE
		Exit-PpMissingDiskSpace -ExitMessage 'Test where I set ExitMessage'

	.NOTES
		Custom command.
#>
function Exit-PpMissingDiskSpace {
	[CmdletBinding()]
	[Alias('Exit_MissingDiskSpace')]
	param (
		[Parameter(Mandatory = $false)]
		[string]$ExitMessage
	)

	if ($ExitMessage) {
		Exit-PpScript -ExitCode 3333 -ExitMessage $ExitMessage
	} else {
		Exit-PpScript -ExitCode 3333
	}
}


<#
	.SYNOPSIS
		Set error code that the module was not found.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit-PpModuleNotFound

	.EXAMPLE
		Exit-PpModuleNotFound -ExitMessage 'Test where I set ExitMessage'

	.NOTES
		Custom command.
#>
function Exit-PpModuleNotFound {
	[CmdletBinding()]
	[Alias('Exit_ModuleNotFound')]
	param (
		[Parameter(Mandatory = $false)]
		[string]$ExitMessage
	)

	if ($ExitMessage) {
		Exit-PpScript -ExitCode 3301 -ExitMessage $ExitMessage
	} else {
		Exit-PpScript -ExitCode 3301
	}
}


<#
	.SYNOPSIS
		Set error code that the package is cancelled.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit-PpPackageCancelled

	.EXAMPLE
		Exit-PpPackageCancelled -ExitMessage 'Test where I set ExitMessage'

	.NOTES
		Custom command.
#>
function Exit-PpPackageCancelled {
	[CmdletBinding()]
	[Alias('Exit_PackageCancelled')]
	param (
		[Parameter(Mandatory = $false)]
		[string]$ExitMessage
	)

	if ($ExitMessage) {
		Exit-PpScript -ExitCode 3328 -ExitMessage $ExitMessage
	} else {
		Exit-PpScript -ExitCode 3328
	}
}


<#
	.SYNOPSIS
		Set error code that the package failed to install.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit-PpPackageFailedInstall

	.EXAMPLE
		Exit-PpPackageFailedInstall -ExitMessage 'Test where I set ExitMessage'

	.NOTES
		Custom command.
#>
function Exit-PpPackageFailedInstall {
	[CmdletBinding()]
	[Alias('Exit_PackageFailedInstall')]
	param (
		[Parameter(Mandatory = $false)]
		[string]$ExitMessage
	)

	if ($ExitMessage) {
		Exit-PpScript -ExitCode 3329 -ExitMessage $ExitMessage
	} else {
		Exit-PpScript -ExitCode 3329
	}
}


<#
	.SYNOPSIS
		Set error code that the package failed to uninstall.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit-PpPackageFailedUninstall

	.EXAMPLE
		Exit-PpPackageFailedUninstall -ExitMessage 'Test where I set ExitMessage'

	.NOTES
		Custom command.
#>
function Exit-PpPackageFailedUninstall {
	[CmdletBinding()]
	[Alias('Exit_PackageFailedUninstall')]
	param (
		[Parameter(Mandatory = $false)]
		[string]$ExitMessage
	)

	if ($ExitMessage) {
		Exit-PpScript -ExitCode 3332 -ExitMessage $ExitMessage
	} else {
		Exit-PpScript -ExitCode 3332
	}
}


<#
	.SYNOPSIS
		Set error code that the package is not compliant.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit-PpPackageNotCompliant

	.EXAMPLE
		Exit-PpPackageNotCompliant -ExitMessage 'Test where I set ExitMessage'

	.NOTES
		Custom command.
#>
function Exit-PpPackageNotCompliant {
	[CmdletBinding()]
	[Alias('Exit_PackageNotCompliant')]
	param (
		[Parameter(Mandatory = $false)]
		[string]$ExitMessage
	)

	if ($ExitMessage) {
		Exit-PpScript -ExitCode 3327 -ExitMessage $ExitMessage
	} else {
		Exit-PpScript -ExitCode 3327
	}
}


<#
	.SYNOPSIS
		Set error code that the PowerShell execution failed.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit-PpPowerShellExecutionFailed

	.EXAMPLE
		Exit-PpPowerShellExecutionFailed -ExitMessage 'Test where I set ExitMessage'

	.NOTES
		Custom command.
#>
function Exit-PpPowerShellExecutionFailed {
	[CmdletBinding()]
	[Alias('Exit_PowerShellExecutionFailed')]
	param (
		[Parameter(Mandatory = $false)]
		[string]$ExitMessage
	)

	if ($ExitMessage) {
		Exit-PpScript -ExitCode 3311 -ExitMessage $ExitMessage
	} else {
		Exit-PpScript -ExitCode 3311
	}
}


<#
	.SYNOPSIS
		Set error code that a reboot is requested.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit-PpRebootRequested

	.EXAMPLE
		Exit-PpRebootRequested -ExitMessage 'Test where I set ExitMessage'

	.NOTES
		Custom command.
#>
function Exit-PpRebootRequested {
	[CmdletBinding()]
	[Alias('Exit_CommandSucceded')]
	param (
		[Parameter(Mandatory = $false)]
		[string]$ExitMessage
	)

	if ($ExitMessage) {
		Exit-PpScript -ExitCode 3010 -ExitMessage $ExitMessage
	} else {
		Exit-PpScript -ExitCode 3010
	}
}


<#
	.SYNOPSIS
		Set package retry later.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package retry later.

	.EXAMPLE
		Exit-PpRetryLater

	.EXAMPLE
		Exit-PpRetryLater -ExitMessage 'Test where I set ExitMessage'

	.NOTES
		Custom command.
#>
function Exit-PpRetryLater {
	[CmdletBinding()]
	[Alias('Exit_CommandSucceded')]
	param (
		[Parameter(Mandatory = $false)]
		[string]$ExitMessage
	)

	if ($ExitMessage) {
		Exit-PpScript -ExitCode 3326 -ExitMessage $ExitMessage
	} else {
		Exit-PpScript -ExitCode 3326
	}
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
    $Global:Cs.AutoSectionHeader = $false
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
    if ($Global:InputObject) {
        $Global:InputObject.ExitCode = $ExitNumber
    }
    exit $ExitNumber
}


