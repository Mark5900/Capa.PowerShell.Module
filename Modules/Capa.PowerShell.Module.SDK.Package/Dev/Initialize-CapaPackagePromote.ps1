# TODO: Update and add tests

<#
	.SYNOPSIS
		Initializes a package promotion.

	.DESCRIPTION
		Initialize a package promotion.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER PackageType
		The type of package, can be either Computer or User.

	.PARAMETER PackageName
		The name of the package.

	.PARAMETER PackageVersion
		The version of the package.

	.EXAMPLE
				PS C:\> Initialize-CapaPackagePromote -CapaSDK $CapaSDK -PackageType 'Computer' -PackageName 'Winrar' -PackageVersion '5.50'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246992/Promote+Package
#>
function Initialize-CapaPackagePromote {
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

	$bool = $CapaSDK.PackagePromote($PackageName, $PackageVersion, $PackageType)
	Return $bool
}
