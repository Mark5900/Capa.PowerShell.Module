<#
	.SYNOPSIS
		Checks whether a unit exists on a management point.

	.DESCRIPTION
		Checks whether the specified unit exists on the specified management point
		by calling the CapaSDK method ExistUnitOnManagementPoint.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to check.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.PARAMETER CMPID
		Management point ID to check against.

	.EXAMPLE
		PS C:\> Exist-CapaUnitOnManagementPoint -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer -CMPID 2

		Returns whether PC-01 exists on management point 2.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247410/Exist+Unit+On+Management+Point
#>
function Exist-CapaUnitOnManagementPoint {
	[CmdletBinding()]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType,
		[Parameter(Mandatory = $true)]
		[ValidateRange(1, 2147483647)]
		[int]$CMPID
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'ExistUnitOnManagementPoint')) {
		throw 'CapaSDK does not contain method ExistUnitOnManagementPoint.'
	}

	$value = $CapaSDK.ExistUnitOnManagementPoint($UnitName, $UnitType, $CMPID)
	return $value
}
