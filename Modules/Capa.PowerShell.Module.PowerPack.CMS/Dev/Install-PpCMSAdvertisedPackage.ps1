# TODO: #331 Update Get-Help for Install-PpCMSAdvertisedPackage
<#
	.SYNOPSIS
		Installs an advertised package on the unit on which the script is being executed

	.DESCRIPTION
		Installs an advertised package on the unit on which the script is being executed

	.PARAMETER PackageName
		The name of the package to install

	.PARAMETER PackageVersion
		The version of the package to install

	.EXAMPLE
		$bStatus = Install-PpCMSAdvertisedPackage -PackageName "MyPackage" -PackageVersion "1.0.0"
		if ($bStatus) {
			Job_WriteLog -Text "Package installed."
		} else {
			Job_WriteLog -Text "Failed to install package."
	}
#>
function Install-PpCMSAdvertisedPackage {
	param (
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion
	)
	return CMS_InstallAdvertisedPackage -package $PackageName -version $PackageVersion
}