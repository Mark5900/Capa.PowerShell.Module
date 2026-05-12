<#
	.SYNOPSIS
		Gets units linked to a unit.

	.DESCRIPTION
		Gets linked units for the specified unit by calling the CapaSDK method
		GetUnitLinkedUnits. If that method is deprecated in the SDK, the function
		falls back to GetUnitRelations.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to query linked units for.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.EXAMPLE
		PS C:\> Get-CapaUnitLinkedUnits -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer

		Returns linked units for PC-01.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247500/Get+unit+linked+units
#>
function Get-CapaUnitLinkedUnits {
	[CmdletBinding()]
	[OutputType([pscustomobject[]])]
	param (
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

	$CanUseLinkedUnitsMethod = $CapaSDK.PSObject.Methods.Name -contains 'GetUnitLinkedUnits'
	$CanUseRelationsMethod = $CapaSDK.PSObject.Methods.Name -contains 'GetUnitRelations'

	if (-not $CanUseLinkedUnitsMethod -and -not $CanUseRelationsMethod) {
		throw 'CapaSDK does not contain method GetUnitLinkedUnits or GetUnitRelations.'
	}

	$aUnits = $null
	$UseRelationsFallback = $false

	if ($CanUseLinkedUnitsMethod) {
		try {
			$aUnits = $CapaSDK.GetUnitLinkedUnits($UnitName, $UnitType)
		} catch {
			if ($CanUseRelationsMethod -and $_.Exception.Message -like '*no longer supported*GetUnitRelations*') {
				$UseRelationsFallback = $true
			} else {
				throw
			}
		}
	} else {
		$UseRelationsFallback = $true
	}

	if ($UseRelationsFallback) {
		$aUnits = $CapaSDK.GetUnitRelations($UnitName, $UnitType)
	}

	if ($null -eq $aUnits) {
		return @()
	}

	$oaUnits = foreach ($sItem in $aUnits) {
		if ([string]::IsNullOrWhiteSpace([string]$sItem)) {
			continue
		}

		if ($UseRelationsFallback) {
			$aItem = [string]$sItem -split ';', 15
			if ($aItem.Count -lt 15) {
				continue
			}

			if ($aItem[9] -eq $UnitType) {
				continue
			}

			[pscustomobject]@{
				Name         = $aItem[1];
				Created      = $aItem[2];
				LastExecuted = $aItem[3];
				Status       = $aItem[4];
				Description  = $aItem[5];
				GUID         = $aItem[7];
				ID           = $aItem[8];
				TypeName     = $aItem[9]
			}
		} else {
			$aItem = [string]$sItem -split ';', 9
			if ($aItem.Count -lt 9) {
				continue
			}

			[pscustomobject]@{
				Name         = $aItem[0];
				Created      = $aItem[1];
				LastExecuted = $aItem[2];
				Status       = $aItem[3];
				Description  = $aItem[4];
				GUID         = $aItem[5];
				ID           = $aItem[7];
				TypeName     = $aItem[8]
			}
		}
	}

	return @($oaUnits)
}
