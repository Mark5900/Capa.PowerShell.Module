# TODO: #305 Add Get-Help for Add-PpCMSCustomInventory
function Set-PpCMSCurrentUser {
	param (
		[Parameter(Mandatory = $true)]
		[string]$Username
	)
	return CMS_SetCurrentUser -username $Username
}