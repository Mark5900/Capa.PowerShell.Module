<#
	.SYNOPSIS
		Rebuilds CapaInstaller.kit file on Management Server. 
	
	.DESCRIPTION
		Rebuilds CapaInstaller.kit file on Management Server. The function sets an action for the assigned Replicator to perform.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER PackageName
		The name of the package.
	
	.PARAMETER PackageVersion
		The version of the package.
	
	.PARAMETER PackageType
		The type of the package.
	
	.PARAMETER ServerName
		The management server to which the package is to be added to.
	
	.EXAMPLE
		PS C:\> Rebuild-CapaKitFileOnManagementServer -CapaSDK $CapaSDK -PackageName 'WinRaR' -PackageVersion '5.50' -PackageType 'Computer' -ServerName 'MS1'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247144/Rebuild+kit+on+Management+Server
#>
function Rebuild-CapaKitFileOnManagementServer {
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
		[String]$ServerName
	)
	
	if ($PackageType -eq 'Computer') {
		$PackageType = '1'
	}
	if ($PackageType -eq 'User') {
		$PackageType = '2'
	}
	
	$value = $CapaSDK.RebuildKitFileOnServer($PackageName, $PackageVersion, $PackageType, $ServerName)
	return $value
}
