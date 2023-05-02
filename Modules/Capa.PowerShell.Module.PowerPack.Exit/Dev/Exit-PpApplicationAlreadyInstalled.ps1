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
	param ()
	
	Exit-PSScript 3330
}