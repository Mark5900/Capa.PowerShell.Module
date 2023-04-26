
<#
	.SYNOPSIS
		Create an CapaInstaller AD group.

	.DESCRIPTION
		Create an CapaInstaller AD group.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER GroupName
		The name of the group.
	
	.PARAMETER UnitType
		The type of the elements in the group. This can be either "Computer" or "User"
	
	.PARAMETER LDAPPath
		The LDAP path of the elements in the group.
	
	.PARAMETER recursive
		Indicates whether the group should be processed recursively.
	
	.EXAMPLE
		PS C:\> Create-CapaADGroup -CapaSDK $CapaSDK -GroupName 'TestGroup' -UnitType 'Computer' -LDAPPath 'LDAP://OU=TestOU,DC=capa,DC=local' -recursive 'true'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246216/Create+AD+group
#>
function Create-CapaADGroup {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType,
		[Parameter(Mandatory = $true)]
		[String]$LDAPPath,
		[Parameter(Mandatory = $true)]
		[String]$recursive
	)
	
	$value = $CapaSDK.CreateADGroup($GroupName, $UnitType, $LDAPPath, $recursive)
	return $value
}


<#
	.SYNOPSIS
		Returns the log for a unit package relation.
	
	.DESCRIPTION
		Returns the log for a unit package relation.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER UnitName
		The name of the unit.
	
	.PARAMETER UnitType
		The type of the unit. This can be either "Computer" or "User"
	
	.PARAMETER PackageName
		The name of the package.
	
	.PARAMETER PackageVersion
		The version of the package.
	
	.PARAMETER PackageType
		The type of the package, this can be either "Computer" or "User"
	
	.EXAMPLE
		PS C:\> Get-CapaLog -CapaSDK $CapaSDK -UnitName 'TestComputer' -UnitType 'Computer' -PackageName 'WinRaR' -PackageVersion '5.50' -PackageType 'Computer'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246920/Get+log
#>
function Get-CapaLog {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[String]$UnitType,
		[Parameter(Mandatory = $true)]
		[String]$PackageName,
		[Parameter(Mandatory = $true)]
		[String]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('1', '2', 'Computer', 'User')]
		[String]$PackageType
	)
	
	if ($PackageType -eq 'Computer') {
		$PackageType = '1'
	}
	if ($PackageType -eq 'User') {
		$PackageType = '2'
	}
	
	$value = $CapaSDK.GetLog($UnitName, $UnitType, $PackageName, $PackageVersion, $PackageType)
	return $value
}


<#
	.SYNOPSIS
		Gets the reinstall status for a unit.
	
	.DESCRIPTION
		Gets the reinstall status for a unit.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER UnitName
		The name of the unit.
	
	.PARAMETER UnitType
		The type of the unit. This can be either "Computer" or "User"
	
	.EXAMPLE
		Test-CapaReinstallStatus -CapaSDK $CapaSDK -UnitName 'TestComputer' -UnitType 'Computer'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247466/Get+reinstall+status
#>
function Get-CapaReinstallStatus {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		$UnitType
	)
	
	$value = $CapaSDK.GetReinstallStatus($UnitName, $UnitType)
	return $value
}


<#
	.SYNOPSIS
		Moves a device from its current Management Point to the specified Management Point. 
	
	.DESCRIPTION
		Moves a device from its current Management Point to the specified Management Point. If a Management Server is specified, the device will be linked to it.

All relations to the device in the old Management Point will be removed, including but not limited to packages, profiles, applications, groups, folders, primary user, user relations, management server.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER DeviceUUID
		The UUID of the device.
	
	.PARAMETER PointName
		The name of the Management Point the device should be moved to.
	
	.PARAMETER ManagementServerFQDN
		The name of the Management Server the device should be linked to. If an empty string is specified, the device will not be linked to a Management Server after the move.
	
	.EXAMPLE
		Move-CapaDeviceToPoint -CapaSDK $CapaSDK -DeviceUUID '12345678-1234-1234-1234-123456789012' -PointName 'TestManagementPoint' -ManagementServerFQDN 'TestManagementServer'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247640/Move+Device+To+Management+Point
#>
function Move-CapaDeviceToPoint {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		$DeviceUUID,
		[Parameter(Mandatory = $true)]
		$PointName,
		[Parameter(Mandatory = $true)]
		$ManagementServerFQDN
	)
	
	$value = $CapaSDK.MoveDeviceToPoint($DeviceUUID, $PointName, $ManagementServerFQDN)
	return $value
}


<#
	.SYNOPSIS
		Sets an action to restart an agent.
	
	.DESCRIPTION
		Sets an action to restart an agent.
		If a user is specified, the agent on the computers linked to the user will be restarted.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER UnitName
		The name of the unit.
	
	.PARAMETER UnitType
		The type of the unit. This can be either "Computer" or "User"
	
	.EXAMPLE
		Restart-CapaAgent -CapaSDK $CapaSDK -UnitName 'TestComputer' -UnitType 'Computer'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247696/Restart+Agent+using+SDK
#>
function Restart-CapaAgent {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('1', '2', 'Computer', 'User')]
		[String]$UnitType
	)
	
	if ($PackageType -eq 'Computer') {
		$PackageType = '1'
	}
	if ($PackageType -eq 'User') {
		$PackageType = '2'
	}
	
	$value = $CapaSDK.RestartAgent($UnitName, $UnitType)
	return $value
}


<#
	.SYNOPSIS
		Set a action to perform a Wake On LAN Request for the unit.	
	
	.DESCRIPTION
		Set a action to perform a Wake On LAN Request for the unit.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER UnitName
		The name of the unit.
	
	.EXAMPLE
		Set-CapaWakeOnLAN -CapaSDK $CapaSDK -UnitName 'TestComputer'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247774/Set+Wake+On+LAN
#>
function Set-CapaWakeOnLAN {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$UnitName
	)
	
	$value = $CapaSDK.SetWakeOnLAN($UnitName, '1')
	return $value
}


