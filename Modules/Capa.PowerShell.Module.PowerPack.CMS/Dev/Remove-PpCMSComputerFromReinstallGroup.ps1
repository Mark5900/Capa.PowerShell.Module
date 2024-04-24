# TODO: #327 Update Get-Help for Remove-PpCMSComputerFromReinstallGroup, missing BU support description
<#
	.SYNOPSIS
		Remove a computer from a Reinstall Group.

	.DESCRIPTION
		Remove a computer from a Reinstall Group.

	.PARAMETER Group
		The name of the Reinstall Group.

	.EXAMPLE
		$bStatus = Remove-PpCMSComputerFromReinstallGroup -Group "MyGroup"
		if ($bStatus) {
			Job_WriteLog -Text "Computer removed from Reinstall Group."
		} else {
			Job_WriteLog -Text "Failed to remove computer from Reinstall Group."
		}
#>
function Remove-PpCMSComputerFromReinstallGroup {
	param (
		[Parameter(Mandatory = $true)]
		[string]$Group
	)
	return CMS_RemoveComputerFromReinstallGroup -group $Group
}