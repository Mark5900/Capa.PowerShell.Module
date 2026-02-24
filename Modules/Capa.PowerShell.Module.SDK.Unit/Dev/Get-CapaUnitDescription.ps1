<#
	.SYNOPSIS
		Gets description for a unit.

	.DESCRIPTION
		Gets the description for the specified unit by calling the CapaSDK method
		GetUnitDescription.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to query description for.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.EXAMPLE
		PS C:\> Get-CapaUnitDescription -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer

		Returns the description for PC-01.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247474/Get+unit+description
#>
function Get-CapaUnitDescription {
	[CmdletBinding()]
	[OutputType([object])]
	param (
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'GetUnitDescription')) {
		throw 'CapaSDK does not contain method GetUnitDescription.'
	}

	$value = $CapaSDK.GetUnitDescription($UnitName, $UnitType)
	return $value
}
