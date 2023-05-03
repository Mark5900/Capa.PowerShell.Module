<#
	.SYNOPSIS
		Set error code that the application is already installed.

	.DESCRIPTION
		Uses the Exit-PSScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit-PpApplicationAlreadyInstalled

	.NOTES
		Custom command.
#>
function Exit-PpApplicationAlreadyInstalled {
	[CmdletBinding()]
	[Alias('Exit_ApplicationAlreadyInstalled')]
	param (
		[Parameter(Mandatory = $false)]
		[string]$ExitMessage
	)
	
	if ($ExitMessage) {
		Exit-PSScript -ExitCode 3330 -ExitMessage $ExitMessage
	} else {
		Exit-PSScript -ExitCode 3330
	}

}