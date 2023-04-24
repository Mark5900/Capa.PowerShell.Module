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
