# TODO: #341 Update Get-Help for Add-PpCMSUnitToBusinessUnit
<#
	.SYNOPSIS
		Adds the unit to the specified business unit

	.DESCRIPTION
		Adds the unit on which the script is executed to the specified Business Unit. UserJobs add user and ComputerJobs add the computer.

	.PARAMETER BusinessUnitName
		The name of the business unit to add the unit to

	.EXAMPLE
		$bStatus = Add-PpCMSUnitToBusinessUnit -BusinessUnitName "MyBusinessUnit"
		if ($bStatus) {
			Job_WriteLog -Text "Unit added to business unit."
		} else {
			Job_WriteLog -Text "Failed to add unit to business unit."
		}
#>
function Add-PpCMSUnitToBusinessUnit {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$BusinessUnitName
	)
	return CMS_AddUnitToBusinessUnit -businessunitname $BusinessUnitName
}