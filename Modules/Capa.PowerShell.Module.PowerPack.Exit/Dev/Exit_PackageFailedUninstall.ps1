<#
	.SYNOPSIS
		Set error code that the package failed to uninstall.

	.DESCRIPTION
		Uses the Exit-PSScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit_PackageFailedUninstall

	.NOTES
		Custom command.
#>
function Exit_PackageFailedUninstall {
    Exit-PSScript 3332
}