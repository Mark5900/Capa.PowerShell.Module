# TODO: #323 Update Get-Help for Remove-PpCMSComputerFromPowerSchemeGroup
<#
	.SYNOPSIS
		Remove a computer from a Power Scheme Group.

	.DESCRIPTION
		Remove a computer from a Power Scheme Group.

	.PARAMETER Group
		The name of the Power Scheme Group.

	.EXAMPLE
		$bStatus = Remove-PpCMSComputerFromPowerSchemeGroup -Group "MyGroup"
		if ($bStatus) {
			Job_WriteLog -Text "Computer removed from Power Scheme Group."
		} else {
			Job_WriteLog -Text "Failed to remove computer from Power Scheme Group."
		}
#>
function Remove-PpCMSComputerFromPowerSchemeGroup {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$Group
	)
	return CMS_RemoveComputerFromPowerSchemeGroup -group $Group
}