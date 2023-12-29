# TODO: #223 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247582/Get+Units+in+Folder

	.DESCRIPTION
		A detailed description of the Get-CapaUnitsInFolder function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER FolderStructure
		A description of the FolderStructure  parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.PARAMETER BusinessUnitName
		A description of the BusinessUnitName  parameter.

	.EXAMPLE
				PS C:\> Get-CapaUnitsInFolder -CapaSDK $value1 -FolderStructure  $value2 -UnitType Computer -BusinessUnitName  $value4

	.NOTES
		Additional information about the function.
#>
function Get-CapaUnitsInFolder {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		$FolderStructure,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		$UnitType,
		[Parameter(Mandatory = $true)]
		$BusinessUnitName
	)

	$oaUnits = @()

	$aUnits = $CapaSDK.GetUnitsInFolder($FolderStructure, $UnitType, $BusinessUnitName)

	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
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

	Return $oaUnits
}
