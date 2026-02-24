<#
	.SYNOPSIS
		Creates a unit.

	.DESCRIPTION
		Creates a unit in CapaInstaller by calling the CapaSDK method CreateUnit.
		Supports creating both basic units and device-specific units.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to create.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.PARAMETER LinkToManagementServerID
		Management server ID to link the unit to.

	.PARAMETER Status
		Status of the unit. Valid values are Active and Inactive.

	.PARAMETER Uuid
		Optional UUID used when UnitDeviceType is specified.

	.PARAMETER SerialNumber
		Optional serial number used when UnitDeviceType is specified.

	.PARAMETER UnitDeviceType
		Optional device type. When specified, the extended CreateUnit overload is used.

	.EXAMPLE
		PS C:\> Create-CapaUnit -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer -LinkToManagementServerID 2

		Creates a computer unit named PC-01 linked to management server ID 2.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247364/Create+unit
#>
function Create-CapaUnit {
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType,
		[Parameter(Mandatory = $true)]
		[ValidateRange(1, [int]::MaxValue)]
		[int]$LinkToManagementServerID,
		[Parameter(Mandatory = $false)]
		[ValidateSet('Active', 'Inactive')]
		[String]$Status = 'Active',
		[ValidatePattern('^$|^[0-9a-fA-F-]{36}$')]
		[String]$Uuid = '',
		[String]$SerialNumber = '',
		[ValidateSet('Windows', 'OSX', 'iOS', 'Android', 'WindowsPhone')]
		[String]$UnitDeviceType = ''
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'CreateUnit')) {
		throw 'CapaSDK does not contain method CreateUnit.'
	}

	$target = "$UnitType unit '$UnitName'"
	$action = "Create unit linked to management server ID $LinkToManagementServerID"
	if (-not $PSCmdlet.ShouldProcess($target, $action)) {
		return
	}

	if ($UnitDeviceType -eq '') {
		$value = $CapaSDK.CreateUnit($UnitName, $UnitType, $LinkToManagementServerID, $Status)
	} else {
		$value = $CapaSDK.CreateUnit($UnitName, $UnitType, $LinkToManagementServerID, $Status, $Uuid, $SerialNumber, $UnitDeviceType)
	}

	return $value
}
