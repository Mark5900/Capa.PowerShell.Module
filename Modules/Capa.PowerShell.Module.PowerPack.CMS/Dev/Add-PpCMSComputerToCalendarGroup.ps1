# TODO: #314 Update Get-Help for Add-PpCMSComputerToCalendarGroup. Missing documentation for BU support.
<#
	.SYNOPSIS
		Adds the specified unit to the specified calendar group.

	.DESCRIPTION
		Adds the specified unit to the specified calendar group.

	.PARAMETER Group
		The name of the calendar group to add the unit to.

	.EXAMPLE
		$bStatus = Add-PpCMSComputerToCalendarGroup -Group "CapaInstaller"
		if ($bStatus) {
			Job_WriteLog -Text "Computer added to group."
		} else {
			Job_WriteLog -Text "Failed to add computer to group."
		}
#>
function Add-PpCMSComputerToCalendarGroup {
	param (
		[Parameter(Mandatory = $true)]
		[string]$Group
	)
	return CMS_AddComputerToCalendarGroup -group $Group
}