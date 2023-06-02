<#
	.SYNOPSIS
		Set error code that the package failed to install.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit_PackageFailedInstall

	.NOTES
		Custom command.
#>
function Exit_PackageFailedInstall {
    Exit-PpScript 3329
}