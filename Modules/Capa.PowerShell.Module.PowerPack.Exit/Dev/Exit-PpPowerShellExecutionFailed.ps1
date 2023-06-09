<#
	.SYNOPSIS
		Set error code that the PowerShell execution failed.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit-PpPowerShellExecutionFailed

	.NOTES
		Custom command.
#>
function Exit-PpPowerShellExecutionFailed {
	[CmdletBinding()]
	[Alias('Exit_PowerShellExecutionFailed')]
	param (
		[Parameter(Mandatory = $false)]
		[string]$ExitMessage
	)

	if ($ExitMessage) {
		Exit-PpScript -ExitCode 3311 -ExitMessage $ExitMessage
	} else {
		Exit-PpScript -ExitCode 3311
	}
}