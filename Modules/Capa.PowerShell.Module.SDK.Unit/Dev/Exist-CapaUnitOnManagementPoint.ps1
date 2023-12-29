# TODO: #208 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247410/Exist+Unit+On+Management+Point

	.DESCRIPTION
		A detailed description of the Exist-CapaUnitOnManagementPoint function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName  parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.PARAMETER CMPID
		A description of the CMPID  parameter.

	.EXAMPLE
		PS C:\> Exist-CapaUnitOnManagementPoint -CapaSDK $value1 -UnitName  $value2 -UnitType Computer -CMPID  $value4

	.NOTES
		Additional information about the function.
#>
function Exist-CapaUnitOnManagementPoint {
	[CmdletBinding(DefaultParameterSetName = 'NameType')]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		$UnitType,
		[Parameter(Mandatory = $true)]
		$CMPID
	)

	$value = $CapaSDK.ExistUnitOnManagementPoint($UnitName, $UnitType, $CMPID)
	return $value
}
