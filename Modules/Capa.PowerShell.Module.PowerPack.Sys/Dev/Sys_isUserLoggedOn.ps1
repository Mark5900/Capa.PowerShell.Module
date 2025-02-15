# TODO: #404 Create tests for Sys_isUserLoggedOn

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
	return $Global:cs.Sys_isUserLoggedOn()
}