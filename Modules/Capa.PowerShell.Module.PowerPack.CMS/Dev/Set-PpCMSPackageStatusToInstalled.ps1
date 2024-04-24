# TODO: #345 Update Get-Help for Set-PpCMSPackageStatusToInstalled
<#
	.SYNOPSIS
		Sets the status of the specified package to installed.

	.DESCRIPTION
		Sets the status of the specified package to installed.

	.PARAMETER PackageName
		The name of the package to set the status for.

	.PARAMETER PackageVersion
		The version of the package to set the status for.

	.EXAMPLE
		$bStatus = Set-PpCMSPackageStatusToInstalled -PackageName "MyPackage" -PackageVersion "1.0.0"
		if ($bStatus) {
			Job_WriteLog -Text "Package status set to installed."
		} else {
			Job_WriteLog -Text "Failed to set package status to installed."
		}
#>
function Set-PpCMSPackageStatusToInstalled {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion
	)
	return CMS_SetPackageStatusToInstalled -package $PackageName -version $PackageVersion
}