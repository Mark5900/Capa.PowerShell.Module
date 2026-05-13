<#
	.SYNOPSIS
		Disable a packages schedule.

	.DESCRIPTION
		Diable a packages schedule if a schedule is set.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER PackageName
		The name of the package.

	.PARAMETER PackageVersion
		The version of the package.

	.PARAMETER PackageType
		The type of package, can be Computer or User.

	.EXAMPLE
				PS C:\> Disable-CapaPackageSchedule -CapaSDK $CapaSDK -PackageName 'TestPackage' -PackageVersion 'v1.0.0' -PackageType 'Computer'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246858/Disable+Package+Schedule
#>
function Disable-CapaPackageSchedule {
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
		[ValidateSet('Computer', 'User')]
		[string]$PackageType
	)

	if ($PSCmdlet.ShouldProcess("$PackageName $PackageVersion", 'Disable package schedule')) {
		$bool = $CapaSDK.DisablePackageSchedule($PackageName, $PackageVersion, $PackageType)
		return $bool
	}
}
