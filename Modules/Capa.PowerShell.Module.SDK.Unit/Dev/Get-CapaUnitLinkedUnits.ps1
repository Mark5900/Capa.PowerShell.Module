# TODO: Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247500/Get+unit+linked+units

	.DESCRIPTION
		A detailed description of the Get-CapaUnitLinkedUnits function.

	.EXAMPLE
				PS C:\> Get-CapaUnitLinkedUnits

	.NOTES
		Additional information about the function.
#>
function Get-CapaUnitLinkedUnits {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		$UnitType
	)

	$oaUnits = @()

	$aUnits = $CapaSDK.GetUnitLinkedUnits($UnitName, $UnitType)

	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Name         = $aItem[0];
			Created      = $aItem[1];
			LastExecuted = $aItem[2];
			Status       = $aItem[3];
			Description  = $aItem[4];
			GUID         = $aItem[5];
			ID           = $aItem[7];
			TypeName     = $aItem[8]
		}
	}

	Return $oaUnits
}
