<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247474/Get+unit+description
	
	.DESCRIPTION
		A detailed description of the Get-CapaUnitDescription function.
	
	.EXAMPLE
				PS C:\> Get-CapaUnitDescription
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaUnitDescription
{
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		$UnitType
	)
	
	$value = $CapaSDK.GetUnitDescription($UnitName, $UnitType)
	return $value
}
