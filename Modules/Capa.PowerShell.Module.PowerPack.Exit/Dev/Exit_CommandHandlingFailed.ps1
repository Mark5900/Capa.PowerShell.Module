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