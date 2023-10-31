# TODO: Update and add tests

<#
	.SYNOPSIS
		Checks if a process exists.

	.PARAMETER ProcessName
		The name of the process to check.

	.EXAMPLE
		PS C:\> Sys_ExistProcess -ProcessName "notepad.exe"

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462456074/cs.Sys+ExistProcess
#>
function Sys_ExistProcess {
	param (
		[Parameter(Mandatory = $true)]
		[string]$ProcessName
	)

	$Value = $Global:cs.Sys_ExistProcess($ProcessName)

	return $Value
}
