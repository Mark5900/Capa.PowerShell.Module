<#
	.SYNOPSIS
		Gets a list of all VPP programs.

	.DESCRIPTION
		Gets a list of all VPP programs.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.EXAMPLE
		Get-CapaVppPrograms -CapaSDK $CapaSDK

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247798/Get+vpp+programs
#>
function Get-CapaVppPrograms {
	[CmdletBinding()]
	[OutputType([pscustomobject[]])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'GetVppPrograms')) {
		throw 'CapaSDK does not contain method GetVppPrograms.'
	}

	$aUnits = $CapaSDK.GetVppPrograms()
	if ($null -eq $aUnits) {
		return @()
	}

	$oaUnits = foreach ($sItem in $aUnits) {
		if ([string]::IsNullOrWhiteSpace([string]$sItem)) {
			continue
		}

		$aItem = [string]$sItem -split ';', 8
		if ($aItem.Count -lt 8) {
			continue
		}

		[pscustomobject]@{
			ID               = $aItem[0];
			Name             = $aItem[1];
			OrganisationName = $aItem[2];
			Email            = $aItem[3];
			ExpireDate       = $aItem[4];
			GUID             = $aItem[5];
			Description      = $aItem[7]
		}
	}

	return @($oaUnits)
}
