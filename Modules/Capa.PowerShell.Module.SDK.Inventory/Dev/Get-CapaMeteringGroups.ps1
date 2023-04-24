<#
	.SYNOPSIS
		Get metering groups.
	
	.DESCRIPTION
		Gets a list of metering groups.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.EXAMPLE
				PS C:\> Get-CapaMeteringGroups -CapaSDK $CapaSDK
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246388/Get+metering+groups
#>
function Get-CapaMeteringGroups {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetMeteringGroups()
	
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Name           = $aItem[0];
			Version        = $aItem[1];
			Vendor         = $aItem[2];
			AppCode        = $aItem[3];
			Description    = $aItem[4];
			MeteringModule = $aItem[5];
			GUID           = $aItem[6];
			ID             = $aItem[7]
		}
	}
	
	Return $oaUnits
}
