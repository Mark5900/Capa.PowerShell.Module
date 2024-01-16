# TODO: #161 Update and add tests

<#
	.SYNOPSIS
		Create a package in the CapaInstaller.

	.DESCRIPTION
		Create a new package in the CapaInstaller.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER PackageName
		The name of the package.

	.PARAMETER PackageVersion
		The version of the package.

	.PARAMETER UnitType
		The type of unit.

	.PARAMETER DisplayName
		The display name of the package.

	.EXAMPLE
				PS C:\> New-CapaPackage -CapaSDK $CapaSDK -PackageName 'TestPackage' -PackageVersion 'v1.0.0' -UnitType 'Computer' -DisplayName 'Test Package'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246850/Create+package
#>
function New-CapaPackage {
	[CmdletBinding()]
	[Alias('Create-CapaPackage')]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType,
		[Parameter(Mandatory = $true)]
		[string]$DisplayName
	)

	$value = $CapaSDK.CreatePackage($PackageName, $PackageVersion, $UnitType, $DisplayName)
	return $value
}
