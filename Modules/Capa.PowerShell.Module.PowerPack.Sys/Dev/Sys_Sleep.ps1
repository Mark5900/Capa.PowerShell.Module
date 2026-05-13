
<#
	.SYNOPSIS
		Sleeps for a specified number of seconds.

	.DESCRIPTION
		Sleeps for a specified number of seconds.

	.PARAMETER Seconds
		The number of seconds to sleep, shall be bigger than 0 and less than 14400.
#>
function Sys_Sleep {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[int]$Seconds
	)

	$Global:cs.Sys_Sleep($Seconds)
}
