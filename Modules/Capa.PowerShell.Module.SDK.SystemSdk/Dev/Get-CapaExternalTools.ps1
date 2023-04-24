<#
	.SYNOPSIS
		Get a list of all external tools.
	
	.DESCRIPTION
		Get a list of all external tools.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.EXAMPLE
		PS C:\> Get-CapaExternalTools -CapaSDK $CapaSDK
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247096/Get+external+tools
#>
function Get-CapaExternalTools {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetExternalTools()
	
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			ID        = $aItem[0];
			Name      = $aItem[1];
			Path      = $aItem[2];
			Arguments = $aItem[3]
		}
	}
	
	Return $oaUnits
}
