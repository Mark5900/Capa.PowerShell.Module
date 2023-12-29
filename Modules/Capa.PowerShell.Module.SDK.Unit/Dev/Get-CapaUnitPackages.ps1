# TODO: #219 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247544/Get+unit+packages

	.DESCRIPTION
		A detailed description of the Get-CapaUnitPackages function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.EXAMPLE
				PS C:\> Get-CapaUnitPackages -CapaSDK $value1 -UnitName $value2 -UnitType Computer

	.NOTES
		Additional information about the function.
#>
function Get-CapaUnitPackages {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		$UnitType
	)

	$oaUnits = @()

	$aUnits = $CapaSDK.GetUnitPackages($UnitName, $UnitType)

	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Name               = $aItem[0];
			Version            = $aItem[1];
			Type               = $aItem[2];
			DisplayName        = $aItem[3];
			IsMandatory        = $aItem[4];
			ScheduleId         = $aItem[5];
			Description        = $aItem[7];
			GUID               = $aItem[8];
			ID                 = $aItem[9];
			IsInteractive      = $aItem[10];
			DependendPackageID = $aItem[11];
			IsInventoryPackage = $aItem[12];
			CollectMode        = $aItem[13];
			Priority           = $aItem[14];
			ServerDeploy       = $aItem[15]
		}
	}

	Return $oaUnits
}
