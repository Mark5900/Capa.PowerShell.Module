# TODO: Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247648/Remove+unit+from+business+unit

	.DESCRIPTION
		A detailed description of the Remove-CapaUnitFromBusinessUnit function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.EXAMPLE
		PS C:\> Remove-CapaUnitFromBusinessUnit -CapaSDK $value1 -UnitName 'Value2' -UnitType 'Value3'

	.NOTES
		Additional information about the function.
#>
function Remove-CapaUnitFromBusinessUnit {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType
	)

	$value = $CapaSDK.RemoveUnitFromBusinessUnit($UnitName, $UnitType)

	return $value
}
