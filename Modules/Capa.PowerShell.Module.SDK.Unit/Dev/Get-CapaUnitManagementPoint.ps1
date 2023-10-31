# TODO: Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247520/Get+Unit+Management+Point

	.DESCRIPTION
		A detailed description of the Get-CapaUnitManagementPoint function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName  parameter.

	.PARAMETER UnitType
		A description of the UnitType  parameter.

	.EXAMPLE
		PS C:\> Get-CapaUnitManagementPoint

	.NOTES
		Additional information about the function.
#>
function Get-CapaUnitManagementPoint {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType
	)

	$value = $CapaSDK.GetUnitManagementPoint($UnitName, $UnitType)
	return $value
}
