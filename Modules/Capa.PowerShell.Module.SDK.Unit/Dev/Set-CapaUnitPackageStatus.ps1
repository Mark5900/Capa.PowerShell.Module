# TODO: Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247748/Set+unit+package+status

	.DESCRIPTION
		A detailed description of the Set-CapaUnitPackageStatus function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName  parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.PARAMETER PackageName
		A description of the PackageName  parameter.

	.PARAMETER PackageVersion
		A description of the PackageVersion  parameter.

	.PARAMETER Status
		A description of the Status  parameter.

	.PARAMETER ChangelogComment
		A description of the ChangelogComment parameter.

	.EXAMPLE
		PS C:\> Set-CapaUnitPackageStatus -CapaSDK $value1 -UnitName  $value2 -UnitType Computer -PackageName  $value4 -PackageVersion  $value5 -Status  $value6

	.NOTES
		Additional information about the function.
#>
function Set-CapaUnitPackageStatus {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType,
		[Parameter(Mandatory = $true)]
		[String]$PackageName,
		[Parameter(Mandatory = $true)]
		[String]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Waiting', 'Failed', 'Installed', 'Uninstall', 'Cancel')]
		[String]$Status,
		[String]$ChangelogComment = ''
	)

	if ($UnitType -eq 'Computer') {
		$PackageType = '1'
	} else {
		$PackageType = '2'
	}

	$value = $CapaSDK.SetUnitPackageStatus($UnitName, $UnitType, $PackageName, $PackageVersion, $Status, $ChangelogComment)
	return $value
}
