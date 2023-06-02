<#
	.SYNOPSIS
		Set error code that the application is already installed.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.PARAMETER ExitMessage
		Exit message to be displayed.

	.EXAMPLE
		Exit-PpApplicationAlreadyInstalled

	.EXAMPLE
		Exit-PpApplicationAlreadyInstalled -ExitMessage "The application is already installed."

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
		Exit-PpScript -ExitCode 3330 -ExitMessage $ExitMessage
	} else {
		Exit-PpScript -ExitCode 3330
	}

}