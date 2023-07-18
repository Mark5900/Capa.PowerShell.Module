<#
	.SYNOPSIS
		Set error code that the command timed out.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit-PpCommandTimedOut

	.EXAMPLE
		Exit-PpCommandTimedOut -ExitMessage 'Test where I set ExitMessage'

	.NOTES
		Custom command.
#>
function Exit-PpCommandTimedOut {
	[CmdletBinding()]
	[Alias('Exit_CommandTimedOut')]
	param (
		[Parameter(Mandatory = $false)]
		[string]$ExitMessage
	)

	if ($ExitMessage) {
		Exit-PpScript -ExitCode 3304 -ExitMessage $ExitMessage
	} else {
		Exit-PpScript -ExitCode 3304
	}
}