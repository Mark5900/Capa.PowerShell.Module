# TODO: #234 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247740/Set+unit+name

	.DESCRIPTION
		A detailed description of the Set-CapaUnitName function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.PARAMETER Name
		A description of the Name parameter.

	.EXAMPLE
				PS C:\> Set-CapaUnitName -CapaSDK $value1 -UnitName 'Value2' -UnitType Computer -Name 'Value4'

	.NOTES
		Additional information about the function.
#>
function Set-CapaUnitName {
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
		[String]$Name
	)

	$value = $CapaSDK.SetUnitName($UnitName, $UnitType, $Name)
	return $value
}
