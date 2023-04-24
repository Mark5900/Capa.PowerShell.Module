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