<#
	.SYNOPSIS
		Gets units located in a specific folder.

	.DESCRIPTION
		Gets units in the specified folder for a given business unit and unit type
		by calling the CapaSDK method GetUnitsInFolder.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER FolderStructure
		Folder path to query within the selected business unit.

	.PARAMETER UnitType
		Type of units to return. Valid values are Computer and User.

	.PARAMETER BusinessUnitName
		Name of the business unit to query in.

	.EXAMPLE
		PS C:\> Get-CapaUnitsInFolder -CapaSDK $CapaSDK -FolderStructure 'Devices\\Laptops' -UnitType Computer -BusinessUnitName 'Default'

		Returns computer units in folder Devices\Laptops under business unit Default.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247582/Get+Units+in+Folder
#>
function Get-CapaUnitsInFolder {
	[CmdletBinding()]
	[OutputType([pscustomobject[]])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$FolderStructure,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$BusinessUnitName
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'GetUnitsInFolder')) {
		throw 'CapaSDK does not contain method GetUnitsInFolder.'
	}

	$aUnits = $CapaSDK.GetUnitsInFolder($FolderStructure, $UnitType, $BusinessUnitName)
	if ($null -eq $aUnits) {
		return @()
	}

	$oaUnits = foreach ($sItem in $aUnits) {
		if ([string]::IsNullOrWhiteSpace([string]$sItem)) {
			continue
		}

		$aItem = [string]$sItem -split ';', 12
		if ($aItem.Count -lt 12) {
			continue
		}

		[pscustomobject]@{
			Name           = $aItem[0];
			Created        = $aItem[1];
			LastExecuted   = $aItem[2];
			Status         = $aItem[3];
			Description    = $aItem[4];
			GUID           = $aItem[5];
			ID             = $aItem[7];
			TypeName       = $aItem[8];
			UUID           = $aItem[9];
			IsMobileDevice = $aItem[10];
			Location       = $aItem[11]
		}
	}

	return @($oaUnits)
}
