# TODO: #136 Update and add tests

<#
	.SYNOPSIS
		Add a new key/value setting to an existing AppConfig payload in the specified profile.

	.DESCRIPTION
		Add a new Key/Value setting to an existing AppConfig payload in the specified profile.
		If a setting with the specified key and type already exists, its value will be overwritten with the new value instead of creating a new setting.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER DeviceApplicationID
		The ID of the Device Application you wish to edit.

	.PARAMETER Key
		The key of the new setting.

	.PARAMETER Value
		The value of the new setting.

	.PARAMETER KeyValueType
		The type of the new setting. Valid types are: String, Bool, Hidden, Integer

	.PARAMETER ChangelogComment
		the comment you wish to be added to the changelog.

	.EXAMPLE
		PS C:\> Add-CapaKeyValueToAppConfigAndroid -CapaSDK $CapaSDK -DeviceApplicationID 1 -Key 'AllowSync' -Value 'True' -KeyValueType 'Bool' -ChangelogComment 'Adding new key/value setting to AppConfig payload'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246531/Add+edit+Key+Value+setting+to+Android+AppConfig
#>
function Add-CapaKeyValueToAppConfigAndroid {
	[CmdletBinding()]
	[Alias('Edit-CapaKeyValueToAppConfigAndroid')]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$DeviceApplicationID,
		[Parameter(Mandatory = $true)]
		[string]$Key,
		[Parameter(Mandatory = $true)]
		[string]$Value,
		[Parameter(Mandatory = $true)]
		[ValidateSet('String', 'Bool', 'Hidden', 'Integer')]
		$KeyValueType,
		$ChangelogComment = ''
	)

	$value = $CapaSDK.AddKeyValueToAppConfigAndroid($DeviceApplicationID, $Key, $Value, $KeyValueType, $ChangelogComment)
	return $value
}
