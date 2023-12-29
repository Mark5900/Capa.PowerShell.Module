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

	$oaUnits = @()

	$aUnits = $CapaSDK.GetWSUSPoints()

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
