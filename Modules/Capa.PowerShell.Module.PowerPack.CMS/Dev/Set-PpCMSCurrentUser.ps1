# TODO: #305 Add Get-Help for Add-PpCMSCustomInventory
function Set-PpCMSCurrentUser {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$Username
	)
	return CMS_SetCurrentUser -username $Username
}