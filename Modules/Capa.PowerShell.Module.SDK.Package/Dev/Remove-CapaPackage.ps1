# TODO: Update and add tests

<#
	.SYNOPSIS
		Removes a package.

	.DESCRIPTION
		Delete a package, if business units are specified, the package will only be removed from that business unit.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER PackageType
		The type of package, can be either Computer or User.

	.PARAMETER PackageName
		The name of the package.

	.PARAMETER PackageVersion
		The version of the package.

	.PARAMETER Force
		Force deletion of the package regardless of any linked units, groups, or business units.

	.EXAMPLE
				PS C:\> Remove-CapaPackage -CapaSDK $CapaSDK -PackageType 'Computer' -PackageName 'Winrar' -PackageVersion '5.50' -Force $true

	.EXAMPLE
				PS C:\> Remove-CapaPackage -CapaSDK $CapaSDK -PackageType 'Computer' -PackageName 'Winrar' -PackageVersion '5.50' -Force $true -BusinessUnitName 'MyBusinessUnit'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246831/Delete+Package
		And https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247000/Remove+Package+From+BusinessUnit
#>
function Remove-CapaPackage {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$PackageName,
		[Parameter(Mandatory = $true)]
		[String]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$PackageType,
		[String]$BusinessUnitName = '',
		[ValidateSet('True', 'False')]
		[string]$Force = 'True'

	)
	if ($BusinessUnitName -eq '') {
		$value = $CapaSDK.DeletePackage($PackageName, $PackageVersion, $PackageType, $Force)
	} else {
		$value = $CapaSDK.RemovePackageFromBusinessUnit($PackageName, $PackageVersion, $PackageType, $BusinessUnitName)
	}

	Return $value
}
