<#
	.SYNOPSIS
		Set error code that there is missing disk space.

	.DESCRIPTION
		Uses the Exit-PSScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit_MissingDiskSpace

	.NOTES
		Custom command.
#>
function Exit_MissingDiskSpace {
    Exit-PSScript 3333
}