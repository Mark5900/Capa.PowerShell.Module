<#
	.SYNOPSIS
		Set error code that the command was not delivered.

	.DESCRIPTION
		Uses the Exit-PSScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit-PpCommandNotDelivered

	.EXAMPLE
		Exit-PpCommandNotDelivered -ExitMessage 'The command was not delivered.'

	.NOTES
		Custom command.
#>
function Exit-PpCommandNotDelivered {
	[CmdletBinding()]
	[Alias('Exit_CommandNotDelivered')]
	param (
		[Parameter(Mandatory = $false)]
		[string]$ExitMessage
	)
	if ($ExitMessage) {
		Exit-PSScript -ExitCode 3302 -ExitMessage $ExitMessage
	} else {
		Exit-PSScript -ExitCode 3302
	}
}