# TODO: #392 Update Get-Help for USRMgr_RemoveUserFromLocalGroup

<#
	.SYNOPSIS
		Remove a user from a local group.

	.DESCRIPTION
		Removes a user from a local group on the specified domain or local machine.

	.PARAMETER UserName
		The name of the user to remove from the group.

	.PARAMETER GroupName
		The name of the group to remove the user from.

	.EXAMPLE
		PS C:\> UsrMgr_RemoveUserFromLocalGroup -UserName "JohnDoe" -GroupName "Administrators"

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462456244/cs.UsrMgr+RemoveUserFromLocalGroup
#>
function UsrMgr_RemoveUserFromLocalGroup {
	param (
		$Domain = '',
		[Parameter(Mandatory = $true)]
		[string]$UserName,
		[Parameter(Mandatory = $true)]
		[string]$GroupName
	)

	$Global:cs.UsrMgr_RemoveUserFromLocalGroup($Domain, $UserName, $GroupName)
}