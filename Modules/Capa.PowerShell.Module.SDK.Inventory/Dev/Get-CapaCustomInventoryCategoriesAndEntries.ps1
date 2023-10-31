# TODO: Update and add tests

<#
	.SYNOPSIS
		Get custom inventory categories and entries.

	.DESCRIPTION
		Get custom inventory categories and entries.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.EXAMPLE
				PS C:\> Get-CapaCustomInventoryCategoriesAndEntries -CapaSDK $CapaSDK

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246428/GetCustomInventoryCategoriesAndEntries
#>
function Get-CapaCustomInventoryCategoriesAndEntries {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK
	)

	$oaUnits = @()

	$aUnits = $CapaSDK.GetCustomInventoryCategoriesAndEntrie($UserName)

	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')

		$Datatype = Convert-CapaDataType -Datatype $aItem [2]

		$oaUnits += [pscustomobject]@{
			Category = $aItem[0];
			Entry    = $aItem[1];
			Datatype = $Datatype
		}
	}

	Return $oaUnits
}
