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