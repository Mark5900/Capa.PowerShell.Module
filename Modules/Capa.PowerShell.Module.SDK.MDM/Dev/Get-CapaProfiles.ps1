<#
	.SYNOPSIS
		Get all profiles.
	
	.DESCRIPTION
		Get all profiles from the Default Management Point.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.EXAMPLE
		PS C:\> Get-CapaProfiles -CapaSDK $CapaSDK
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246626/Get+Profiles
#>
function Get-CapaProfiles {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetProfiles()
	
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			ID          = $aItem[0];
			Name        = $aItem[1];
			Description = $aItem[2];
			Priority    = $aItem[3];
			Version     = $aItem[4];
			CMPID       = $aItem[5];
			GUID        = $aItem[6]
		}
	}
	
	Return $oaUnits
}
