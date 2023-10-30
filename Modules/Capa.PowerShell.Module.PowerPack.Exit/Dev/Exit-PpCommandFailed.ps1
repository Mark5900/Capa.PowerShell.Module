<#
	.SYNOPSIS
		Set error code that the command failed.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit-PpCommandFailed

	.EXAMPLE
		Exit-PpCommandFailed -ExitMessage 'Test where I set ExitMessage'

	.NOTES
		Custom command.

#>
function Exit-PpCommandFailed {
	[CmdletBinding()]
	[Alias('Exit_CommandFailed')]
	param (
		[Parameter(Mandatory = $false)]
		[string]$ExitMessage
	)

	if ($ExitMessage) {
		Exit-PpScript -ExitCode 3305 -ExitMessage $ExitMessage
	} else {
		Exit-PpScript -ExitCode 3305
	}
}