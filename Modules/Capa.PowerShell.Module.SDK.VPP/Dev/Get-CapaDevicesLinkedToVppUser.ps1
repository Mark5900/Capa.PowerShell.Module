# TODO: #246 Update and add tests

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
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[Int]$vppUserID
	)

	$oaUnits = @()

	$aUnits = $CapaSDK.GetDevicesLinkedToVppUser($vppUserID)

	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
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
			location       = $aItem[11]
		}
	}

	Return $oaUnits
}
