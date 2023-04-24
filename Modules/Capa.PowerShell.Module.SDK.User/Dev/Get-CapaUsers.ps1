<#
	.SYNOPSIS
		Get a list of all users.
	
	.DESCRIPTION
		Get a list of all users.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.EXAMPLE
		PS C:\> Get-CapaUsers -CapaSDK $CapaSDK
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247602/Get+Users
#>
function Get-CapaUsers {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetUsers()
	
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
			Location       = $aItem[10];
			FullName       = $aItem[11];
			EmailPrimary   = $aItem[12];
			EmailSecondary = $aItem[13];
			EmailTertiary  = $aItem[14]
		}
	}
	
	Return $oaUnits
}
