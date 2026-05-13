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

			$aItem = [string]$item -split ';', 15
			if ($aItem.Count -lt 15) {
				continue
			}

			[pscustomobject]@{
				RelationType = $aItem[0];
				Name         = $aItem[1];
				Created      = $aItem[2];
				LastExecuted = $aItem[3];
				Status       = $aItem[4];
				Description  = $aItem[5];
				GUID         = $aItem[7];
				ID           = $aItem[8];
				TypeName     = $aItem[9];
				UUID         = $aItem[10];
				IsMobile     = $aItem[11];
				Location     = $aItem[12];
				CmpId        = $aItem[13];
				BuId         = $aItem[14]
			}
		}

		return @($oaRelations)
	}
}