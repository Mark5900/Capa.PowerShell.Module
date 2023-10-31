# TODO: Update and add tests

<#
	.SYNOPSIS
		Add a new Enforce Passcode payload or edit an existing one.

	.DESCRIPTION
		Add a new Enforce Passcode payload or edit an existing payload in the specified profile.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER ProfileId
		The ID of the profile to add the payload to.

	.PARAMETER Passcode
		The passcode to enforce.

	.PARAMETER ChangelogComment
		The comment you wish to be added to the changelog.

	.EXAMPLE
		PS C:\> Add-CapaEnforcePasscodeAndroid -CapaSDK $CapaSDK -ProfileId 1 -Passcode '12345678' -ChangelogComment 'Adding Enforce Passcode payload to profile'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246520/Add+edit+Enforce+Passcode+Android
#>
function Add-CapaEnforcePasscodeAndroid {
	[CmdletBinding()]
	[Alias('Edit-CapaEnforcePasscodeAndroid')]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$ProfileId,
		[Parameter(Mandatory = $true)]
		[string]$Passcode,
		$ChangelogComment = ''
	)

	$value = $CapaSDK.AddEditEnforcePasscodeAndroid($ProfileId, $Passcode, $ChangelogComment)
	return $value
}
