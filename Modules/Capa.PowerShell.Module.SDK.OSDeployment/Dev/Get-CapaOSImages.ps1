<#
	.SYNOPSIS
		Gets a list of OS Images.
	
	.DESCRIPTION
		Gets a list of OS Images.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER OSPointID
		The ID of the OS Point.
	
	.EXAMPLE
		PS C:\> Get-CapaOSImages -CapaSDK $CapaSDK -OSPointID 1
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246676/Get+OS+images
#>
function Get-CapaOSImages {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$OSPointID
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetOSImages($OSPointID)
	
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			ID          = $aItem[0];
			Name        = $aItem[1];
			Description = $aItem[2];
			Filename    = $aItem[3];
			GUID        = $aItem[4];
			ImageFile   = $aItem[5];
			LocalFile   = $aItem[6];
			OSName      = $aItem[7]
		}
	}
	
	Return $oaUnits
}
