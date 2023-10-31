# TODO: Update and add tests

<#
	.SYNOPSIS
		Gets a list of packages and their status on a unit.

	.DESCRIPTION
		Gets a list of packages and their status on a unit.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER UnitName
		The name of the unit, can also be the UUID.

	.PARAMETER UnitType
		The type of unit, can be either Computer or User.

	.EXAMPLE
				PS C:\> Get-CapaPackageStatus -CapaSDK $value1 -UnitName  'Value2' -UnitType Computer

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246944/Get+package+status
#>
function Get-CapaPackageStatus {
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

	$aUnits = $CapaSDK.GetPackageStatus($UnitName, $UnitType)

	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			UnitName       = $aItem[0];
			PackageName    = $aItem[1];
			PackageVersion = $aItem[2];
			Status         = $aItem[3];
			DisplayStatus  = $aItem[4]
		}
	}

	Return $oaUnits
}
