# TODO: #389 Update Get-Help for UsrMgr_DeleteLocalUserAccount

<#
	.SYNOPSIS
		Delete a local user account.

	.PARAMETER UserName
		The name of the user to delete.

	.EXAMPLE
		PS C:\> UsrMgr_DeleteLocalUserAccount -UserName "JohnDoe"

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462456261/cs.UsrMgr+DeleteLocalUserAccount
#>
function UsrMgr_DeleteLocalUserAccount {
	param (
		[Parameter(Mandatory = $true)]
		[string]$UserName
	)

	$Global:cs.UsrMgr_DeleteLocalUserAccount($UserName)
}