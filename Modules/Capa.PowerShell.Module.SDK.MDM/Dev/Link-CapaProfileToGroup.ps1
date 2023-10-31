# TODO: Update and add tests

<#
	.SYNOPSIS
		Link an existing profile to a group.

	.DESCRIPTION
		LINK an existing profile to a group.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER ProfileId
		The ID of the profile.

	.PARAMETER GroupName
		The name of the Group.

	.PARAMETER GroupType
		The type of the Group.

	.PARAMETER BusinessUnitName
		The name of the Business Unit where the group is located. If en empty string is specified, the group will be found in Global.

	.PARAMETER ChangelogComment
		A comment that will be added to the changelog entry on the proifile and the group.

	.EXAMPLE
		PS C:\> Link-CapaProfileToGroup -CapaSDK $CapaSDK -ProfileId 1 -GroupName 'Test Group' -GroupType 'Static'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246638/Link+profile+to+group
#>
function Link-CapaProfileToGroup {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$ProfileId,
		[Parameter(Mandatory = $true)]
		[string]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('AD', 'Department', 'Dynamic', 'Static')]
		[string]$GroupType,
		[string]$BusinessUnitName = '',
		[string]$ChangelogComment = ''
	)

	$value = $CapaSDK.AddProfileToGroup($ProfileId, $GroupName, $GroupType, $BusinessUnitName, $ChangelogComment)
	return $value
}
