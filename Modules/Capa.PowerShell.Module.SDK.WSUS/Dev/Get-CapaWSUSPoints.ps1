# TODO: #253 Update and add tests

<#
	.SYNOPSIS
		Get a list of WSUS points.

	.DESCRIPTION
		Get a list of WSUS points.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.EXAMPLE
			Get-CapaWSUSPoints -CapaSDK $CapaSDK

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247854/Get+WSUS+points
#>
function Get-CapaWSUSPoints {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'GetWSUSPoints')) {
		throw 'CapaSDK does not contain method GetWSUSPoints.'
	}

	$aUnits = $CapaSDK.GetWSUSPoints()
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
