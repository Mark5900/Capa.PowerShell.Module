<#
	.SYNOPSIS
		Adds a unit to a package.

	.DESCRIPTION
		Adds the specified unit to the specified package by calling the CapaSDK
		method AddUnitToPackage.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER PackageType
		Package type. Valid values are Computer, User, 1, and 2.

	.PARAMETER PackageName
		Name of the package.

	.PARAMETER PackageVersion
		Version of the package.

	.PARAMETER UnitName
		Name of the unit to add.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.EXAMPLE
		PS C:\> Add-CapaUnitToPackage -CapaSDK $CapaSDK -PackageType Computer -PackageName 'MyPkg' -PackageVersion 'v1.0' -UnitName 'PC-01' -UnitType Computer

		Adds PC-01 to package MyPkg v1.0.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247340/Add+unit+to+package
#>
function Add-CapaUnitToPackage {
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User', '1', '2')]
		[string]$PackageType,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'AddUnitToPackage')) {
		throw 'CapaSDK does not contain method AddUnitToPackage.'
	}

	if ($PackageType -eq 'Computer') {
		$PackageType = '1'
	} elseif ($PackageType -eq 'User') {
		$PackageType = '2'
	}

	$target = "$UnitType unit '$UnitName'"
	$action = "Add to package '$PackageName' ($PackageVersion)"
	if (-not $PSCmdlet.ShouldProcess($target, $action)) {
		return
	}

	$bool = $CapaSDK.AddUnitToPackage($UnitName, $UnitType, $PackageName, $PackageVersion, $PackageType)

	return $bool
}
