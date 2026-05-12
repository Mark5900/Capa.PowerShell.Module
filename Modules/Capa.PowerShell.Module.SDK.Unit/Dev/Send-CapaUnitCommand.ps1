<#
	.SYNOPSIS
		Send a command to a unit.

	.DESCRIPTION
		Send a unit command to an existing device in CapaInstaller.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER DeviceUUID
		The UUID of the device.

	.PARAMETER Command
		The command to send to the device.

	.PARAMETER ChangelogComment
		Changelog comment for the action.

	.EXAMPLE
		PS C:\> Send-CapaUnitCommand -CapaSDK $CapaSDK -DeviceUUID '12345678-1234-1234-1234-123456789012' -Command SWInventory -ChangelogComment 'Run inventory from PowerShell'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247704/Send+Unit+Command
#>
function Send-CapaUnitCommand {
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
		[ValidateSet('SWInventory', 'HWInventory', 'SecInventory', 'ManagedSoftwareInventory', 'RestartDevice', 'ShutdownDevice', 'Lock', 'PasswordReset', 'Wipe')]
		[String]$Command,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$ChangelogComment
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'SendUnitCommand')) {
		throw 'CapaSDK does not contain method SendUnitCommand.'
	}

	$target = "Device '$DeviceUUID'"
	$action = "Send command '$Command'"
	if ($PSCmdlet.ShouldProcess($target, $action)) {
		$value = $CapaSDK.SendUnitCommand($DeviceUUID, $Command, $ChangelogComment)
		return $value
	}
}
