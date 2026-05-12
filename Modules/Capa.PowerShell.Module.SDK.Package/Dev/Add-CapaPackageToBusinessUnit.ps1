<#
	.SYNOPSIS
		Adds a package to a business unit.

	.DESCRIPTION
		Adds a package to a business unit.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER PackageName
		The name of the package.

	.PARAMETER PackageVersion
		The version of the package.

	.PARAMETER PackageType
		The type of the package, either Computer or User.

	.PARAMETER BusinessUnitName
		The name of the business unit.

	.EXAMPLE
		PS C:\> Add-CapaPackageToBusinessUnit -CapaSDK $CapaSDK -PackageName 'Winrar' -PackageVersion 'v3.0' -PackageType Computer -BusinessUnitName 'HeadQuarterBronx'

	.NOTES
		for more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246796/Add+Package+to+BusinessUnit
#>
function Add-CapaPackageToBusinessUnit {
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
		[ValidateSet('Computer', 'User', '1', '2')]
		[string]$PackageType,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$BusinessUnitName
	)

	if ($PackageType -eq 'Computer') {
		$PackageType = '1'
	} elseif ($PackageType -eq 'User') {
		$PackageType = '2'
	}

	if ($PSCmdlet.ShouldProcess("$PackageName $PackageVersion", "Add package to business unit '$BusinessUnitName'")) {
		$value = $CapaSDK.AddPackageToBusinessUnit($PackageName, $PackageVersion, $PackageType, $BusinessUnitName)
		return $value
	}
}
