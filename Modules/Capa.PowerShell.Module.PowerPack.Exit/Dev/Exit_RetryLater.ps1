<#
	.SYNOPSIS
		Set package retry later.

	.DESCRIPTION
		Uses the Exit-PSScript that comes from PSlib.psm1, to set the package retry later.

	.EXAMPLE
		Exit_RetryLater

	.NOTES
		Custom command.
#>
function Exit_RetryLater {
    Exit-PSScript 3326
}