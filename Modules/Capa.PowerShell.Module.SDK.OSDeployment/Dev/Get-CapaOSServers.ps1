<#
	.SYNOPSIS
		Gets a list of OS Servers including sub servers.
	
	.DESCRIPTION
		Gets a list of OS Servers including sub servers.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER OSPointID
		The ID of the OS Point.
	
	.EXAMPLE
		PS C:\> Get-CapaOSServers -CapaSDK $CapaSDK -OSPointID 1
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246710/Get+OS+servers
#>
function Get-CapaOSServers {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$OSPointID
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetOSServers($OSPointID)
	
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			ID         = $aItem[0];
			Name       = $aItem[1];
			IP         = $aItem[2];
			Servername = $aItem[3];
			Sharename  = $aItem[4];
			UncPath    = $aItem[5]
		}
	}
	
	Return $oaUnits
}
