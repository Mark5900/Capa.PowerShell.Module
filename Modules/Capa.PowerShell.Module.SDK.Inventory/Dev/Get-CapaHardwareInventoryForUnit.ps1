<#
	.SYNOPSIS
		Get the hardware inventory for a unit.

	.DESCRIPTION
		Get the hardware inventory for a unit.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER UnitName
		Can be the name of a unit or the UUID.

	.PARAMETER UnitType
		The type of the unit, can be Computer or User.

	.EXAMPLE
				PS C:\> Get-CapaHardwareInventoryForUnit -CapaSDK $CapaSDK -UnitName 'Klient' -UnitType Computer

	.EXAMPLE
				PS C:\> Get-CapaHardwareInventoryForUnit -CapaSDK $CapaSDK -UnitName 'E3FBEC1E-32AC-4E51-AB9F-A644CD9F0A6B' -UnitType Computer

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246368/Get+hardware+inventory+for+unit
#>
function Get-CapaHardwareInventoryForUnit {
	[CmdletBinding()]
	[OutputType([pscustomobject[]])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType
	)

	$UnitTypeId = if ($UnitType -eq 'Computer') { '1' } else { '2' }

	$oaUnits = @()

	$aUnits = $CapaSDK.GetHardwareInventoryForUnit($UnitName, $UnitTypeId)

	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$DataType = Convert-CapaDataType -Datatype $aItem[3]
		$oaUnits += [pscustomobject]@{
			Category = $aItem[0];
			Entry    = $aItem[1];
			Value    = $aItem[2];
			Datatype = $DataType;
			GUID     = $aItem[4];
			ID       = $aItem[5]
		}
	}

	return $oaUnits
}
