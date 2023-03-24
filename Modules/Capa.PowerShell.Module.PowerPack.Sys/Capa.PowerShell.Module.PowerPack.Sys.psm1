function Sys_GetFreeDiskSpace {
	param (
		[string]$Drive = 'C:'
	)

	$Value = $Global:cs.Sys_GetFreeDiskSpace($Drive)

	return $Value
}

function Sys_ExistProcess {
	param (
		[Parameter(Mandatory = $true)]
		[string]$ProcessName
	)

	$Value = $Global:cs.Sys_ExistProcess($ProcessName)

	return $Value
}

function Sys_KillProcess {
	param (
		[Parameter(Mandatory = $true)]
		[string]$ProcessName
	)

	$Global:cs.Sys_KillProcess($ProcessName)
}

function Sys_IsMinimumRequiredDiskspaceAvailable {
	param (
		[string]$Drive = 'C:',
		[Parameter(Mandatory = $true)]
		[int]$MinimumRequiredDiskspace
	)

	$Value = $Global:cs.Sys_IsMinimumRequiredDiskspaceAvailable($Drive, $MinimumRequiredDiskspace)

	return $Value
}

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