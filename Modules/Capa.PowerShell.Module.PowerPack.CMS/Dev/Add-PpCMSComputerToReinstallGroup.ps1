# TODO: #325 Update Get-Help for Add-PpCMSComputerToReinstallGroup, missing BU support description
<#
	.SYNOPSIS
		Add a computer to a Reinstall Group.

	.DESCRIPTION
		Add a computer to a Reinstall Group.

	.PARAMETER Group
		The name of the Reinstall Group.

	.EXAMPLE
		$bStatus = Add-PpCMSComputerToReinstallGroup -Group "MyGroup"
		if ($bStatus) {
			Job_WriteLog -Text "Computer added to Reinstall Group."
		} else {
			Job_WriteLog -Text "Failed to add computer to Reinstall Group."
		}

	.NOTES
		https://capasystems.atlassian.net/wiki/spaces/CI66DOC/pages/19610726217/CMS+AddComputerToReinstallGroup
#>
function Add-PpCMSComputerToReinstallGroup {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$Group
	)
	return CMS_AddComputerToReinstallGroup -group $Group
}