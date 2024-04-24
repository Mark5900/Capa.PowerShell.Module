# TODO: #299 Add Get-Help for Reset-PpCMSCustomInventory
function Reset-PpCMSCustomInventory {
	param (
		[string]$Category
	)
	return CMS_ClearCustomInventory -category $Category
}