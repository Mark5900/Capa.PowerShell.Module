<#
	.SYNOPSIS
		Removes a package from a group.

	.DESCRIPTION
		Removes a package from a group.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER PackageName
		The name of the package to remove from the group.

	.PARAMETER PackageVersion
		The version of the package to remove from the group.

	.PARAMETER PackageType
		The type of package to remove from the group.

	.PARAMETER GroupName
		The name of the group to remove the package from.

	.PARAMETER GroupType
		The type of group to remove the package from.

	.EXAMPLE
				PS C:\> Remove-CapaPackageFromGroup -CapaSDK $CapaSDK -PackageName 'Winrar' -PackageVersion '5.50' -PackageType 'Computer' -GroupName 'MyGroup' -GroupType 'Static'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247008/Remove+package+from+group
#>
function Remove-CapaPackageFromGroup {
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
		[ValidateSet('Computer', 'User')]
		[string]$PackageType,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Dynamic_ADSI', 'Calendar', 'Department', 'Dynamic_SQL', 'Reinstall', 'Security', 'Static')]
		[string]$GroupType
	)

	if ($PSCmdlet.ShouldProcess("$PackageName $PackageVersion", "Remove package from group '$GroupName'")) {
		$bool = $CapaSDK.RemovePackageFromGroup($PackageName, $PackageVersion, $PackageType, $GroupName, $GroupType)
		return $bool
	}
}
