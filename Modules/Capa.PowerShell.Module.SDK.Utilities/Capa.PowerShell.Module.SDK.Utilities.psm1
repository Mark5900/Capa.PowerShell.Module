<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246216/Create+AD+group
	
	.DESCRIPTION
		A detailed description of the Create-CapaADGroup function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER GroupName
		A description of the GroupName parameter.
	
	.PARAMETER UnitType
		A description of the UnitType parameter.
	
	.PARAMETER LDAPPath
		A description of the LDAPPath parameter.
	
	.PARAMETER recursive
		A description of the recursive parameter.
	
	.EXAMPLE
				PS C:\> Create-CapaADGroup -CapaSDK $value1 -GroupName 'Value2' -UnitType Computer -LDAPPath 'Value4' -recursive 'Value5'
	
	.NOTES
		Additional information about the function.
#>
function Create-CapaADGroup
{
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
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246920/Get+log
	
	.DESCRIPTION
		A detailed description of the Get-CapaLog function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER UnitName
		A description of the UnitName parameter.
	
	.PARAMETER UnitType
		A description of the UnitType parameter.
	
	.PARAMETER PackageName
		A description of the PackageName parameter.
	
	.PARAMETER PackageVersion
		A description of the PackageVersion parameter.
	
	.PARAMETER PackageType
		A description of the PackageType parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaLog -CapaSDK $value1 -UnitName 'Value2' -UnitType 'Value3' -PackageName 'Value4' -PackageVersion 'Value5' -PackageType 1
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaLog
{
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
	
	if ($PackageType -eq 'Computer')
	{
		$PackageType = '1'
	}
	if ($PackageType -eq 'User')
	{
		$PackageType = '2'
	}
	
	$value = $CapaSDK.GetLog($UnitName, $UnitType, $PackageName, $PackageVersion, $PackageType)
	return $value
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247466/Get+reinstall+status
	
	.DESCRIPTION
		A detailed description of the Get-CapaReinstallStatus function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER UnitName
		A description of the UnitName parameter.
	
	.PARAMETER UnitType
		A description of the UnitType parameter.
	
	.EXAMPLE
		PS C:\> Get-CapaReinstallStatus
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaReinstallStatus
{
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
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247640/Move+Device+To+Management+Point
	
	.DESCRIPTION
		A detailed description of the Move-CapaDeviceToPoint function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER DeviceUUID
		A description of the DeviceUUID  parameter.
	
	.PARAMETER PointName
		A description of the PointName  parameter.
	
	.PARAMETER ManagementServerFQDN
		A description of the ManagementServerFQDN  parameter.
	
	.EXAMPLE
				PS C:\> Move-CapaDeviceToPoint -CapaSDK $value1 -DeviceUUID  $value2 -PointName  $value3 -ManagementServerFQDN  $value4
	
	.NOTES
		Additional information about the function.
#>
function Move-CapaDeviceToPoint
{
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
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247696/Restart+Agent+using+SDK
	
	.DESCRIPTION
		A detailed description of the Restart-CapaAgent function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER UnitName
		A description of the UnitName parameter.
	
	.PARAMETER UnitType
		A description of the UnitType parameter.
	
	.EXAMPLE
				PS C:\> Restart-CapaAgent -CapaSDK $value1 -UnitName 'Value2' -UnitType 'Value3'
	
	.NOTES
		Additional information about the function.
#>
function Restart-CapaAgent
{
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
	
	if ($PackageType -eq 'Computer')
	{
		$PackageType = '1'
	}
	if ($PackageType -eq 'User')
	{
		$PackageType = '2'
	}
	
	$value = $CapaSDK.RestartAgent($UnitName, $UnitType)
	return $value
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247774/Set+Wake+On+LAN
	
	.DESCRIPTION
		A detailed description of the Set-CapaWakeOnLAN function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER UnitName
		A description of the UnitName  parameter.
	
	.EXAMPLE
				PS C:\> Set-CapaWakeOnLAN -CapaSDK $value1 -UnitName  'Value2'
	
	.NOTES
		Additional information about the function.
#>
function Set-CapaWakeOnLAN
{
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