<#
	.SYNOPSIS
		Set package status for a unit.

	.DESCRIPTION
		Set package status for a unit in CapaInstaller.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER UnitName
		The name of the unit.

	.PARAMETER UnitType
		The unit type.

	.PARAMETER PackageName
		The name of the package.

	.PARAMETER PackageVersion
		The package version.

	.PARAMETER Status
		The package status to set.

	.PARAMETER ChangelogComment
		Optional changelog comment.

	.EXAMPLE
		PS C:\> Set-CapaUnitPackageStatus -CapaSDK $CapaSDK -UnitName 'PC001' -UnitType Computer -PackageName '7-Zip' -PackageVersion '24.09' -Status Installed

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247748/Set+unit+package+status
#>
function Set-CapaUnitPackageStatus {
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$PackageName,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Waiting', 'Failed', 'Installed', 'Uninstall', 'Cancel')]
		[String]$Status,
		[String]$ChangelogComment = ''
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'SetUnitPackageStatus')) {
		throw 'CapaSDK does not contain method SetUnitPackageStatus.'
	}

	switch ($UnitType) {
		'Computer' { $PackageType = '1' }
		'User' { $PackageType = '2' }
		default { throw "Unsupported UnitType '$UnitType'." }
	}

	$target = "$UnitType unit '$UnitName'"
	$action = "Set package '$PackageName' version '$PackageVersion' status to '$Status'"
	if ($PSCmdlet.ShouldProcess($target, $action)) {
		$value = $CapaSDK.SetUnitPackageStatus($UnitName, $UnitType, $PackageName, $PackageVersion, $PackageType, $Status, $ChangelogComment)
		return $value
	}
}
