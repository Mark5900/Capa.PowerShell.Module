# TODO: #335 Update Get-Help for Initialize-PpCMSRerunPackage
<#
	.SYNOPSIS
		Sets status for the specified package to 'Waiting' causing it to rerun the next time the Agent is being executed.

	.DESCRIPTION
		Sets status for the specified package to 'Waiting' causing it to rerun the next time the Agent is being executed.

	.PARAMETER PackageName
		Name of the package to rerun.

	.PARAMETER PackageVersion
		Version of the package to rerun.

	.EXAMPLE
		$bStatus = Initialize-PpCMSRerunPackage -PackageName "MyPackage" -PackageVersion "v1.0"
		if ($bStatus) {
			Job_WriteLog -Text "Package 'MyPackage' with version 'v1.0' has been set to rerun."
		} else {
			Job_WriteLog -Text "Failed to set package 'MyPackage' with version 'v1.0' to rerun."
		}
#>
function Initialize-PpCMSRerunPackage {
	param (
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion
	)
	return CMS_RerunPackage -package $PackageName -version $PackageVersion
}