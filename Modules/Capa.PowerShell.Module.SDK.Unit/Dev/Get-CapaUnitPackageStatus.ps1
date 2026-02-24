<#
	.SYNOPSIS
		Gets package status for a unit.

	.DESCRIPTION
		Gets the status of a package on a unit by calling the CapaSDK method
		GetUnitPackageStatus.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to query package status for.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.PARAMETER PackageName
		Name of the package.

	.PARAMETER PackageVersion
		Version of the package.

	.EXAMPLE
		PS C:\> Get-CapaUnitPackageStatus -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer -PackageName 'MyPkg' -PackageVersion 'v1.0'

		Returns package status for MyPkg v1.0 on PC-01.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247536/Get+unit+package+status
#>
function Get-CapaUnitPackageStatus {
	[CmdletBinding()]
	[OutputType([object])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$PackageName,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$PackageVersion
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'GetUnitPackageStatus')) {
		throw 'CapaSDK does not contain method GetUnitPackageStatus.'
	}

	if ($UnitType -eq 'Computer') {
		$PackageType = '1'
	} else {
		$PackageType = '2'
	}

	$value = $CapaSDK.GetUnitPackageStatus($UnitName, $UnitType, $PackageName, $PackageVersion, $PackageType)
	return $value
}
