<#
	.SYNOPSIS
		Get a list of all application groups.
	
	.DESCRIPTION
		Get a list of all application groups.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.EXAMPLE
				PS C:\> Get-CapaApplicationGroups -CapaSDK $CapaSDK
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246256/Get+application+groups
#>
function Get-CapaApplicationGroups {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetApplicationGroups()
	
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Id          = $aItem[0];
			Name        = $aItem[1];
			Version     = $aItem[2];
			Vendor      = $aItem[3];
			AppCode     = $aItem[4];
			Description = $aItem[5];
			GUID        = $aItem[6]
		}
	}
	
	Return $oaUnits
}
