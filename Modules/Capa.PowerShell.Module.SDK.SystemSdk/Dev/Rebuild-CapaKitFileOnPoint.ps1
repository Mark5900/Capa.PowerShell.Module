# TODO: Update and add tests

<#
	.SYNOPSIS
		Rebuilds CapaInstaller.kit file on all Management Servers in the given Management Point.

	.DESCRIPTION
		Rebuilds CapaInstaller.kit file on all Management Servers in the given Management Point.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER PackageName
		The name of the package.

	.PARAMETER PackageVersion
		The version of the package.

	.PARAMETER PackageType
		The type of the package.

	.PARAMETER PointID
		The ID of the management point.

	.EXAMPLE
		PS C:\> Rebuild-CapaKitFileOnPoint -CapaSDK $CapaSDK -PackageName 'WinRaR' -PackageVersion '5.50' -PackageType 'Computer' -PointID 1

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247136/Rebuild+kit+on+Management+Point
#>
function Rebuild-CapaKitFileOnPoint {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$PackageName,
		[Parameter(Mandatory = $true)]
		[String]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('1', '2', 'Computer', 'User')]
		[String]$PackageType,
		[Parameter(Mandatory = $true)]
		[int]$PointID
	)

	if ($PackageType -eq 'Computer') {
		$PackageType = '1'
	}
	if ($PackageType -eq 'User') {
		$PackageType = '2'
	}

	$value = $CapaSDK.RebuildKitFileOnPoint($PackageName, $PackageVersion, $PackageType, $PointID)
	return $value
}
