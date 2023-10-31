# TODO: Update and add tests

<#
	.SYNOPSIS
		Get the folder structure of a package.

	.DESCRIPTION
		Get the folder structure of a package.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER Type
		The type of package, can be either Computer or User.

	.PARAMETER PackageName
		The name of the package.

	.PARAMETER PackageVersion
		The version of the package.

	.EXAMPLE
				PS C:\> Get-CapaPackageFolder -CapaSDK $CapaSDK -PackageType 'Computer' -PackageName 'TestPackage' -PackageVersion 'v1.0.0'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246936/Get+Package+Folder
#>
function Get-CapaPackageFolder {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$PackageType,
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion
	)

	$aUnits = $CapaSDK.GetPackageFolder($PackageName, $PackageVersion, $PackageType)
	Return $aUnits
}
