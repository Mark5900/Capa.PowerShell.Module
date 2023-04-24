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