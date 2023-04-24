<#
	.SYNOPSIS
		Gets a list of OS Points.
	
	.DESCRIPTION
		Gets a list of OS Points.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.EXAMPLE
		PS C:\> Get-CapaOSPoints -CapaSDK $CapaSDK
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246700/Get+OS+points
#>
function Get-CapaOSPoints {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetOSPoints($OSPointID)
	
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			ID                = $aItem[0];
			Name              = $aItem[1];
			Description       = $aItem[2];
			GUID              = $aItem[3];
			FileBoot          = $aItem[4];
			FileDriverMapping = $aItem[5];
			FileOSDGui        = $aItem[6];
			FolderCommonFiles = $aItem[7];
			FolderDrivers     = $aItem[8];
			FolderImages      = $aItem[9];
			FolderOSD         = $aItem[10];
			FolderMediaMaster = $aItem[11];
			FolderScripts     = $aItem[12];
			FolderWinPE       = $aItem[13];
			OSDVersion        = $aItem[14];
			Servername        = $aItem[15];
			Sharename         = $aItem[16];
			UncPath           = $aItem[17]
		}
	}
	
	Return $oaUnits
}
