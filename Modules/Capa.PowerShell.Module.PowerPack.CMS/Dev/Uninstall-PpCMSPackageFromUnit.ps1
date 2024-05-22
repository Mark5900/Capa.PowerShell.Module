# TODO: #307 Update Get-Help for Uninstall-PpCMSPackageFromUnit
<#
	.SYNOPSIS
		Uninstalls package from unit.

	.DESCRIPTION
		Uninstalls package from unit.

	.PARAMETER PackageID
		ID of the package (JobId from the JOB table).

	.PARAMETER PackageName
		Name of the package.

	.PARAMETER PackageVersion
		Version of the package.

	.EXAMPLE
		$bStatus = Uninstall-PpCMSPackageFromUnit -PackageID 1234
		if ($bStatus) {
			Job_WriteLog -Text "Package uninstalled"
		} else {
			Job_WriteLog -Text "Failed to uninstall package"
		}

	.EXAMPLE
		$bStatus = Uninstall-PpCMSPackageFromUnit -PackageName 'MyPackage' -PackageVersion 'v1.0'
		if ($bStatus) {
			Job_WriteLog -Text "Package uninstalled"
		} else {
			Job_WriteLog -Text "Failed to uninstall package"
		}
#>
function Uninstall-PpCMSPackageFromUnit {
	[CmdletBinding()]
	param (
		[Parameter(ParameterSetName = 'ID', Mandatory = $true)]
		[string]$PackageID,
		[Parameter(ParameterSetName = 'NameVersion', Mandatory = $true)]
		[string]$PackageName,
		[Parameter(ParameterSetName = 'NameVersion', Mandatory = $true)]
		[string]$PackageVersion
	)
	if ($PackageID) {
		return CMS_UninstallPackageFromUnitByID -packageid $PackageID
	} else {
		return CMS_UninstallPackageFromUnit -package $PackageName -version $PackageVersion
	}
}