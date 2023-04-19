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
