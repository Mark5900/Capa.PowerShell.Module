<#
	.SYNOPSIS
		Link profile to a device.
	
	.DESCRIPTION
		The Add-CapaUnitToProfile function links a profile to a device.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER UnitName
		The unit name of the unit.
	
	.PARAMETER Uuid
		The UUID of the unit.
	
	.PARAMETER ProfileName
		The name of the MDM profile.
	
	.PARAMETER ChangelogComment
		A comment that will be added to the changelog.
	
	.EXAMPLE
		PS C:\> Add-CapaUnitToProfile -CapaSDK $CapaSDK -UnitName 'Testdev01' -ProfileName 'Wi-Fi settings'

	.EXAMPLE
		PS C:\> Add-CapaUnitToProfile -CapaSDK $CapaSDK -Uuid '4eea2959-fb4c-4afe-b61f-810cb3019cd6' -ProfileName 'Wi-Fi settings'

	.EXAMPLE
		PS C:\> Add-CapaUnitToProfile -CapaSDK $CapaSDK -UnitName 'Testdev01' -ProfileName 'Wi-Fi settings' -ChangelogComment 'Linking profile to device'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246463/Link+profile+to+device
#>
function Add-CapaUnitToProfile {
	[CmdletBinding()]
	[Alias('Link-CapaUnitToProfile')]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(ParameterSetName = 'NameType',
			Mandatory = $true)]
		[String]$UnitName,
		[Parameter(ParameterSetName = 'Uuid',
			Mandatory = $true)]
		[String]$Uuid,
		[Parameter(Mandatory = $true)]
		[String]$ProfileName,
		[Parameter(Mandatory = $false)]
		[String]$ChangelogComment
	)
	
	switch ($PsCmdlet.ParameterSetName) {
		'Uuid' {
			$value = $CapaSDK.AddUnitToProfile($UnitName, $ProfileName, $ChangelogComment)
			break
		}
		'NameType' {
			$value = $CapaSDK.AddUnitToProfile($Uuid, $ProfileName, $ChangelogComment)
			break
		}
	}
	
	return $value
}
