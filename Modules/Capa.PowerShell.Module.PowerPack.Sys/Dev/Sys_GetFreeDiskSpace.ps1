# TODO: #104 Update and add tests

<#
	.SYNOPSIS
		Gets the free disk space of a drive.

	.DESCRIPTION
		This function retrieves the free disk space of the specified drive.

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
