# TODO: #357 Update Get-Help for Get-PpCMSIsPackageScheduleEnabled
<#
	.SYNOPSIS
		Returns as boolean indicating if the schedule for a package is enabled.

	.DESCRIPTION
		Returns as boolean indicating if the schedule for a package is enabled.

	.PARAMETER PackageName
		The name of the package.

	.PARAMETER PackageVersion
		The version of the package.

	.EXAMPLE
		$bStatus = Get-PpCMSIsPackageScheduleEnabled -PackageName "Adobe Reader" -PackageVersion "11.0.00"
		if ($bStatus) {
			Write-Host "Package schedule is enabled."
		} else {
			Write-Host "Package schedule is not enabled."
	}
#>
function Get-PpCMSIsPackageScheduleEnabled {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion
	)
	return CMS_IsPackageScheduleEnabled -package $PackageName -version $PackageVersion
}