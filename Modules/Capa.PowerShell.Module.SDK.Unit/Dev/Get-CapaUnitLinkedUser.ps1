<#
	.SYNOPSIS
		Gets linked user entries for a computer unit.

	.DESCRIPTION
		Gets users linked to the specified computer by calling the CapaSDK method
		GetUnitLinkedUser and returns parsed user objects.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER ComputerName
		Name of the computer unit to query linked users for.

	.EXAMPLE
		PS C:\> Get-CapaUnitLinkedUser -CapaSDK $CapaSDK -ComputerName 'PC-01'

		Returns linked user entries for PC-01.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247510/Get+unit+linked+user
#>
function Get-CapaUnitLinkedUser {
	[CmdletBinding()]
	[OutputType([pscustomobject[]])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$ComputerName
	)

	$CanUseLinkedUserMethod = $CapaSDK.PSObject.Methods.Name -contains 'GetUnitLinkedUser'
	$CanUseRelationsMethod = $CapaSDK.PSObject.Methods.Name -contains 'GetUnitRelations'

	if (-not $CanUseLinkedUserMethod -and -not $CanUseRelationsMethod) {
		throw 'CapaSDK does not contain method GetUnitLinkedUser or GetUnitRelations.'
	}

	$aUnits = $null
	$UseRelationsFallback = $false

	if ($CanUseLinkedUserMethod) {
		try {
			$aUnits = $CapaSDK.GetUnitLinkedUser($ComputerName)
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
		$aUnits = $CapaSDK.GetUnitRelations($ComputerName, 'Computer')
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

			if ($aItem[9] -ne 'User') {
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
