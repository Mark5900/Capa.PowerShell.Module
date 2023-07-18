<#
	.SYNOPSIS
		Set error code that the package is cancelled.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit-PpPackageCancelled

	.EXAMPLE
		Exit-PpPackageCancelled -ExitMessage 'Test where I set ExitMessage'

	.NOTES
		Custom command.
#>
function Exit-PpPackageCancelled {
	[CmdletBinding()]
	[Alias('Exit_PackageCancelled')]
	param (
		[Parameter(Mandatory = $false)]
		[string]$ExitMessage
	)

	if ($ExitMessage) {
		Exit-PpScript -ExitCode 3328 -ExitMessage $ExitMessage
	} else {
		Exit-PpScript -ExitCode 3328
	}
}