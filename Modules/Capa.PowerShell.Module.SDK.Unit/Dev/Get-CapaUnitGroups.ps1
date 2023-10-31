# TODO: Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247482/Get+unit+groups

	.DESCRIPTION
		A detailed description of the Get-CapaUnitGroups function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.EXAMPLE
				PS C:\> Get-CapaUnitGroups -CapaSDK $value1 -UnitName 'Value2' -UnitType Computer

	.NOTES
		Additional information about the function.
#>
function Get-CapaUnitGroups {
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

	$oaUnits = @()

	$aUnits = $CapaSDK.GetUnitGroups($UnitName, $UnitType)
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Name        = $aItem[0];
			Type        = $aItem[1];
			unitTypeID  = $aItem[2];
			Description = $aItem[3];
			GUID        = $aItem[4];
			ID          = $aItem[5]
		}
	}

	Return $oaUnits
}
