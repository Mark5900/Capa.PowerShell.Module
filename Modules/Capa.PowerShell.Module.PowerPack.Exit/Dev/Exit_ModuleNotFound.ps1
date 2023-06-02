<#
	.SYNOPSIS
		Set error code that the module was not found.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit_ModuleNotFound

	.NOTES
		Custom command.
#>
function Exit_ModuleNotFound {
    Exit-PpScript 3301
}