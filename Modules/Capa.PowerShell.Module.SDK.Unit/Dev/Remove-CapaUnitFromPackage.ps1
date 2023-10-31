# TODO: Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247672/Remove+unit+from+package

	.DESCRIPTION
		A detailed description of the Remove-CapaUnitFromPackage function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER PackageName
		A description of the PackageName parameter.

	.PARAMETER PackageVersion
		A description of the PackageVersion parameter.

	.PARAMETER PackageType
		A description of the PackageType parameter.

	.PARAMETER UnitName
		A description of the UnitName parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.EXAMPLE
				PS C:\> Remove-CapaUnitFromPackage -CapaSDK $value1 -PackageName 'Value2' -PackageVersion 'Value3' -PackageType Computer -UnitName 'Value5' -UnitType Computer

	.NOTES
		Additional information about the function.
#>
function Remove-CapaUnitFromPackage {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User', '1', '2')]
		[string]$PackageType,
		[Parameter(Mandatory = $true)]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType
	)

	if ($PackageType -eq 'Computer') {
		$PackageType = 1
	} else {
		$PackageType = 2
	}

	$bool = $CapaSDK.RemoveUnitFromPackage($UnitName, $UnitType, $PackageName, $PackageVersion, $PackageType)
	Return $bool
}
