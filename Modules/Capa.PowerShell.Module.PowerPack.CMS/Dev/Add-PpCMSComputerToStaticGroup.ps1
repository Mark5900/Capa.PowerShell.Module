# TODO: #309 Update Get-Help for Add-PpCMSComputerToStaticGroup. Missing documentation for BU support.
<#
	.SYNOPSIS
		Adds the specified unit to the specified static group.

	.DESCRIPTION
		Adds the specified unit to the specified static group.

	.PARAMETER Group
		The name of the static group to add the unit to.

	.EXAMPLE
		$bStatus = Add-PpCMSComputerToStaticGroup -Group "CapaInstaller"
		if ($bStatus) {
			Job_WriteLog -Text "Computer added to group."
		} else {
			Job_WriteLog -Text "Failed to add computer to group."
		}
#>
function Add-PpCMSComputerToStaticGroup {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$Group
	)
	return CMS_AddComputerToStaticGroup -group $Group
}