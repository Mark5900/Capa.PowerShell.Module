<#
	.SYNOPSIS
		Set error code that the command failed.

	.DESCRIPTION
		Uses the Exit-PSScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit-PpCommandFailed

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
		Exit-PSScript -ExitCode 3305 -ExitMessage $ExitMessage
	} else {
		Exit-PSScript -ExitCode 3305
	}
}