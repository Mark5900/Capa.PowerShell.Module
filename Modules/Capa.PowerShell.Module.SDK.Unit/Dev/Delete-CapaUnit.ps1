<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247372/Delete+unit
	
	.DESCRIPTION
		A detailed description of the Delete-CapaUnit function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER UnitName
		A description of the UnitName  parameter.
	
	.PARAMETER UnitType
		A description of the UnitType parameter.
	
	.EXAMPLE
				PS C:\> Delete-CapaUnit -CapaSDK $value1 -UnitName  'Value2' -UnitType Computer
	
	.NOTES
		Additional information about the function.
#>
function Delete-CapaUnit
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
		[String]$UnitType
	)
	
	$value = $CapaSDK.DeleteUnit($UnitName, $UnitType)
	return $value
}
