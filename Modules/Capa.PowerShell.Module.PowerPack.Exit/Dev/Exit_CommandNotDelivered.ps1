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