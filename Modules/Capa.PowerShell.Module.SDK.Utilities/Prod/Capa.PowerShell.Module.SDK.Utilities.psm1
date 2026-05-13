
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
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$LDAPPath,
		[Parameter(Mandatory = $true)]
		[ValidateSet('true', 'false')]
		[String]$recursive
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'CreateADGroup')) {
		throw 'CapaSDK does not contain method CreateADGroup.'
	}

	$recursiveValue = $recursive.ToLowerInvariant()

	if ($PSCmdlet.ShouldProcess($GroupName, "Create AD group of type '$UnitType'")) {
		$value = $CapaSDK.CreateADGroup($GroupName, $UnitType, $LDAPPath, $recursiveValue)
		return $value
	}
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
	[OutputType([object])]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$PackageName,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('1', '2', 'Computer', 'User')]
		[String]$PackageType
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'GetLog')) {
		throw 'CapaSDK does not contain method GetLog.'
	}

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
	[OutputType([object])]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'GetReinstallStatus')) {
		throw 'CapaSDK does not contain method GetReinstallStatus.'
	}

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
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[ValidatePattern('^[{(]?[0-9a-fA-F]{8}[-]?[0-9a-fA-F]{4}[-]?[0-9a-fA-F]{4}[-]?[0-9a-fA-F]{4}[-]?[0-9a-fA-F]{12}[)}]?$')]
		[String]$DeviceUUID,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$PointName,
		[Parameter(Mandatory = $true)]
		[AllowEmptyString()]
		[String]$ManagementServerFQDN
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'MoveDeviceToPoint')) {
		throw 'CapaSDK does not contain method MoveDeviceToPoint.'
	}

	if ($PSCmdlet.ShouldProcess($DeviceUUID, "Move device to management point '$PointName'")) {
		$value = $CapaSDK.MoveDeviceToPoint($DeviceUUID, $PointName, $ManagementServerFQDN)
		return $value
	}
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
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('1', '2', 'Computer', 'User')]
		[String]$UnitType
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'RestartAgent')) {
		throw 'CapaSDK does not contain method RestartAgent.'
	}

	if ($UnitType -eq 'Computer') {
		$UnitType = '1'
	}
	if ($UnitType -eq 'User') {
		$UnitType = '2'
	}

	if ($PSCmdlet.ShouldProcess($UnitName, 'Restart agent')) {
		$value = $CapaSDK.RestartAgent($UnitName, $UnitType)
		return $value
	}
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
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$UnitName
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'SetWakeOnLAN')) {
		throw 'CapaSDK does not contain method SetWakeOnLAN.'
	}

	if ($PSCmdlet.ShouldProcess($UnitName, 'Set Wake On LAN')) {
		$value = $CapaSDK.SetWakeOnLAN($UnitName, '1')
		return $value
	}
}


