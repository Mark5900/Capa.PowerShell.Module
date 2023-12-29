# TODO: #221 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247564/Get+unit+WSUS+Group

	.DESCRIPTION
		A detailed description of the Get-CapaUnitWSUSGroup function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.EXAMPLE
				PS C:\> Get-CapaUnitWSUSGroup -CapaSDK $value1 -UnitName 'Value2' -UnitType Computer

	.NOTES
		Additional information about the function.
#>
function Get-CapaUnitWSUSGroup {
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

	$value = $CapaSDK.GetUnitWSUSGroup($UnitName, $UnitType)
	return $value
}
