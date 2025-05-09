# TODO: #106 Update and add tests

<#
	.SYNOPSIS
		Kills a process.

	.DESCRIPTION
		This function kills a process by its name.

	.PARAMETER ProcessName
		The name of the process to kill.

	.EXAMPLE
		PS C:\> Sys_KillProcess -ProcessName "notepad.exe"

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462456091/cs.Sys+KillProcess
#>
function Sys_KillProcess {
	param (
		[Parameter(Mandatory = $true)]
		[string]$ProcessName
	)

	$Global:cs.Sys_KillProcess($ProcessName)
}
