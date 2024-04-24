# TODO: #319 Update Get-Help for Remove-PpCMSComputerFromDepartmentGroup, missing BU support description
<#
	.SYNOPSIS
		Removes a specified computer unit from a department group.

	.DESCRIPTION
		Removes a specified computer unit from a department group.

	.PARAMETER Group
		The name of the department group from which the computer unit should be removed.

	.EXAMPLE
		$bStatus = Remove-PpCMSComputerFromDepartmentGroup -Group "MyDepartmentGroup"
		if ($bStatus) {
			Job_WriteLog -Text "Computer unit removed from department group."
		} else {
			Job_WriteLog -Text "Failed to remove computer unit from department group."
		}
#>
function Remove-PpCMSComputerFromDepartmentGroup {
	param (
		[Parameter(Mandatory = $true)]
		[string]$Group
	)
	return CMS_RemoveComputerFromDepartmentGroup -group $Group
}