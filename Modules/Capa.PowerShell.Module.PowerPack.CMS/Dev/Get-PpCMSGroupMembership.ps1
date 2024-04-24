# TODO: #359 Update Get-Help for Get-PpCMSGroupMembership
<#
	.SYNOPSIS
		Returns an array of the groups to which the client is linked.

	.DESCRIPTION
		Returns an array of the groups to which the client is linked, containing values:
		- Packagetype
		- Parentid
		- Unittype
		- Id
		- Name
		- Description
		- Type
		- Typedisplayname
		- Icon
		- Cmpid
		- Scheduleid
		- Groupdeleted
		- Businessunitid
		- Linkedprofilecount
		- Linkedapplicationcount
		- Linkedpackagecount
		- Linkedunitcount
		- Folderid
		- Guid
		- Objecttype

	.EXAMPLE
		$groups = Get-PpCMSGroupMembership
		foreach ($group in $groups) {
			Job_WriteLog -Text "Group: $($group.Name)"
		}
#>
function Get-PpCMSGroupMembership {
	[CmdletBinding()]
	param (	)
	return CMS_GetGroupMembership
}