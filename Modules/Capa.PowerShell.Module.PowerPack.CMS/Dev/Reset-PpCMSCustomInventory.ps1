# TODO: #299 Add Get-Help for Reset-PpCMSCustomInventory
function Reset-PpCMSCustomInventory {
	[CmdletBinding()]
	param (
		[string]$Category
	)
	return CMS_ClearCustomInventory -category $Category
}