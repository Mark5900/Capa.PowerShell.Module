# TODO: #217 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247528/Get+unit+management+server+relation

	.DESCRIPTION
		A detailed description of the Get-CapaUnitManagementServerRelation function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName  parameter.

	.PARAMETER UnitType
		A description of the UnitType  parameter.

	.EXAMPLE
				PS C:\> Get-CapaUnitManagementServerRelation -CapaSDK $value1 -UnitName  'Value2' -UnitType  'Value3'

	.NOTES
		Additional information about the function.
#>
function Get-CapaUnitManagementServerRelation {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[String]$UnitType
	)

	$value = $CapaSDK.GetUnitManagementServerRelation($UnitName, $UnitType)
	return $value
}
