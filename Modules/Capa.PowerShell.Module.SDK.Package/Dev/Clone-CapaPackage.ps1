<#
	.SYNOPSIS
		Clone a package in Root Point.

	.DESCRIPTION
		Clone a package in Root Point.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER PackageName
		The name of the package.

	.PARAMETER PackageVersion
		The version of the package.

	.PARAMETER PackageType
		The type of the package, either Computer or User.

	.PARAMETER NewVersion
		The new version of the package.

	.EXAMPLE
		PS C:\> Clone-CapaPackage -CapaSDK $CapaSDK -PackageName 'Winrar' -PackageVersion 'v3.0' -PackageType Computer -NewVersion 'v3.1'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246823/Clone+Package
#>
function Clone-CapaPackage {
	[CmdletBinding(SupportsShouldProcess = $true)]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('1', '2', 'Computer', 'User')]
		[string]$PackageType,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$NewVersion
	)

	if ($PSCmdlet.ShouldProcess("$PackageName $PackageVersion", "Clone package to version '$NewVersion'")) {
		$value = $CapaSDK.ClonePackage($PackageName, $PackageVersion, $PackageType, $NewVersion)
		return $value
	}
}

