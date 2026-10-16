<#
	.SYNOPSIS
		Gets relations for a unit.

	.DESCRIPTION
		Gets unit relations by calling the CapaSDK method GetUnitRelations and
		returns parsed relation objects.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to query relations for.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.EXAMPLE
		PS C:\> Get-CapaUnitRelations -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer

		Returns relation rows for unit PC-01.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247554/Get+Unit+Relations
#>
function Get-CapaUnitRelations {
	[CmdletBinding()]
	[OutputType([pscustomobject[]])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true, ValueFromPipeline = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType
	)

	begin {
		if (-not ($CapaSDK.PSObject.Methods.Name -contains 'GetUnitRelations')) {
			throw 'CapaSDK does not contain method GetUnitRelations.'
		}
	}

	process {
		$aRelations = $CapaSDK.GetUnitRelations($UnitName, $UnitType)
		if ($null -eq $aRelations) {
			return @()
		}

		$oaRelations = foreach ($item in $aRelations) {
			if ([string]::IsNullOrWhiteSpace([string]$item)) {
				continue
			}

			$aItem = [string]$item -split ';', 14
			if ($aItem.Count -lt 14) {
				continue
			}

			[pscustomobject]@{
				RelationType = $aItem[0];
				Name         = $aItem[1];
				Created      = $aItem[2];
				LastExecuted = $aItem[3];
				Status       = $aItem[4];
				Description  = $aItem[5];
				GUID         = $aItem[6];
				ID           = $aItem[7];
				TypeName     = $aItem[8];
				UUID         = $aItem[9];
				IsMobile     = $aItem[10];
				Location     = $aItem[11];
				CmpId        = $aItem[12];
				BuId         = $aItem[13]
			}
		}

		return @($oaRelations)
	}
}