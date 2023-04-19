<#
	.SYNOPSIS
		This function will remove a profile from a device.
	
	.DESCRIPTION
		This function will remove a profile from a device, subsequently when the device reports successful removal of the profile, the relation is then removed from the database
	
	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER UnitName
		The unit name of the unit.
	
	.PARAMETER UUID
		The UUID of the unit.
	
	.PARAMETER ProfileName
		The name of the MDM profile.
	
	.PARAMETER ChangelogComment
		The comment that will be added to the changelog.
	
	.EXAMPLE
		PS C:\> Remove-CapaProfileFromDevice -CapaSDK $CapaSDK -UnitName 'Testdev01' -ProfileName 'Wi-Fi settings'

	.EXAMPLE
		PS C:\> Remove-CapaProfileFromDevice -CapaSDK $CapaSDK -Uuid '4eea2959-fb4c-4afe-b61f-810cb3019cd6' -ProfileName 'Wi-Fi settings'

	.EXAMPLE
		PS C:\> Remove-CapaProfileFromDevice -CapaSDK $CapaSDK -UnitName 'Testdev01' -ProfileName 'Wi-Fi settings' -ChangelogComment 'Removing profile from device'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246487/Remove+profile+from+device
#>
function Remove-CapaProfileFromDevice {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(ParameterSetName = 'NameType',
			Mandatory = $true)]
		[String]$UnitName,
		[Parameter(ParameterSetName = 'Uuid',
			Mandatory = $true)]
		[String]$UUID,
		[Parameter(Mandatory = $true)]
		[String]$ProfileName,
		[Parameter(Mandatory = $true)]
		[String]$ChangelogComment
	)
	
	switch ($PsCmdlet.ParameterSetName) {
		'NameType' {
			$value = $CapaSDK.RemoveUnitFromProfile($UnitName, $ProfileName, $ChangelogComment)
			break
		}
		'Uuid' {
			$value = $CapaSDK.RemoveUnitFromProfile($UUID, $ProfileName, $ChangelogComment)
			break
		}
	}
	return $value
}
