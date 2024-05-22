# TODO: #355 Update Get-Help for Get-PpCMSIsPackageLinked
<#
	.SYNOPSIS
		Returns whether the specified package is linked to any unit or group.

	.DESCRIPTION
		Returns as boolean indicating if a package is linked to the unit.

	.PARAMETER PackageName
		The name of the package.

	.PARAMETER PackageVersion
		The version of the package.

	.EXAMPLE
		$bStatus = Get-PpCMSIsPackageLinked -PackageName "Adobe Reader" -PackageVersion "11.0.00"
		if ($bStatus) {
			Write-Host "Package is linked."
		} else {
			Write-Host "Package is not linked."
		}
#>
function Get-PpCMSIsPackageLinked {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion
	)
	return CMS_IsPackageLinked -package $PackageName -version $PackageVersion
}