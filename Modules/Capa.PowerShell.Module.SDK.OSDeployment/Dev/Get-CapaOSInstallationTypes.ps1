<#
	.SYNOPSIS
		Get a list of OS Installation Types.

	.DESCRIPTION
		Get a list of OS Installation Types.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER OSPointID
		The ID of the OS Point.

	.EXAMPLE
		PS C:\> Get-CapaOSInstallationTypes -CapaSDK $CapaSDK -OSPointID 1

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246688/Get+OS+installation+types
#>
function Get-CapaOSInstallationTypes {
	[CmdletBinding()]
	[OutputType([pscustomobject[]])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateRange(1, [int]::MaxValue)]
		[int]$OSPointID
	)

	$oaUnits = @()

	$aUnits = $CapaSDK.GetOSInstallationTypes($OSPointID)

	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			ID   = $aItem[0];
			GUID = $aItem[1];
			Type = $aItem[2]
		}
	}

	return $oaUnits
}
