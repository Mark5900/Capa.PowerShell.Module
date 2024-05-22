# TODO: #315 Update Get-Help for Remove-PpCMSComputerFromCalendarGroup
<#
	.SYNOPSIS
		Removes a specified computer unit from a calendar group.

	.DESCRIPTION
		Removes a specified computer unit from a calendar group.

	.PARAMETER Group
		The name of the calendar group from which the computer unit should be removed.

	.EXAMPLE
		$bStatus = Remove-PpCMSComputerFromCalendarGroup -Group "MyCalendarGroup"
		if ($bStatus) {
			Job_WriteLog -Text "Computer unit removed from calendar group."
		} else {
			Job_WriteLog -Text "Failed to remove computer unit from calendar group."
		}
#>
function Remove-PpCMSComputerFromCalendarGroup {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$Group
	)
	return CMS_RemoveComputerFromCalendarGroup -group $Group
}