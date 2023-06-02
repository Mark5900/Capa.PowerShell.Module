<#
	.SYNOPSIS
		Set error code that the package is not compliant.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit_PackageNotCompliant

	.NOTES
		Custom command.
#>
function Exit_PackageNotCompliant {
    Exit-PpScript 3327
}