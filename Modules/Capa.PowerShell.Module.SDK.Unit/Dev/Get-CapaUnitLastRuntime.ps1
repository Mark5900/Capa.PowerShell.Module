<#
	.SYNOPSIS
		Gets last runtime for a unit.

	.DESCRIPTION
		Gets the last runtime value for a unit by calling the CapaSDK method
		GetUnitLastRuntime.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to query.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.EXAMPLE
		PS C:\> Get-CapaUnitLastRuntime -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer

		Returns last runtime information for PC-01.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247492/Get+unit+last+runtime
#>
function Get-CapaUnitLastRuntime {
	[CmdletBinding()]
	[OutputType([object])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User', '1', '2')]
		[string]$UnitType
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'GetUnitLastRuntime')) {
		throw 'CapaSDK does not contain method GetUnitLastRuntime.'
	}

	if ($UnitType -eq 'Computer') {
		$UnitType = '1'
	} elseif ($UnitType -eq 'User') {
		$UnitType = '2'
	}

	$aUnits = $CapaSDK.GetUnitLastRuntime($UnitName, $UnitType)

	return $aUnits
}
