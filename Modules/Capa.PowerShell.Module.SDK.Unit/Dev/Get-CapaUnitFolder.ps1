<#
	.SYNOPSIS
		Gets folder path for a unit.

	.DESCRIPTION
		Gets the folder location for the specified unit by calling the CapaSDK
		method GetUnitFolder.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to query folder path for.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.EXAMPLE
		PS C:\> Get-CapaUnitFolder -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer

		Returns the folder path for PC-01.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247632/GetUnitFolder
#>
function Get-CapaUnitFolder {
	[CmdletBinding()]
	[OutputType([object])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'GetUnitFolder')) {
		throw 'CapaSDK does not contain method GetUnitFolder.'
	}

	$value = $CapaSDK.GetUnitFolder($UnitName, $UnitType)

	return $value
}
