<#
	.SYNOPSIS
		Get software inventory for a user.

	.DESCRIPTION
		Get software inventory for a user.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER UserName
		The username of the user.

	.EXAMPLE
				PS C:\> Get-CapaSoftwareInventoryForUser -CapaSDK $CapaSDK -UserName 'Klient'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246418/Get+User+Inventory
#>
function Get-CapaUserInventory {
	[CmdletBinding()]
	[OutputType([pscustomobject[]])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$UserName
	)

	$oaUnits = @()

	$aUnits = $CapaSDK.GetUserInventory($UserName)

	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Category = $aItem[0];
			Entry    = $aItem[1];
			Value    = $aItem[2];
			Datatype = $aItem[3];
			GUID     = $aItem[4];
			ID       = $aItem[5]
		}
	}

	return $oaUnits
}
