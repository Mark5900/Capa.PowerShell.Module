<#
	.SYNOPSIS
		Gets the free disk space of a drive.

	.PARAMETER Drive
		The drive to get the free disk space from, default is 'C:'.

	.EXAMPLE
		PS C:\> Sys_GetFreeDiskSpace

	.EXAMPLE
		PS C:\> Sys_GetFreeDiskSpace -Drive "D:"

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462456057/cs.Sys+GetFreeDiskSpace
#>
function Sys_GetFreeDiskSpace {
	param (
		[string]$Drive = 'C:'
	)

	$Value = $Global:cs.Sys_GetFreeDiskSpace($Drive)

	return $Value
}

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

<#
	.SYNOPSIS
		Kills a process.

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

<#
	.SYNOPSIS
		Checks if a minimum required disk space is available.

	.PARAMETER Drive
		The drive to check, default is 'C:'.

	.PARAMETER MinimumRequiredDiskspaceInMb
		The minimum required disk space in bytes.

	.EXAMPLE
		PS C:\> Sys_IsMinimumRequiredDiskspaceInMbAvailable -MinimumRequiredDiskspaceInMb 1000

	.EXAMPLE
		PS C:\> Sys_IsMinimumRequiredDiskspaceInMbAvailable -Drive "D:" -MinimumRequiredDiskspaceInMb 1000

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462456108/cs.Sys+IsMinimumRequiredDiskspaceAvailable
#>
function Sys_IsMinimumRequiredDiskspaceAvailable {
	param (
		[string]$Drive = 'C:',
		[Parameter(Mandatory = $true)]
		[int]$MinimumRequiredDiskspaceInMb
	)

	$Value = $Global:cs.Sys_IsMinimumRequiredDiskspaceAvailable($Drive, $MinimumRequiredDiskspaceInMb)

	return $Value
}

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
function Sys_WaitForProcess {
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