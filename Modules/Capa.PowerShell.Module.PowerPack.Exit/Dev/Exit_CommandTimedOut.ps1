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