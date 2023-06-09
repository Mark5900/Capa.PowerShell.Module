<#
	.SYNOPSIS
		Set package retry later.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package retry later.

	.EXAMPLE
		Exit-PpRetryLater

	.NOTES
		Custom command.
#>
function Exit-PpRetryLater {
	[CmdletBinding()]
	[Alias('Exit_CommandSucceded')]
	param (
		[Parameter(Mandatory = $false)]
		[string]$ExitMessage
	)

	if ($ExitMessage) {
		Exit-PpScript -ExitCode 3326 -ExitMessage $ExitMessage
	} else {
		Exit-PpScript -ExitCode 3326
	}
}