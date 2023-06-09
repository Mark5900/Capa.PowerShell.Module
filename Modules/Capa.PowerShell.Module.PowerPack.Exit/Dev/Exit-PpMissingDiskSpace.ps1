<#
	.SYNOPSIS
		Set error code that there is missing disk space.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit-PpMissingDiskSpace

	.EXAMPLE
		Exit-PpMissingDiskSpace -ExitMessage 'Test where I set ExitMessage'

	.NOTES
		Custom command.
#>
function Exit-PpMissingDiskSpace {
	[CmdletBinding()]
	[Alias('Exit_MissingDiskSpace')]
	param (
		[Parameter(Mandatory = $false)]
		[string]$ExitMessage
	)

	if ($ExitMessage) {
		Exit-PpScript -ExitCode 3333 -ExitMessage $ExitMessage
	} else {
		Exit-PpScript -ExitCode 3333
	}
}