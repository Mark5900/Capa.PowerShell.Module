<#
	.SYNOPSIS
		Set error code that the package is cancelled.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit_PackageCancelled

	.NOTES
		Custom command.
#>
function Exit_PackageCancelled {
    Exit-PpScript 3328
}