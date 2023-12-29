<#
	.SYNOPSIS
		Set error code that the command is obsolete.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.PARAMETER ExitMessage
		Exit message to display.

	.EXAMPLE
		Exit-PpCommandObsolete

	.EXAMPLE
		Exit-PpCommandObsolete -ExitMessage "This command is obsolete."

	.NOTES
		Custom command.

#>
function Exit-PpCommandObsolete {
	[CmdletBinding()]
	[Alias('Exit_CommandObsolete')]
	param(
		[Parameter(Mandatory = $false)]
		[string]$ExitMessage
	)

	if ($ExitMessage) {
		Exit-PpScript -ExitCode 3303 -ExitMessage $ExitMessage
	} else {
		Exit-PpScript -ExitCode 3303
	}
}
