<#
	.SYNOPSIS
		Removes a package from a management server.

	.DESCRIPTION
		Removes a package from a management server.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER PackageName
		The name of the package to remove from the management server.

	.PARAMETER PackageVersion
		The version of the package to remove from the management server.

	.PARAMETER PackageType
		The type of package to remove from the management server.

	.PARAMETER ServerName
		The name of the management server to remove the package from.

	.EXAMPLE
				PS C:\> Remove-CapaPackageFromManagementServer -CapaSDK $CapaSDK -PackageName 'Winrar' -PackageVersion '5.50' -PackageType 'Computer' -ServerName 'MyServer'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247016/Remove+package+from+management+server
#>
function Remove-CapaPackageFromManagementServer {
	[CmdletBinding(SupportsShouldProcess = $true)]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$PackageName,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('1', '2', 'Computer', 'User')]
		[String]$PackageType,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$ServerName
	)

	if ($PackageType -eq 'Computer') {
		$PackageType = '1'
	} elseif ($PackageType -eq 'User') {
		$PackageType = '2'
	}

	if ($PSCmdlet.ShouldProcess("$PackageName $PackageVersion", "Remove package from management server '$ServerName'")) {
		$value = $CapaSDK.RemovePackageFromManagementServer($PackageName, $PackageVersion, $PackageType, $ServerName)
		return $value
	}
}
