<#
	.SYNOPSIS
		Set error code that the PowerShell execution failed.

	.DESCRIPTION
		Uses the Exit-PSScript that comes from PSlib.psm1, to set the package error.

	.EXAMPLE
		Exit_PowerShellExecutionFailed

	.NOTES
		Custom command.
#>
function Exit_PowerShellExecutionFailed {
    Exit-PSScript 3311
}