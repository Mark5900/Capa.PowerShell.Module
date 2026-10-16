<#
	.SYNOPSIS
		Check if a local user account exists.

	.DESCRIPTION
		This function checks if a local user account exists on the specified domain or local machine.

	.PARAMETER UserName
		The name of the user to check for.

	.EXAMPLE
		PS C:\> UsrMgr_ExistLocalUserAccount -UserName "JohnDoe"

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462456227/cs.UsrMgr+ExistLocalUserAccount
#>
function UsrMgr_ExistLocalUserAccount {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$UserName
	)

	$Value = $Global:cs.UsrMgr_ExistLocalUserAccount($UserName)

	return $Value
}
