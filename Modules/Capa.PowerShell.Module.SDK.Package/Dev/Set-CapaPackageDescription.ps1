<#
	.SYNOPSIS
		Set the description of a package.

	.DESCRIPTION
		Set the description of a package.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER PackageName
		The name of the package to set the description of.

	.PARAMETER PackageVersion
		The version of the package to set the description of.

	.PARAMETER PackageType
		The type of package to set the description of.

	.PARAMETER Description
		The description to set.

	.EXAMPLE
				PS C:\> Set-CapaPackageDescription -CapaSDK $CapaSDK -PackageName 'Winrar' -PackageVersion '5.50' -PackageType 'Computer' -Description 'This is a description'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247024/Set+Package+Description
#>
function Set-CapaPackageDescription {
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
		[ValidateSet('1', '2', 'Computer', 'User')]
		[String]$PackageType,
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[String]$Description
	)

	if ($PackageType -eq 'Computer') {
		$PackageType = '1'
	} elseif ($PackageType -eq 'User') {
		$PackageType = '2'
	}

	if ($PSCmdlet.ShouldProcess("$PackageName $PackageVersion", 'Set package description')) {
		$value = $CapaSDK.SetPackageDescription($PackageName, $PackageVersion, $PackageType, $Description)
		return $value
	}
}
