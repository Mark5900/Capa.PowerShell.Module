<#
	.SYNOPSIS
		Set error code that the command handling failed.

	.DESCRIPTION
		Uses the Exit-PSScript that comes from PSlib.psm1, to set the package error.

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
		Exit-PSScript -ExitCode 3306 -ExitMessage $ExitMessage
	} else {
		Exit-PSScript 3306
	}
}