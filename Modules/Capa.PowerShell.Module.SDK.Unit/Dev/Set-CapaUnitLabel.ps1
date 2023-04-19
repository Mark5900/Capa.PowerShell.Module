<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247732/Set+unit+label
	
	.DESCRIPTION
		A detailed description of the Set-CapaUnitLabel function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER UnitName
		A description of the UnitName parameter.
	
	.PARAMETER UnitType
		A description of the UnitType parameter.
	
	.PARAMETER Label
		A description of the Label parameter.
	
	.EXAMPLE
		PS C:\> Set-CapaUnitLabel -CapaSDK $value1 -UnitName 'Value2' -UnitType 'Value3' -Label 'Value4'
	
	.NOTES
		Additional information about the function.
#>
function Set-CapaUnitLabel
{
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
		[string]$Label
	)
	
	$value = $CapaSDK.SetUnitLabel($UnitName, $UnitType, $Label)
	
	return $value
}
