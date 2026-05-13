
<#
	.SYNOPSIS
		Checks if a user is logged on to the system.

	.DESCRIPTION
		This function checks if a user is logged on to the system.

	.EXAMPLE
		if (Sys_isUserLoggedOn) {
			Write-Host "User is logged on."
		} else {
			Write-Host "User is not logged on."
		}
#>
function Sys_isUserLoggedOn {
	[CmdletBinding()]
	param ()

	return $Global:cs.Sys_isUserLoggedOn()
}

