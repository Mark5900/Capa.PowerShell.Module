# TODO: #390 Update Get-Help for UsrMgr_EnumMembersOfLocalGroup

<#
	.SYNOPSIS
		Get group members of a local group.

	.PARAMETER GroupName
		The name of the group to get the members of.

	.EXAMPLE
		PS C:\> UsrMgr_EnumMembersOfLocalGroup -GroupName "Administrators"

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462456176/cs.UsrMgr+EnumMembersOfLocalGroup
#>
function UsrMgr_EnumMembersOfLocalGroup {
	param (
		[Parameter(Mandatory = $true)]
		[string]$GroupName
	)

	$Value = $Global:cs.UsrMgr_EnumMembersOfLocalGroup($GroupName)

	return $Value
}