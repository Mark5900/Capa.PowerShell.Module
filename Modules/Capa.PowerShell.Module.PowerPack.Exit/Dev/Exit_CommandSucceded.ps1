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