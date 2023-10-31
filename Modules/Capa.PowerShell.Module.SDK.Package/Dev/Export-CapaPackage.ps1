# TODO: Update and add tests

<#
	.SYNOPSIS
		Export a package.

	.DESCRIPTION
		Eports a package to a folder.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER PackageType
		The type of package, can be either Computer or User.

	.PARAMETER PackageName
		The name of the package.

	.PARAMETER PackageVersion
		The version of the package.

	.PARAMETER ToFolder
		Path to the folder where the package should be exported to.

	.EXAMPLE
				PS C:\> Export-CapaPackage -CapaSDK $CapaSDK -PackageType 'Computer' -PackageName 'TestPackage' -PackageVersion 'v1.0.0' -ToFolder 'C:\Temp'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246882/Export+package
#>
function Export-CapaPackage {
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
		[string]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[string]$ToFolder
	)

	$bool = $CapaSDK.ExportPackage($PackageName, $PackageVersion, $PackageType, $ToFolder)
	Return $bool
}
