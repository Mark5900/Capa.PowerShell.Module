# TODO: Update and add tests

<#
	.SYNOPSIS
		Assign a profile to a business unit.

	.DESCRIPTION
		Assign a profile to a business unit.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER ProfileId
		The ID of the profile you wish to assign to a business unit.

	.PARAMETER BusinessUnitName
		The name of the business unit you wish to assign the profile to.

	.PARAMETER ChangelogComment
		The comment you wish to be added to the changelog.

	.EXAMPLE
		PS C:\> Assign-CapaProfileToBusinessUnit -CapaSDK $CapaSDK -ProfileId 1 -BusinessUnitName 'My Business Unit' -ChangelogComment 'Assigning profile to business unit'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246552/Assign+Profile+to+Business+Unit
#>
function Assign-CapaProfileToBusinessUnit {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$ProfileId,
		[Parameter(Mandatory = $true)]
		[string]$BusinessUnitName,
		[string]$ChangelogComment = ''
	)

	$value = $CapaSDK.AssignProfileToBusinessUnit($ProfileId, $BusinessUnitName, $ChangelogComment)
	return $value
}
