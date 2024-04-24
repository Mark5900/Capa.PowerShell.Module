# TODO: #297 Update Get-Help for Remove-PpCMSCustomInventory
<#
	.SYNOPSIS
		Removes a CustomInventory row from the database that is persistent.

	.DESCRIPTION
		Removes a persistent CustomInventory row from the database.

	.PARAMETER Category
		Category name

	.PARAMETER Entry
		Variable name

	.EXAMPLE
		$bStatus = Remove-PpCMSCustomInventory -Category "Bitlocker" -Entry "BitlockerStatus"
#>
function Remove-PpCMSCustomInventory {
	param (
		[Parameter(Mandatory = $true)]
		[string]$Category,
		[Parameter(Mandatory = $true)]
		[string]$Entry
	)

	return CMS_RemoveCustomInventory -category $Category -entry $Entry
}