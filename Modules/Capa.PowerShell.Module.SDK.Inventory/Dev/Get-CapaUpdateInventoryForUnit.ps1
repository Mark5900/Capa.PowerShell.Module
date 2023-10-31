# TODO: Update and add tests

<#
	.SYNOPSIS
		Get update inventory for a unit.

	.DESCRIPTION
		Get a list of update inventory for a unit.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER UnitName
		The name of the unit.

	.PARAMETER UnitType
		The type of the unit, can be Computer or User.

	.EXAMPLE
				PS C:\> Get-CapaUpdateInventoryForUnit -CapaSDK $CapaSDK -UnitName 'Klient' -UnitType Computer

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246408/Get+update+inventory+for+unit
#>
function Get-CapaUpdateInventoryForUnit {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType
	)

	$oaUnits = @()

	$aUnits = $CapaSDK.GetUpdateInventoryForUnit($UnitName, $UnitType)

	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Qfename      = $aItem[0];
			InstallDate  = $aItem[1];
			UpdateID     = $aItem[2];
			UpdateName   = $aItem[3];
			Revision     = $aItem[4];
			InstallCount = $aItem[5];
			Status       = $aItem[6]
		}
	}

	Return $oaUnits
}
