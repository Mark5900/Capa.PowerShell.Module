# TODO: Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247402/Exist+unit+location

	.DESCRIPTION
		A detailed description of the Exist-CapaUnitLocation function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.PARAMETER Location
		A description of the Location parameter.

	.EXAMPLE
				PS C:\> Exist-CapaUnitLocation -CapaSDK $value1 -UnitName 'Value2' -UnitType Computer -Location 'Value4'

	.NOTES
		Additional information about the function.
#>
function Exist-CapaUnitLocation {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType,
		[Parameter(Mandatory = $true)]
		[String]$Location
	)

	$value = $CapaSDK.ExistUnitLocation($UnitName, $UnitType, $Location)
	return $value
}
