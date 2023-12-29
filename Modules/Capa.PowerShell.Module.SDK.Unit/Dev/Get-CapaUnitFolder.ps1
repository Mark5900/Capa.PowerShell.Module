# TODO: #210 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247632/GetUnitFolder

	.DESCRIPTION
		A detailed description of the Get-CapaUnitFolder function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.EXAMPLE
				PS C:\> Get-CapaUnitFolder -CapaSDK $value1 -UnitName 'Value2' -UnitType Computer

	.NOTES
		Additional information about the function.
#>
function Get-CapaUnitFolder {
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

	$bool = $CapaSDK.GetUnitFolder($UnitName, $UnitType)

	Return $bool
}
