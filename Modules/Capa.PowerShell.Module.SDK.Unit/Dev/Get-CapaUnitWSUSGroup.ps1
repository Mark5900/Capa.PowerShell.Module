<#
	.SYNOPSIS
		Gets WSUS group relation data for a unit.

	.DESCRIPTION
		Gets the WSUS group relation for the specified unit by calling
		the CapaSDK method GetUnitWSUSGroup.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to query.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.EXAMPLE
		PS C:\> Get-CapaUnitWSUSGroup -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer

		Returns WSUS group relation data for unit PC-01.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247564/Get+unit+WSUS+Group
#>
function Get-CapaUnitWSUSGroup {
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

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'GetUnitWSUSGroup')) {
		throw 'CapaSDK does not contain method GetUnitWSUSGroup.'
	}

	$value = $CapaSDK.GetUnitWSUSGroup($UnitName, $UnitType)
	return $value
}
