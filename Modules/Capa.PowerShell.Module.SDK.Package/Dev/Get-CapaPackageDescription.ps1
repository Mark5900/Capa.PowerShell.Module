# TODO: Update and add tests

<#
	.SYNOPSIS
		Get a description of a package.

	.DESCRIPTION
		Get a description of a package.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER PackageName
		The name of the package.

	.PARAMETER PackageVersion
		The version of the package.

	.PARAMETER PackageType
		The type of package, can be either Computer or User.

	.EXAMPLE
				PS C:\> Get-CapaPackageDescription -CapaSDK $CapaSDK -PackageName 'TestPackage' -PackageVersion 'v1.0.0' -PackageType 'Computer'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246928/Get+Package+Description
#>
function Get-CapaPackageDescription {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
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

	$value = $CapaSDK.GetPackageDescription($PackageName, $PackageVersion, $PackageType)
	return $value
}
