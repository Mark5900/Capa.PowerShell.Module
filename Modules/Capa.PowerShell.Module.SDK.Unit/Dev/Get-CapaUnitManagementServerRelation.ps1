<#
	.SYNOPSIS
		Gets management server relation for a unit.

	.DESCRIPTION
		Gets management server relation data for the specified unit by calling
		the CapaSDK method GetUnitManagementServerRelation.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to query relation for.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.EXAMPLE
		PS C:\> Get-CapaUnitManagementServerRelation -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer

		Returns management server relation for PC-01.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247528/Get+unit+management+server+relation
#>
function Get-CapaUnitManagementServerRelation {
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

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'GetUnitManagementServerRelation')) {
		throw 'CapaSDK does not contain method GetUnitManagementServerRelation.'
	}

	$value = $CapaSDK.GetUnitManagementServerRelation($UnitName, $UnitType)
	return $value
}
