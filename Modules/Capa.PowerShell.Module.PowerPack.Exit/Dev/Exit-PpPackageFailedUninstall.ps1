<#
	.SYNOPSIS
		Set error code that the package failed to uninstall.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit-PpPackageFailedUninstall

	.NOTES
		Custom command.
#>
function Exit-PpPackageFailedUninstall {
	[CmdletBinding()]
	[Alias('Exit_PackageFailedUninstall')]
	param (
		[Parameter(Mandatory = $false)]
		[string]$ExitMessage
	)

	if ($ExitMessage) {
		Exit-PpScript -ExitCode 3332 -ExitMessage $ExitMessage
	} else {
		Exit-PpScript -ExitCode 3332
	}
}