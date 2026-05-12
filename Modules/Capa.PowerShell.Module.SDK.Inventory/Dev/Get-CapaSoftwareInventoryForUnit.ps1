<#
	.SYNOPSIS
		Get software inventory for a unit.

	.DESCRIPTION
		Get software inventory for a unit.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER UnitName
		The name of the unit.

	.PARAMETER UnitType
		The type of the unit, can be Computer or User.

	.PARAMETER Uuid
		The UUID of the unit.

	.EXAMPLE
				PS C:\> Get-CapaSoftwareInventoryForUnit -CapaSDK $CapaSDK -UnitName 'Klient' -UnitType Computer

	.EXAMPLE
				PS C:\> Get-CapaSoftwareInventoryForUnit -CapaSDK $CapaSDK -UnitName 'E3FBEC1E-32AC-4E51-AB9F-A644CD9F0A6B' -UnitType Computer

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246398/Get+software+inventory+for+unit
#>
function Get-CapaSoftwareInventoryForUnit {
	[CmdletBinding()]
	[OutputType([pscustomobject[]])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		$CapaSDK,
		[Parameter(ParameterSetName = 'NameType',
			Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$UnitName,
		[Parameter(ParameterSetName = 'NameType', Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType,
		[Parameter(ParameterSetName = 'Uuid',
			Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$Uuid
	)

	$UnitTypeId = if ($UnitType -eq 'Computer') { '1' } elseif ($UnitType -eq 'User') { '2' } else { $UnitType }

	$oaUnits = @()

	if ($PSCmdlet.ParameterSetName -eq 'NameType') {
		$aUnits = $CapaSDK.GetSoftwareInventoryForUnit($UnitName, $UnitTypeId)
	} else {
		$aUnits = $CapaSDK.GetSoftwareInventoryForUnit($Uuid, $UnitTypeId)
	}

	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			SoftwareName           = $aItem[0];
			SoftwareVersion        = $aItem[1];
			InstallDate            = $aItem[2];
			SoftwareMeteringModule = $aItem[3];
			SoftwareAppCode        = $aItem[4];
			SoftwareDescription    = $aItem[5];
			SoftwareID             = $aItem[6];
			SoftwareVendor         = $aItem[7]
		}
	}

	return $oaUnits
}
