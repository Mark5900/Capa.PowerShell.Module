
<#
	.SYNOPSIS
		Set error code that the application is already installed.

	.DESCRIPTION
		Uses the Exit-PSScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit_ApplicationAlreadyInstalled

	.NOTES
		Custom command.
#>
function Exit_ApplicationAlreadyInstalled {
    Exit-PSScript 3330
}


<#
	.SYNOPSIS
		Set error code that the command failed.

	.DESCRIPTION
		Uses the Exit-PSScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit_CommandFailed

	.NOTES
		Custom command.

#>
function Exit_CommandFailed {
    Exit-PSScript 3305
}


<#
	.SYNOPSIS
		Set error code that the command handling failed.

	.DESCRIPTION
		Uses the Exit-PSScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit_CommandHandlingFailed

	.NOTES
		Custom command.
#>
function Exit_CommandHandlingFailed {
    Exit-PSScript 3306
}


<#
	.SYNOPSIS
		Set error code that the command was not delivered.

	.DESCRIPTION
		Uses the Exit-PSScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit_CommandNotDelivered

	.NOTES
		Custom command.
#>
function Exit_CommandNotDelivered {
    Exit-PSScript 3302
}


<#
	.SYNOPSIS
		Set error code that the command is not recognized.

	.DESCRIPTION
		Uses the Exit-PSScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit_CommandNotRecognized

	.NOTES
		Custom command.
#>
function Exit_CommandNotRecognized {
    Exit-PSScript 3307
}


<#
	.SYNOPSIS
		Set error code that the command is obsolete.

	.DESCRIPTION
		Uses the Exit-PSScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit_CommandObsolete

	.NOTES
		Custom command.

#>
function Exit_CommandObsolete {
    Exit-PSScript 3303
}


<#
	.SYNOPSIS
		Set error code that the command succeded.

	.DESCRIPTION
		Uses the Exit-PSScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit_CommandSucceded

	.NOTES
		Custom command.

#>
function Exit_CommandSucceded {
    Exit-PSScript 3300
}


<#
	.SYNOPSIS
		Set error code that the command timed out.

	.DESCRIPTION
		Uses the Exit-PSScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit_CommandTimedOut

	.NOTES
		Custom command.
#>
function Exit_CommandTimedOut {
    Exit-PSScript 3304
}


<#
	.SYNOPSIS
		Set error code that there is missing disk space.

	.DESCRIPTION
		Uses the Exit-PSScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit_MissingDiskSpace

	.NOTES
		Custom command.
#>
function Exit_MissingDiskSpace {
    Exit-PSScript 3333
}


<#
	.SYNOPSIS
		Set error code that the module was not found.

	.DESCRIPTION
		Uses the Exit-PSScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit_ModuleNotFound

	.NOTES
		Custom command.
#>
function Exit_ModuleNotFound {
    Exit-PSScript 3301
}


<#
	.SYNOPSIS
		Set error code that the package is cancelled.

	.DESCRIPTION
		Uses the Exit-PSScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit_PackageCancelled

	.NOTES
		Custom command.
#>
function Exit_PackageCancelled {
    Exit-PSScript 3328
}


<#
	.SYNOPSIS
		Set error code that the package failed to install.

	.DESCRIPTION
		Uses the Exit-PSScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit_PackageFailedInstall

	.NOTES
		Custom command.
#>
function Exit_PackageFailedInstall {
    Exit-PSScript 3329
}


<#
	.SYNOPSIS
		Set error code that the package failed to uninstall.

	.DESCRIPTION
		Uses the Exit-PSScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit_PackageFailedUninstall

	.NOTES
		Custom command.
#>
function Exit_PackageFailedUninstall {
    Exit-PSScript 3332
}


<#
	.SYNOPSIS
		Set error code that the package is not compliant.

	.DESCRIPTION
		Uses the Exit-PSScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit_PackageNotCompliant

	.NOTES
		Custom command.
#>
function Exit_PackageNotCompliant {
    Exit-PSScript 3327
}


<#
	.SYNOPSIS
		Set error code that the PowerShell execution failed.

	.DESCRIPTION
		Uses the Exit-PSScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit_PowerShellExecutionFailed

	.NOTES
		Custom command.
#>
function Exit_PowerShellExecutionFailed {
    Exit-PSScript 3311
}


<#
	.SYNOPSIS
		Set error code that a reboot is requested.

	.DESCRIPTION
		Uses the Exit-PSScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit_RebootRequested

	.NOTES
		Custom command.
#>
function Exit_RebootRequested {
    Exit-PSScript 3010
}


<#
	.SYNOPSIS
		Set package retry later.

	.DESCRIPTION
		Uses the Exit-PSScript that comes from PSlib.psm1, to set the package retry later.

	.EXAMPLE
		Exit_RetryLater

	.NOTES
		Custom command.
#>
function Exit_RetryLater {
    Exit-PSScript 3326
}


