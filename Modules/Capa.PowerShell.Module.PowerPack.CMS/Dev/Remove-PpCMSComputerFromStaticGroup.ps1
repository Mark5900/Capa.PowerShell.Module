# TODO: #311 Update Get-Help for Remove-PpCMSComputerFromStaticGroup. Missing documentation for BU support.
<#
	.SYNOPSIS
		Removes the specified unit from the specified static group.

	.DESCRIPTION
		Removes the specified unit from the specified static group.

	.PARAMETER Group
		The name of the static group to remove the unit from.

	.EXAMPLE
		$bStatus = Remove-PpCMSComputerFromStaticGroup -Group "CapaInstaller"
		if ($bStatus) {
			Write-Host "Computer removed from group."
		} else {
			Write-Host "Failed to remove computer from group."
		}
#>
function Remove-PpCMSComputerFromStaticGroup {
	param (
		[Parameter(Mandatory = $true)]
		[string]$Group
	)
	return CMS_RemoveComputerFromStaticGroup -group $Group
}