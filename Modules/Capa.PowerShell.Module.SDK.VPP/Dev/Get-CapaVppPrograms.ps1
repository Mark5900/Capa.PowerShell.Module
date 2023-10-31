# TODO: Update and add tests

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
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK
	)

	$oaUnits = @()

	$aUnits = $CapaSDK.GetVppPrograms()

	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			ID               = $aItem[0];
			Name             = $aItem[1];
			OrganisationName = $aItem[2];
			Email            = $aItem[3];
			ExpireDate       = $aItem[4];
			GUID             = $aItem[5];
			Description      = $aItem[7]
		}
	}

	Return $oaUnits
}
