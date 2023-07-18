<#
	.SYNOPSIS
		Set error code that the module was not found.

	.DESCRIPTION
		Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit-PpModuleNotFound

	.EXAMPLE
		Exit-PpModuleNotFound -ExitMessage 'Test where I set ExitMessage'

	.NOTES
		Custom command.
#>
function Exit-PpModuleNotFound {
	[CmdletBinding()]
	[Alias('Exit_ModuleNotFound')]
	param (
		[Parameter(Mandatory = $false)]
		[string]$ExitMessage
	)

	if ($ExitMessage) {
		Exit-PpScript -ExitCode 3301 -ExitMessage $ExitMessage
	} else {
		Exit-PpScript -ExitCode 3301
	}
}