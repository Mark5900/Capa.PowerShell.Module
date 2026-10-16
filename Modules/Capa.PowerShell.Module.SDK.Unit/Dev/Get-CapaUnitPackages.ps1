<#
	.SYNOPSIS
		Gets packages linked to a unit.

	.DESCRIPTION
		Gets packages linked to a unit by calling the CapaSDK method GetUnitPackages
		and returns parsed package objects.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to query packages for.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.EXAMPLE
		PS C:\> Get-CapaUnitPackages -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer

		Returns packages linked to PC-01.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247544/Get+unit+packages
#>
function Get-CapaUnitPackages {
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

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'GetUnitPackages')) {
		throw 'CapaSDK does not contain method GetUnitPackages.'
	}

	$aUnits = $CapaSDK.GetUnitPackages($UnitName, $UnitType)
	if ($null -eq $aUnits) {
		return @()
	}

	$oaUnits = foreach ($sItem in $aUnits) {
		if ([string]::IsNullOrWhiteSpace([string]$sItem)) {
			continue
		}

		$aItem = [string]$sItem -split ';', 15
		if ($aItem.Count -lt 15) {
			continue
		}

		[pscustomobject]@{
			Name               = $aItem[0];
			Version            = $aItem[1];
			Type               = $aItem[2];
			DisplayName        = $aItem[3];
			IsMandatory        = $aItem[4];
			ScheduleId         = $aItem[5];
			Description        = $aItem[6];
			GUID               = $aItem[7];
			ID                 = $aItem[8];
			IsInteractive      = $aItem[9];
			DependendPackageID = $aItem[10];
			IsInventoryPackage = $aItem[11];
			CollectMode        = $aItem[12];
			Priority           = $aItem[13];
			ServerDeploy       = $aItem[14]
		}
	}

	return @($oaUnits)
}
