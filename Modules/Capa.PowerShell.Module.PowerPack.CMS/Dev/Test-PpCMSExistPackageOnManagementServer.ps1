# TODO: #343 Update Get-Help for Test-PpCMSExistPackageOnManagementServer
<#
	.SYNOPSIS
		Checks if the specified package exists on the management server the agent is connected to.

	.DESCRIPTION
		Checks if the specified package exists on the management server the agent is connected to.

	.PARAMETER PackageName
		The name of the package to check for.

	.PARAMETER PackageVersion
		The version of the package to check for.

	.PARAMETER MustExist
		If the package must exist or not. Default is false.

	.EXAMPLE
		$bStatus = Test-PpCMSExistPackageOnManagementServer -PackageName "MyPackage" -PackageVersion "1.0.0"
		if ($bStatus) {
			Job_WriteLog -Text "Package exists on management server."
		} else {
			Job_WriteLog -Text "Package does not exist on management server."
		}
#>
function Test-PpCMSExistPackageOnManagementServer {
	param (
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion,
		[Parameter(Mandatory = $false)]
		[bool]$MustExist = $false
	)
	return CMS_ExistPackageOnManagementServer -package $PackageName -version $PackageVersion -mustexist $MustExist
}