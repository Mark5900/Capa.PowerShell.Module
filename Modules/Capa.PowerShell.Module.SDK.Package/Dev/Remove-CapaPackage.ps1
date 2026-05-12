<#
	.SYNOPSIS
		Removes a package.

	.DESCRIPTION
		Delete a package, if business units are specified, the package will only be removed from that business unit.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER PackageName
		The name of the package.

	.PARAMETER PackageVersion
		The version of the package.

	.PARAMETER PackageType
		The type of package, can be either Computer or User.

	.PARAMETER BusinessUnitName
		The name of the business unit to remove the package from.

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
	[CmdletBinding(SupportsShouldProcess = $true)]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$PackageName,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$PackageType,
		[String]$BusinessUnitName = '',
		[ValidateSet('True', 'False')]
		[string]$Force = 'True'

	)
	if ($BusinessUnitName -eq '') {
		if ($PSCmdlet.ShouldProcess("$PackageName $PackageVersion", 'Delete package')) {
			$value = $CapaSDK.DeletePackage($PackageName, $PackageVersion, $PackageType, $Force)
			return $value
		}
	} else {
		if ($PSCmdlet.ShouldProcess("$PackageName $PackageVersion", "Remove package from business unit '$BusinessUnitName'")) {
			$value = $CapaSDK.RemovePackageFromBusinessUnit($PackageName, $PackageVersion, $PackageType, $BusinessUnitName)
			return $value
		}
	}
}
