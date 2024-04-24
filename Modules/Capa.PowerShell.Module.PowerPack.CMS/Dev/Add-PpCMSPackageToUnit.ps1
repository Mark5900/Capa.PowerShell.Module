# TODO: #329 Update Get-Help for Add-PpCMSPackageToUnit
<#
	.SYNOPSIS
		Adds the specified package to the unit on which the script is being executed

	.DESCRIPTION
		Adds the specified package to the unit on which the script is being executed

	.PARAMETER PackageName
		The name of the package to add to the unit

	.PARAMETER PackageVersion
		The version of the package to add to the unit

	.EXAMPLE
		$bStatus = Add-PpCMSPackageToUnit -PackageName "MyPackage" -PackageVersion "1.0.0"
		if ($bStatus) {
			Job_WriteLog -Text "Package added to unit."
		} else {
			Job_WriteLog -Text "Failed to add package to unit."
		}
#>
function Add-PpCMSPackageToUnit {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion
	)
	return CMS_AddPackageToUnit -package $PackageName -version $PackageVersion
}