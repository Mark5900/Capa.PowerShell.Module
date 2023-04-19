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
