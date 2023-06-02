<#
	.SYNOPSIS
		Set package retry later.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package retry later.

	.EXAMPLE
		Exit_RetryLater

	.NOTES
		Custom command.
#>
function Exit_RetryLater {
    Exit-PpScript 3326
}