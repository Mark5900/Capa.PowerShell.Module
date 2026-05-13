<#
	.SYNOPSIS
		Checks whether a unit exists on a specific location.

	.DESCRIPTION
		Checks whether the specified unit exists on the specified location by
		calling the CapaSDK method ExistUnitLocation.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to check.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.PARAMETER Location
		Location path to validate for the unit.

	.EXAMPLE
		PS C:\> Exist-CapaUnitLocation -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer -Location 'Default\\Devices'

		Returns whether PC-01 exists on location Default\Devices.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247402/Exist+unit+location
#>
function Exist-CapaUnitLocation {
	[CmdletBinding()]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$Location
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'ExistUnitLocation')) {
		throw 'CapaSDK does not contain method ExistUnitLocation.'
	}

	$value = $CapaSDK.ExistUnitLocation($UnitName, $UnitType, $Location)
	return $value
}
