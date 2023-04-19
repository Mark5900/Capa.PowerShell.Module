<#
	.SYNOPSIS
		Gets a list of units linked to a WSUS group.
	
	.DESCRIPTION
		Gets a list of units linked to a WSUS group.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER WSUSGroupName
		The name of the WSUS group.
	
	.EXAMPLE
			Get-CapaWSUSGroupUnits -CapaSDK $CapaSDK -WSUSGroupName "WSUS Group"
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247622/Get+WSUS+Group+units
#>
function Get-CapaWSUSGroupUnits {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$WSUSGroupName
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetOSDiskConfiguration($OSPointID)
	
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
			Location       = $aItem[11]
		}
	}
	
	Return $oaUnits
}
