function Reset-PpCMSCustomInventory {
	[CmdletBinding()]
	param (
		[string]$Category
	)
	return CMS_ClearCustomInventory -category $Category
}

