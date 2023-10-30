<#
	.SYNOPSIS
		Set error code that the package is not compliant.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit-PpPackageNotCompliant

	.EXAMPLE
		Exit-PpPackageNotCompliant -ExitMessage 'Test where I set ExitMessage'

	.NOTES
		Custom command.
#>
function Exit-PpPackageNotCompliant {
	[CmdletBinding()]
	[Alias('Exit_PackageNotCompliant')]
	param (
		[Parameter(Mandatory = $false)]
		[string]$ExitMessage
	)

	if ($ExitMessage) {
		Exit-PpScript -ExitCode 3327 -ExitMessage $ExitMessage
	} else {
		Exit-PpScript -ExitCode 3327
	}
}