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