<#
	.SYNOPSIS
		Set error code that the package failed to install.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit-PpPackageFailedInstall

	.EXAMPLE
		Exit-PpPackageFailedInstall -ExitMessage 'Test where I set ExitMessage'

	.NOTES
		Custom command.
#>
function Exit-PpPackageFailedInstall {
	[CmdletBinding()]
	[Alias('Exit_PackageFailedInstall')]
	param (
		[Parameter(Mandatory = $false)]
		[string]$ExitMessage
	)

	if ($ExitMessage) {
		Exit-PpScript -ExitCode 3329 -ExitMessage $ExitMessage
	} else {
		Exit-PpScript -ExitCode 3329
	}
}