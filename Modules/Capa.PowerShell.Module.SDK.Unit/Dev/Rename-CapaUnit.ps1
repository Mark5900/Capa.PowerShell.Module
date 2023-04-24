<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247688/Rename+unit
	
	.DESCRIPTION
		A detailed description of the Rename-CapaUnit function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER CurrentUnitName
		A description of the CurrentUnitName  parameter.
	
	.PARAMETER UnitType
		A description of the UnitType  parameter.
	
	.PARAMETER NewUnitName
		A description of the NewUnitName  parameter.
	
	.EXAMPLE
		PS C:\> Rename-CapaUnit -CapaSDK $value1 -CurrentUnitName  $value2 -UnitType  $value3 -NewUnitName  $value4
	
	.NOTES
		Additional information about the function.
#>
function Rename-CapaUnit
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		$CurrentUnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		$UnitType,
		[Parameter(Mandatory = $true)]
		$NewUnitName
	)
	
	$value = $CapaSDK.RenameUnit($CurrentUnitName, $UnitType, $NewUnitName)
	return $value
}
