<#
	.SYNOPSIS
		Gets a list of devices linked to a VPP user.

	.DESCRIPTION
		Gets a list of devices linked to a VPP user.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER vppUserID
		The ID of the VPP user.

	.EXAMPLE
		Get-CapaDevicesLinkedToVppUser -CapaSDK $CapaSDK -vppUserID 1

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247426/Get+devices+linked+to+vpp+user
#>
function Get-CapaDevicesLinkedToVppUser {
	[CmdletBinding()]
	[OutputType([pscustomobject[]])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateRange(1, [int]::MaxValue)]
		[Int]$vppUserID
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'GetDevicesLinkedToVppUser')) {
		throw 'CapaSDK does not contain method GetDevicesLinkedToVppUser.'
	}

	$aUnits = $CapaSDK.GetDevicesLinkedToVppUser($vppUserID)
	if ($null -eq $aUnits) {
		return @()
	}

	$oaUnits = foreach ($sItem in $aUnits) {
		if ([string]::IsNullOrWhiteSpace([string]$sItem)) {
			continue
		}

		$aItem = [string]$sItem -split ';', 12
		if ($aItem.Count -lt 12) {
			continue
		}

		[pscustomobject]@{
			Name           = $aItem[0];
			Created        = $aItem[1];
			LastExecuted   = $aItem[2];
			Status         = $aItem[3];
			Description    = $aItem[4];
			GUID           = $aItem[5];
			ID             = $aItem[7];
			TypeName       = $aItem[8];
			UUID           = $aItem[9];
			IsMobileDevice = $aItem[10];
			Location       = $aItem[11]
		}
	}

	return @($oaUnits)
}
