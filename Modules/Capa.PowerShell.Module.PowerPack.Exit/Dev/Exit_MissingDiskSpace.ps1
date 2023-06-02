<#
	.SYNOPSIS
		Set error code that there is missing disk space.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit_MissingDiskSpace

	.NOTES
		Custom command.
#>
function Exit_MissingDiskSpace {
    Exit-PpScript 3333
}