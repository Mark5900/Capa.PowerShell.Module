# TODO: Update and add tests

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

	$oaUnits = @()

	$aUnits = $CapaSDK.GetWSUSGroups($PointID)

	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			ID   = $aItem[0];
			Name = $aItem[1];
			GUID = $aItem[2]
		}
	}

	Return $oaUnits
}
