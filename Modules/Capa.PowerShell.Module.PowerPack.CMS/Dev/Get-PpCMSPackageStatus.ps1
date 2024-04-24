# TODO: #349 Update Get-Help for Get-PpCMSPackageStatus
<#
	.SYNOPSIS
		Returns the package status for the specified package.

	.DESCRIPTION
		Returns the package status for the specified package.
		Values can be 'Installed', 'Installing', 'Waiting' 'Failed' or 'Not Scheduled'.
		'Not scheduled' indicates that the package is not linked to the unit.

	.PARAMETER PackageName
		The name of the package to get the status for.

	.PARAMETER PackageVersion
		The version of the package to get the status for.

	.EXAMPLE
		$status = Get-PpCMSPackageStatus -PackageName "MyPackage" -PackageVersion "1.0.0"
		if ($status -eq "Installed") {
			Job_WriteLog -Text "Package is installed."
		} elseif ($status -eq "Installing") {
			Job_WriteLog -Text "Package is installing."
		} elseif ($status -eq "Waiting") {
			Job_WriteLog -Text "Package is waiting."
		} elseif ($status -eq "Failed") {
			Job_WriteLog -Text "Package failed."
		} elseif ($status -eq "Not Scheduled") {
			Job_WriteLog -Text "Package is not scheduled."
		} else {
			Job_WriteLog -Text "Unknown package status."
		}
#>
function Get-PpCMSPackageStatus {
	param (
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion
	)
	return CMS_GetPackageStatus -package $PackageName -version $PackageVersion
}