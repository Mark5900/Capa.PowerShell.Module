<#
	.SYNOPSIS
		Performs a update now on a package.
	
	.DESCRIPTION
		Performs the Update now procedure on a package. This will create a SyncJob to the CiSync service residing on the Point-server with the 'AutoJob' bit set which 
		will (after completion) in turn create 'auto-syncjobs' to child servers as well as BaseAgent-DistributionServers when/if the package is assigned or the child 
		servers are 'replica' servers.

		This function is equivalent to the CM-plugin right-click action on a package.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER PackageName
		The name of the package.
	
	.PARAMETER PackageVersion
		The version of the package.
	
	.PARAMETER PackageType
		The type of the package, either Computer or User.
	
	.EXAMPLE
				PS C:\> Update-CapaPackageNow -CapaSDK $CapaSDK -PackageName 'Winrar' -PackageVersion '5.50' -PackageType 'Computer'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247056/Update+Now+on+Package
#>
function Update-CapaPackageNow {
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
		[ValidateSet('Computer', 'User')]
		[String]$PackageType
	)
	
	$value = $CapaSDK.PackageUpdateNow($PackageName, $PackageVersion, $PackageType)
	return $value
}
