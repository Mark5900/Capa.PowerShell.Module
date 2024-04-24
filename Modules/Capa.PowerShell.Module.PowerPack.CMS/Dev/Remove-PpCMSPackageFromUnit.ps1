# TODO: #333 Update Get-Help for Remove-PpCMSPackageFromUnit
<#
	.SYNOPSIS
		Removes the specified package from the unit on which the script is being executed

	.DESCRIPTION
		Removes the specified package from the unit on which the script is being executed

	.PARAMETER PackageName
		The name of the package to remove from the unit

	.PARAMETER PackageVersion
		The version of the package to remove from the unit

	.EXAMPLE
		$bStatus = Remove-PpCMSPackageFromUnit -PackageName "MyPackage" -PackageVersion "1.0.0"
		if ($bStatus) {
			Job_WriteLog -Text "Package removed from unit."
		} else {
			Job_WriteLog -Text "Failed to remove package from unit."
	}
#>
function Remove-PpCMSPackageFromUnit {
	param (
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion
	)
	return CMS_RemovePackageFromUnit -package $PackageName -version $PackageVersion
}