<#
	.SYNOPSIS
		Set error code that a reboot is requested.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit-PpRebootRequested

	.NOTES
		Custom command.
#>
function Exit-PpRebootRequested {
	[CmdletBinding()]
	[Alias('Exit_CommandSucceded')]
	param (
		[Parameter(Mandatory = $false)]
		[string]$ExitMessage
	)

	if ($ExitMessage) {
		Exit-PpScript -ExitCode 3010 -ExitMessage $ExitMessage
	} else {
		Exit-PpScript -ExitCode 3010
	}
}