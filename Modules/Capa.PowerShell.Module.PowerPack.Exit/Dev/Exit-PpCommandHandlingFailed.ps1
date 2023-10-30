<#
	.SYNOPSIS
		Set error code that the command handling failed.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.PARAMETER ExitMessage
		Exit message to set.

	.EXAMPLE
		Exit-PpCommandHandlingFailed

	.EXAMPLE
		Exit-PpCommandHandlingFailed -ExitMessage 'Test where I set ExitMessage'

	.NOTES
		Custom command.
#>
function Exit-PpCommandHandlingFailed {
	[CmdletBinding()]
	[Alias('Exit_CommandHandlingFailed')]
	param (
		[Parameter(Mandatory = $false)]
		[string]$ExitMessage
	)

	if ($ExitMessage) {
		Exit-PpScript -ExitCode 3306 -ExitMessage $ExitMessage
	} else {
		Exit-PpScript 3306
	}
}