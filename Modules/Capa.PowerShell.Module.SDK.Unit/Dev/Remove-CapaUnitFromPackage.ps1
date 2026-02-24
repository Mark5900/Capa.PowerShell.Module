<#
	.SYNOPSIS
		Remove a unit from a package.

	.DESCRIPTION
		Remove package relation from an existing unit in CapaInstaller.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER PackageName
		The package name.

	.PARAMETER PackageVersion
		The package version.

	.PARAMETER PackageType
		The package type.

	.PARAMETER UnitName
		The unit name.

	.PARAMETER UnitType
		The unit type.

	.EXAMPLE
		PS C:\> Remove-CapaUnitFromPackage -CapaSDK $CapaSDK -PackageName '7-Zip' -PackageVersion '24.09' -PackageType Computer -UnitName 'PC001' -UnitType Computer

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247672/Remove+unit+from+package
#>
function Remove-CapaUnitFromPackage {
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
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
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'RemoveUnitFromPackage')) {
		throw 'CapaSDK does not contain method RemoveUnitFromPackage.'
	}

	switch ($PackageType) {
		'Computer' { $PackageType = '1' }
		'User' { $PackageType = '2' }
	}

	$target = "$UnitType unit '$UnitName'"
	$action = "Remove package '$PackageName' version '$PackageVersion'"
	if ($PSCmdlet.ShouldProcess($target, $action)) {
		$bool = $CapaSDK.RemoveUnitFromPackage($UnitName, $UnitType, $PackageName, $PackageVersion, $PackageType)
		return $bool
	}
}
