# TODO: Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247536/Get+unit+package+status

	.DESCRIPTION
		A detailed description of the Get-CapaUnitPackageStatus function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName  parameter.

	.PARAMETER UnitType
		A description of the UnitType  parameter.

	.PARAMETER PackageName
		A description of the PackageName  parameter.

	.PARAMETER PackageVersion
		A description of the PackageVersion  parameter.

	.EXAMPLE
		PS C:\> Get-CapaUnitPackageStatus -CapaSDK 'Value1' -UnitName  'Value2' -UnitType  'Value3' -PackageName  'Value4' -PackageVersion  'Value5' -PackageType  'Value6'

	.NOTES
		Additional information about the function.
#>
function Get-CapaUnitPackageStatus {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		[String]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType,
		[Parameter(Mandatory = $true)]
		[String]$PackageName,
		[Parameter(Mandatory = $true)]
		[String]$PackageVersion
	)

	if ($UnitType -eq 'Computer') {
		$PackageType = '1'
	} else {
		$PackageType = '2'
	}

	$value = $CapaSDK.GetUnitPackageStatus($UnitName, $UnitType, $PackageName, $PackageVersion, $PackageType)
	return $value
}
