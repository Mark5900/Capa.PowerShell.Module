<#
	.SYNOPSIS
		Adds a package to a management server.

	.DESCRIPTION
		Adds a package to a management server.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER PackageName
		The name of the package.

	.PARAMETER PackageVersion
		The version of the package.

	.PARAMETER PackageType
		The type of the package, either Computer or User.

	.PARAMETER ServerName
		The name of the server.

	.EXAMPLE
		PS C:\> Add-CapaPackageToManagementServer -CapaSDK $CapaSDK -PackageName 'Winrar' -PackageVersion 'v3.0' -PackageType Computer -ServerName 'Server1'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246815/Add+package+to+management+server
#>
function Add-CapaPackageToManagementServer {
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
		[string]$PackageType,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$ServerName
	)

	if ($PackageType -eq 'Computer') {
		$PackageType = '1'
	} elseif ($PackageType -eq 'User') {
		$PackageType = '2'
	}

	if ($PSCmdlet.ShouldProcess("$PackageName $PackageVersion", "Add package to management server '$ServerName'")) {
		$value = $CapaSDK.AddPackageToManagementServer($PackageName, $PackageVersion, $PackageType, $ServerName)
		return $value
	}
}
