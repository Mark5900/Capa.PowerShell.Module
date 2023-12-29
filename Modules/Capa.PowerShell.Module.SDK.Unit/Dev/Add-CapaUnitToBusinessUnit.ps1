# TODO: #198 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247294/Add+unit+to+business+unit

	.DESCRIPTION
		A detailed description of the Add-CapaUnitToBusinessUnit function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.PARAMETER BusinessUnit
		A description of the BusinessUnit parameter.

	.EXAMPLE
				PS C:\> Add-CapaUnitToBusinessUnit -CapaSDK $value1 -UnitName 'Value2' -UnitType Computer -BusinessUnit 'Value4'

	.NOTES
		Additional information about the function.
#>
function Add-CapaUnitToBusinessUnit {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType,
		[Parameter(Mandatory = $true)]
		[string]$BusinessUnit
	)

	$value = $CapaSDK.AddUnitToBusinessUnit($UnitName, $UnitType, $BusinessUnit)

	return $value
}
