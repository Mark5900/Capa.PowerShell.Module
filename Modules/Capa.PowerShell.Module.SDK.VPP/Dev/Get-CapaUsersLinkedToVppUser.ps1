<#
	.SYNOPSIS
		Gets a list of users linked to a VPP user.

	.DESCRIPTION
		Gets a list of users linked to a vpp user, including inventory variables like full name and emails.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER VppUserID
		The ID of the VPP user.

	.EXAMPLE
		Get-CapaUsersLinkedToVppUser -CapaSDK $CapaSDK -VppUserID 1

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247612/Get+users+linked+to+vpp+user
#>
function Get-CapaUsersLinkedToVppUser {
	[CmdletBinding()]
	[OutputType([pscustomobject[]])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateRange(1, [int]::MaxValue)]
		[int]$VppUserID
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'GetUsersLinkedToVppUser')) {
		throw 'CapaSDK does not contain method GetUsersLinkedToVppUser.'
	}

	$aUnits = $CapaSDK.GetUsersLinkedToVppUser($VppUserID)
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
			Name           = $aItem[0];
			Created        = $aItem[1];
			LastExecuted   = $aItem[2];
			Status         = $aItem[3];
			Description    = $aItem[4];
			GUID           = $aItem[5];
			ID             = $aItem[6];
			TypeName       = $aItem[7];
			UUID           = $aItem[8];
			Location       = $aItem[9];
			FullName       = $aItem[10];
			EmailPrimary   = $aItem[11];
			EmailSecondary = $aItem[12];
			EmailTertiary  = $aItem[13]
		}
	}

	return @($oaUnits)
}
