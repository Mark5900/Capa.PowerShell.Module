# TODO: #351 Update Get-Help for Get-PpCMSAdvertisedPackages
<#
	.SYNOPSIS
		Get a list of advertised packages.

	.DESCRIPTION
		Get a list of advertised packages. With JobId, Type, Name, Version, Uninstallscript, Catalogname, Description, Advertiseddate, Groupname and Autoexpand.

	.EXAMPLE
		$packages = Get-PpCMSAdvertisedPackages
		foreach ($package in $packages) {
			Job_WriteLog -Text "Package: $($package.PackageName) Version: $($package.PackageVersion)"
		}

#>
function Get-PpCMSAdvertisedPackages {
	[CmdletBinding()]
	param (
	)
	return CMS_GetAdvertisedPackages
}