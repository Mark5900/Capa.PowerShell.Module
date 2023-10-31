# TODO: Update and add tests

<#
	.SYNOPSIS
		Copy a package in Root Point.

	.DESCRIPTION
		Copy a package in Root Point.

	.PARAMETER CapaSDK
		the CapaSDK object.

	.PARAMETER PackageName
		The name of the package.

	.PARAMETER PackageVersion
		The version of the package.

	.PARAMETER PackageType
		The type of the package, either Computer or User.

	.PARAMETER NewName
		The new name of the package.

	.PARAMETER NewVersion
		The new version of the package.

	.EXAMPLE
		PS C:\> Copy-CapaPackage -CapaSDK $CapaSDK -PackageName 'Winrar' -PackageVersion 'v3.0' -PackageType Computer -NewName 'Winrar' -NewVersion 'v3.1'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246842/Copy+Package
#>
function Copy-CapaPackage {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('1', '2', 'Computer', 'User')]
		[string]$PackageType,
		[Parameter(Mandatory = $true)]
		[string]$NewName,
		[Parameter(Mandatory = $true)]
		[string]$NewVersion
	)

	if ($PackageType -eq 'Computer') {
		$PackageType = '1'
	}
	if ($PackageType -eq 'User') {
		$PackageType = '2'
	}

	$value = $CapaSDK.CopyPackage($PackageName, $PackageVersion, $PackageType, $NewName, $NewVersion)
	return $value
}
