<#
	.SYNOPSIS
		Gets a list of all VPP users.

	.DESCRIPTION
		Gets a list of all VPP users, if VppProgramID is specified, only VPP users for the specified program will be returned.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER VppProgramID
		A description of the VppProgramID parameter.

	.EXAMPLE
			Get-CapaVppUsers -CapaSDK $CapaSDK

	.EXAMPLE
			Get-CapaVppUsers -CapaSDK $CapaSDK -VppProgramID 1

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247808/Get+vpp+users
		And https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247818/Get+vpp+users+all
#>
function Get-CapaVppUsers {
	[CmdletBinding()]
	[OutputType([pscustomobject[]])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $false)]
		[ValidateRange(1, [int]::MaxValue)]
		[Nullable[int]]$VppProgramID = $null
	)

	if ($PSBoundParameters.ContainsKey('VppProgramID') -and -not ($CapaSDK.PSObject.Methods.Name -contains 'GetVppUsers')) {
		throw 'CapaSDK does not contain method GetVppUsers.'
	}

	if (-not $PSBoundParameters.ContainsKey('VppProgramID') -and -not ($CapaSDK.PSObject.Methods.Name -contains 'GetVppUsersAll')) {
		throw 'CapaSDK does not contain method GetVppUsersAll.'
	}

	if ($PSBoundParameters.ContainsKey('VppProgramID')) {
		$aUnits = $CapaSDK.GetVppUsers($VppProgramID)
	} else {
		$aUnits = $CapaSDK.GetVppUsersAll()
	}

	if ($null -eq $aUnits) {
		return @()
	}

	$oaUnits = foreach ($sItem in $aUnits) {
		if ([string]::IsNullOrWhiteSpace([string]$sItem)) {
			continue
		}

		$aItem = [string]$sItem -split ';', 14
		if ($aItem.Count -lt 14) {
			continue
		}

		[pscustomobject]@{
			ID              = $aItem[0];
			Status          = $aItem[1];
			Updated         = $aItem[2];
			UserID          = $aItem[3];
			ClientUserIDStr = $aItem[4];
			Name            = $aItem[5];
			Description     = $aItem[7];
			Email           = $aItem[8];
			ItsIdHash       = $aItem[9];
			InviteUrl       = $aItem[10];
			InviteCode      = $aItem[11];
			VPPAccountID    = $aItem[12];
			GUID            = $aItem[13]
		}
	}

	return @($oaUnits)
}
