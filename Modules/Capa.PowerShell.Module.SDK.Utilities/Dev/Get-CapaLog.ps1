# TODO: Update and add tests

<#
	.SYNOPSIS
		Returns the log for a unit package relation.

	.DESCRIPTION
		Returns the log for a unit package relation.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER UnitName
		The name of the unit.

	.PARAMETER UnitType
		The type of the unit. This can be either "Computer" or "User"

	.PARAMETER PackageName
		The name of the package.

	.PARAMETER PackageVersion
		The version of the package.

	.PARAMETER PackageType
		The type of the package, this can be either "Computer" or "User"

	.EXAMPLE
		PS C:\> Get-CapaLog -CapaSDK $CapaSDK -UnitName 'TestComputer' -UnitType 'Computer' -PackageName 'WinRaR' -PackageVersion '5.50' -PackageType 'Computer'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246920/Get+log
#>
function Get-CapaLog {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[String]$UnitType,
		[Parameter(Mandatory = $true)]
		[String]$PackageName,
		[Parameter(Mandatory = $true)]
		[String]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('1', '2', 'Computer', 'User')]
		[String]$PackageType
	)

	if ($PackageType -eq 'Computer') {
		$PackageType = '1'
	}
	if ($PackageType -eq 'User') {
		$PackageType = '2'
	}

	$value = $CapaSDK.GetLog($UnitName, $UnitType, $PackageName, $PackageVersion, $PackageType)
	return $value
}
