<#
	.SYNOPSIS
		Set error code that the command timed out.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit_CommandTimedOut

	.NOTES
		Custom command.
#>
function Exit_CommandTimedOut {
    Exit-PpScript 3304
}