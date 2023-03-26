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