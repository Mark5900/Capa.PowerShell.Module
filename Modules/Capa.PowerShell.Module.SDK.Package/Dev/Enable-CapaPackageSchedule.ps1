<#
	.SYNOPSIS
		Enable a packages schedule.

	.DESCRIPTION
		Eanble a packages schedule if a schedule is set.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER PackageName
		The name of the package.

	.PARAMETER PackageVersion
		The version of the package.

	.PARAMETER PackageType
		The type of package, can be either Computer or User.

	.EXAMPLE
				For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246866/Enable+Package+Schedule

	.NOTES
		Additional information about the function.
#>
function Enable-CapaPackageSchedule {
	[CmdletBinding(SupportsShouldProcess = $true)]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('1', '2', 'Computer', 'User')]
		[string]$PackageType
	)

	if ($PackageType -eq 'Computer') {
		$PackageType = '1'
	} elseif ($PackageType -eq 'User') {
		$PackageType = '2'
	}

	if ($PSCmdlet.ShouldProcess("$PackageName $PackageVersion", 'Enable package schedule')) {
		$value = $CapaSDK.EnablePackageSchedule($PackageName, $PackageVersion, $PackageType)
		return $value
	}
}
