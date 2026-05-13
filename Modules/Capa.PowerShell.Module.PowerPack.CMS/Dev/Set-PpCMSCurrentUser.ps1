function Set-PpCMSCurrentUser {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$Username
	)
	return CMS_SetCurrentUser -username $Username
}

