<#
	.SYNOPSIS
		Gets groups linked to a unit.

	.DESCRIPTION
		Gets groups linked to the specified unit by calling the CapaSDK method
		GetUnitGroups and returns parsed group objects.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to query groups for.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.EXAMPLE
		PS C:\> Get-CapaUnitGroups -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer

		Returns groups linked to PC-01.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247482/Get+unit+groups
#>
function Get-CapaUnitGroups {
	[CmdletBinding()]
	[OutputType([pscustomobject[]])]
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

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'GetUnitGroups')) {
		throw 'CapaSDK does not contain method GetUnitGroups.'
	}

	$aUnits = $CapaSDK.GetUnitGroups($UnitName, $UnitType)
	if ($null -eq $aUnits) {
		return @()
	}

	$oaUnits = foreach ($sItem in $aUnits) {
		if ([string]::IsNullOrWhiteSpace([string]$sItem)) {
			continue
		}

		$aItem = [string]$sItem -split ';', 6
		if ($aItem.Count -lt 6) {
			continue
		}

		[pscustomobject]@{
			Name        = $aItem[0];
			Type        = $aItem[1];
			unitTypeID  = $aItem[2];
			Description = $aItem[3];
			GUID        = $aItem[4];
			ID          = $aItem[5]
		}
	}

	return @($oaUnits)
}
