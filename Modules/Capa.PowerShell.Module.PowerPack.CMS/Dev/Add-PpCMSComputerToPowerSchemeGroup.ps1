# TODO: #321 Update Get-Help for Add-PpCMSComputerToPowerSchemeGroup
<#
	.SYNOPSIS
		Adds a specified computer unit to a power scheme group.

	.DESCRIPTION
		Adds a specified computer unit to a power scheme group.

	.PARAMETER Group
		The name of the power scheme group to which the computer unit should be added.

	.EXAMPLE
		$bStatus = Add-PpCMSComputerToPowerSchemeGroup -Group "MyPowerSchemeGroup"
		if ($bStatus) {
			Job_WriteLog -Text "Computer unit added to power scheme group."
		} else {
			Job_WriteLog -Text "Failed to add computer unit to power scheme group."
		}
#>
function Add-PpCMSComputerToPowerSchemeGroup {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$Group
	)
	return CMS_AddComputerToPowerSchemeGroup -group $Group
}