<#
	.SYNOPSIS
		Get a list of all business units.

	.DESCRIPTION
		Get a list of all business units.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.EXAMPLE
		PS C:\> Get-CapaBusinessUnits -CapaSDK $CapaSDK

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247086/Get+Business+Units
#>
function Get-CapaBusinessUnits {
	[CmdletBinding()]
	[OutputType([pscustomobject[]])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		$CapaSDK
	)

	$oaUnits = @()

	$aUnits = $CapaSDK.GetBusinessUnits()

	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Name = $aItem[0];
			GUID = $aItem[1];
			Id   = $aItem[2]
		}
	}

	return $oaUnits
}
