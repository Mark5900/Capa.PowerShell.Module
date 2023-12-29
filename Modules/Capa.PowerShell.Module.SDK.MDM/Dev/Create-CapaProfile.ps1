# TODO: #142 Update and add tests

<#
	.SYNOPSIS
		Create a new profile in the Default Management Point.

	.DESCRIPTION
		Create a new profile in the Default Management Point. If BusinessUnitName is specified, the profile will be linked to the specified business unit.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER Name
		The name of the new profile.

	.PARAMETER Description
		The description of the new profile.

	.PARAMETER Priority
		The priority of the new profile.

	.PARAMETER BusinessUnitName
		The name of the business unit you wish to assign the profile to.

	.PARAMETER ChangelogComment
		The comment you wish to be added to the changelog.

	.EXAMPLE
		PS C:\> Create-CapaProfile -CapaSDK $CapaSDK -Name 'My Profile' -Description 'My Profile Description' -Priority 1 -ChangelogComment 'Creating new profile'

	.EXAMPLE
		PS C:\> Create-CapaProfile -CapaSDK $CapaSDK -Name 'My Profile' -Description 'My Profile Description' -Priority 1 -ChangelogComment 'Creating new profile' -BusinessUnitName 'My Business Unit'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246572/Create+Profile
		And https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246582/Create+Profile+in+Business+Unit
#>
function Create-CapaProfile {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$Name,
		[Parameter(Mandatory = $true)]
		[string]$Description,
		[Parameter(Mandatory = $true)]
		[int]$Priority,
		[string]$ChangelogComment = '',
		[string]$BusinessUnitId = ''
	)

	if ($BusinessUnitId -eq '') {
		$value = $CapaSDK.CreateProfile($Name, $Description, $Priority, $ChangelogComment)
	} else {
		$value = $CapaSDK.CreateProfileInBusinessUnit($Name, $Description, $Priority, $ChangelogComment, $BusinessUnitId)
	}

	return $value
}
