<#
	.SYNOPSIS
		Set error code that the command is not recognized.

	.DESCRIPTION
		Uses the Exit-PSScript that comes from PSlib.psm1, to set the package error.

	.PARAMETER ExitMessage
		Exit message to be displayed.

	.EXAMPLE
		Exit-PpCommandNotRecognized

	.EXAMPLE
		Exit-PpCommandNotRecognized -ExitMessage "The command was not recognized."

	.NOTES
		Custom command.
#>
function Exit-PpCommandNotRecognized {
	[CmdletBinding()]
	[Alias('Exit_CommandNotRecognized')]
	param (
		[Parameter(Mandatory = $false)]
		[string]$ExitMessage
	)

	if ($ExitMessage) {
		Exit-PSSession -ExitCode 3307 -ExitMessage $ExitMessage
	} else {
		Exit-PSSession -ExitCode 3307
	}
}