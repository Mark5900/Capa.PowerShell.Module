<#
	.SYNOPSIS
		Get a list of all management servers.
	
	.DESCRIPTION
		Get a list of all management servers.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.EXAMPLE
		PS C:\> Get-CapaManagementServers -CapaSDK $CapaSDK
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247126/Get+management+servers
#>
function Get-CapaManagementServers {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetManagementServers()
	
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Name          = $aItem[0];
			Path          = $aItem[1];
			Version       = $aItem[2];
			Drive         = $aItem[3];
			Server        = $aItem[4];
			Share         = $aItem[5];
			IsParentShare = $aItem[7];
			GUID          = $aItem[8];
			ID            = $aItem[9]
		}
	}
	
	Return $oaUnits
}
