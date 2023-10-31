# TODO: Update and add tests

<#
	.SYNOPSIS
		Waits for a process to exist.

	.PARAMETER ProcessName
		The name of the process to wait for.

	.PARAMETER MaxWaitSec
		The maximum time to wait in seconds.

	.PARAMETER IntervalSec
		The interval to check in seconds.

	.EXAMPLE
		PS C:\> Sys_WaitForProcessToExist -ProcessName "notepad.exe" -MaxWaitSec 10 -IntervalSec 1

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462456142/cs.Sys+WaitForProcessToExist
#>
function Sys_WaitForProcessToExist {
	param (
		[Parameter(Mandatory = $true)]
		[string]$ProcessName,
		[Parameter(Mandatory = $true)]
		[int]$MaxWaitSec,
		[Parameter(Mandatory = $true)]
		[int]$IntervalSec
	)

	$Global:cs.Sys_WaitForProcessToExist($ProcessName, $MaxWaitSec, $IntervalSec)
}
