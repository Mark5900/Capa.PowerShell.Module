# TODO: #303 Add Get-Help for Remove-PpCMSHardwareInventory
<#
	.SYNOPSIS
		Removes a HardwareInventory row from the database that is persistent.

	.DESCRIPTION
		Removes a HardwareInventory row from the database that is persistent.

	.PARAMETER Category
		Category name

	.PARAMETER Entry
		Variable name

	.EXAMPLE
		$bStatus = Remove-PpCMSHardwareInventory -Category "MyCategory" -Entry "MyEntry"
		if ($bStatus) {
			Job_WriteLog -Text "Hardware inventory removed successfully."
		} else {
			Job_WriteLog -Text "Failed to remove hardware inventory."
	}
#>
function Remove-PpCMSHardwareInventory {
	param (
		[Parameter(Mandatory = $true)]
		[string]$Category,
		[Parameter(Mandatory = $true)]
		[string]$Entry
	)
	return CMS_RemoveHardwareInventory -category $Category -entry $Entry
}