# TODO: Update and add tests

<#
	.SYNOPSIS
		Unlink profile from a device.

	.DESCRIPTION
		This will unlink a profile from a device and not remove the profile from the physical device.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER UnitName
		The unit name of the unit.

	.PARAMETER ProfileName
		The name of the MDM profile.

	.PARAMETER ChangelogComment
		A comment that will be added to the changelog.

	.PARAMETER Uuid
		The UUID of the unit.

	.EXAMPLE
		PS C:\> Unlink-CapaUnitFromProfile -CapaSDK $CapaSDK -UnitName 'Testdev01' -ProfileName 'Wi-Fi settings'

	.EXAMPLE
		PS C:\> Unlink-CapaUnitFromProfile -CapaSDK $CapaSDK -Uuid '4eea2959-fb4c-4afe-b61f-810cb3019cd6' -ProfileName 'Wi-Fi settings'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246474/Unlink+profile+from+device
#>
function Unlink-CapaUnitFromProfile {
	[CmdletBinding(DefaultParameterSetName = 'Uuid')]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(ParameterSetName = 'NameType',
			Mandatory = $true)]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[String]$ProfileName,
		[Parameter(Mandatory = $true)]
		[String]$ChangelogComment,
		[Parameter(ParameterSetName = 'Uuid',
			Mandatory = $true)]
		[String]$Uuid
	)

	switch ($PsCmdlet.ParameterSetName) {
		'NameType' {
			$value = $CapaSDK.UnlinkUnitFromProfile($UnitName, $ProfileName, $ChangelogComment)
			break
		}
		'Uuid' {
			$value = $CapaSDK.UnlinkUnitFromProfile($Uuid, $ProfileName, $ChangelogComment)
			break
		}
	}
	return $value
}
