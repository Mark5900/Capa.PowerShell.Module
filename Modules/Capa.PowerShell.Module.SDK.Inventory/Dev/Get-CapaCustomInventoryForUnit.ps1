<#
	.SYNOPSIS
		Get the custom inventory for a unit.
	
	.DESCRIPTION
		Get the custom inventory for a unit, with the option to get the inventory by name and type or by UUID.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER UnitName
		The name of the unit.
	
	.PARAMETER UnitType
		The type of the unit.
	
	.PARAMETER Uuid
		The UUID of the unit.
	
	.EXAMPLE
				PS C:\> Get-CapaCustomInventoryForUnit -Uuid 'E3FBEC1E-32AC-4E51-AB9F-A644CD9F0A6B'

	.EXAMPLE
				PS C:\> Get-CapaCustomInventoryForUnit -UnitName 'CAPA-TEST-01' -UnitType 'Computer'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246358/Get+custom+inventory+for+unit
#>
function Get-CapaCustomInventoryForUnit {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(ParameterSetName = 'NameType',
			Mandatory = $true)]
		[string]$UnitName,
		[Parameter(ParameterSetName = 'NameType',
			Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType,
		[Parameter(ParameterSetName = 'Uuid',
			Mandatory = $true)]
		[string]$Uuid
	)
	
	$oaUnits = @()
	
	if ($PSCmdlet.ParameterSetName -eq 'NameType') {
		$aUnits = $CapaSDK.GetCustomInventoryForUnit($UnitName, $UnitType)
	} else {
		$aUnits = $CapaSDK.GetCustomInventoryForUnitUUID($Uuid)
	}
	
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
	
	Return $oaUnits
}
