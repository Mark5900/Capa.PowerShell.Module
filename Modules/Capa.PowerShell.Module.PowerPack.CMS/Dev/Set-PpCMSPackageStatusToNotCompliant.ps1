# TODO: #347 Update Get-Help for Set-PpCMSPackageStatusToNotCompliant
<#
	.SYNOPSIS
		Set the status of a package to Not Compliant.

	.DESCRIPTION
		Set the status of a package to Not Compliant.

	.PARAMETER PackageName
		The name of the package to set the status for.

	.PARAMETER PackageVersion
		The version of the package to set the status for.

	.EXAMPLE
		$bStatus = Set-PpCMSPackageStatusToNotCompliant -PackageName "MyPackage" -PackageVersion "1.0.0"
		if ($bStatus) {
			Job_WriteLog -Text "Package status set to Not Compliant."
		} else {
			Job_WriteLog -Text "Failed to set package status to Not Compliant."
		}
#>
function Set-PpCMSPackageStatusToNotCompliant {
	param (
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion
	)
	return CMS_SetPackageStatusToNotCompliant -package $PackageName -version $PackageVersion
}