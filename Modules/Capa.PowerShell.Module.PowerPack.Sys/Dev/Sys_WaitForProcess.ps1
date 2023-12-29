# TODO: #107 Update and add tests

<#
	.SYNOPSIS
		Waits for a process to finish.

	.PARAMETER ProcessName
		The name of the process to wait for.

	.PARAMETER MaxWaitSec
		The maximum time to wait in seconds.

	.PARAMETER IntervalSec
		The interval to check in seconds.

	.EXAMPLE
		PS C:\> Sys_WaitForProcess -ProcessName "notepad.exe" -MaxWaitSec 10 -IntervalSec 1

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462456125/cs.Sys+WaitForProcess
#>
function Sys_KillProcess {
	param (
		[Parameter(Mandatory = $true)]
		[string]$ProcessName,
		[Parameter(Mandatory = $true)]
		[int]$MaxWaitSec,
		[Parameter(Mandatory = $true)]
		[int]$IntervalSec
	)

	$Global:cs.Sys_WaitForProcess($ProcessName, $MaxWaitSec, $IntervalSec)
}
