<#
	.SYNOPSIS
		Set error code that the command succeded.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit-PpCommandSucceded

	.EXAMPLE
		Exit-PpCommandSucceded -ExitMessage 'Test where I set ExitMessage'

	.NOTES
		Custom command.

#>
function Exit-PpCommandSucceded {
	[CmdletBinding()]
	[Alias('Exit_CommandSucceded')]
	param (
		[Parameter(Mandatory = $false)]
		[string]$ExitMessage
	)

	if ($ExitMessage) {
		Exit-PpScript -ExitCode 3300 -ExitMessage $ExitMessage
	} else {
		Exit-PpScript -ExitCode 3300
	}
}