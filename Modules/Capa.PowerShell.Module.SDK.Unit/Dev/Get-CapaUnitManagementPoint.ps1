<#
	.SYNOPSIS
		Gets management point for a unit.

	.DESCRIPTION
		Gets management point data for the specified unit by calling
		the CapaSDK method GetUnitManagementPoint.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to query management point for.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.EXAMPLE
		PS C:\> Get-CapaUnitManagementPoint -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer

		Returns management point information for PC-01.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247520/Get+Unit+Management+Point
#>
function Get-CapaUnitManagementPoint {
	[CmdletBinding()]
	[OutputType([object])]
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
		[String]$UnitType
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'GetUnitManagementPoint')) {
		throw 'CapaSDK does not contain method GetUnitManagementPoint.'
	}

	$value = $CapaSDK.GetUnitManagementPoint($UnitName, $UnitType)
	return $value
}
