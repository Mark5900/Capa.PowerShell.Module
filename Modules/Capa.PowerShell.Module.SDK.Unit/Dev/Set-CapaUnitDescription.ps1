<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247724/Set+unit+description
	
	.DESCRIPTION
		A detailed description of the Set-CapaUnitDescription function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER UnitName
		A description of the UnitName  parameter.
	
	.PARAMETER UnitType
		A description of the UnitType parameter.
	
	.PARAMETER Description
		A description of the Description parameter.
	
	.EXAMPLE
				PS C:\> Set-CapaUnitDescription -CapaSDK $value1 -UnitName  'Value2' -UnitType Computer
	
	.NOTES
		Additional information about the function.
#>
function Set-CapaUnitDescription
{
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
		[String]$Description = ''
	)
	
	$value = $CapaSDK.SetUnitDescription($UnitName, $UnitType, $Description)
	return $value
}
