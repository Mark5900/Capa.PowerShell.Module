# TODO: #386 Update Get-Help for UsrMgr_AddUserToLocalGroup

<#
	.SYNOPSIS
		Adds a user to a local group.

	.DESCRIPTION
		This function adds a user to a local group on the system.

	.PARAMETER UserName
		The name of the user to add to the group.

	.PARAMETER GroupName
		The name of the group to add the user to.

	.PARAMETER SID
		The SID of the group to add the user to.

	.EXAMPLE
		PS C:\> UsrMgr_AddUserToLocalGroup -UserName "JohnDoe" -GroupName "Administrators"

	.EXAMPLE
		PS C:\> UsrMgr_AddUserToLocalGroup -UserName "JohnDoe" -GroupName "S-1-5-32-544"

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462456159/cs.UsrMgr+AddUserToLocalGroup
#>
function UsrMgr_AddUserToLocalGroup {
	param (
		[Parameter(Mandatory = $true)]
		[string]$UserName,
		[Parameter(Mandatory = $true)]
		[Alias('SID')]
		[string]$GroupName
	)

	$Global:cs.UsrMgr_AddUserToLocalGroup($UserName, $GroupName)
}