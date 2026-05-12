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
