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

	.NOTES
		https://capasystems.atlassian.net/wiki/spaces/CI66DOC/pages/19610726236/CMS+AddComputerToStaticGroup
#>
function Add-PpCMSComputerToStaticGroup {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$Group
	)
	return CMS_AddComputerToStaticGroup -group $Group
}