# TODO: #317 Update Get-Help for Add-PpCMSComputerToDepartmentGroup, missing BU support description
<#
	.SYNOPSIS
		Adds a specified computer unit to a department group.

	.DESCRIPTION
		Adds a specified computer unit to a department group.

	.PARAMETER Group
		The name of the department group to which the computer unit should be added.

	.EXAMPLE
		$bStatus = Add-PpCMSComputerToDepartmentGroup -Group "MyDepartmentGroup"
		if ($bStatus) {
			Job_WriteLog -Text "Computer unit added to department group."
		} else {
			Job_WriteLog -Text "Failed to add computer unit to department group."
		}

	.NOTES
		https://capasystems.atlassian.net/wiki/spaces/CI66DOC/pages/19610726181/CMS+AddComputerToDepartmentGroup
#>
function Add-PpCMSComputerToDepartmentGroup {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$Group
	)
	return CMS_AddComputerToDepartmentGroup -group $Group
}