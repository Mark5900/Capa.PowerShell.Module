<#
	.SYNOPSIS
		Gets a list of WSUS groups.

	.DESCRIPTION
		Gets a list of WSUS groups.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER PointID
		The IS of the WSUS point.

	.EXAMPLE
			Get-CapaWSUSGroups -CapaSDK $CapaSDK -PointID 1

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247844/Get+WSUS+Groups
#>
function Get-CapaWSUSGroups {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$PointID
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'GetWSUSGroups')) {
		throw 'CapaSDK does not contain method GetWSUSGroups.'
	}

	$aUnits = $CapaSDK.GetWSUSGroups($PointID)
	if ($null -eq $aUnits) {
		return @()
	}

	$oaUnits = foreach ($sItem in $aUnits) {
		if ([string]::IsNullOrWhiteSpace([string]$sItem)) {
			continue
		}

		$aItem = [string]$sItem -split ';', 3
		if ($aItem.Count -lt 3) {
			continue
		}

		[pscustomobject]@{
			ID   = $aItem[0]
			Name = $aItem[1]
			GUID = $aItem[2]
		}
	}

	return @($oaUnits)
}
