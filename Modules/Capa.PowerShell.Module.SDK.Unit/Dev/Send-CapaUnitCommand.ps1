<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247704/Send+Unit+Command
	
	.DESCRIPTION
		A detailed description of the Send-CapaUnitCommand function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER DeviceUUID
		A description of the DeviceUUID  parameter.
	
	.PARAMETER Command
		A description of the Command parameter.
	
	.PARAMETER ChangelogComment
		A description of the ChangelogComment  parameter.
	
	.EXAMPLE
				PS C:\> Send-CapaUnitCommand -CapaSDK $value1 -DeviceUUID  'Value2' -Command SWInventory -ChangelogComment  'Value4'
	
	.NOTES
		Additional information about the function.
#>
function Send-CapaUnitCommand
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$DeviceUUID,
		[Parameter(Mandatory = $true)]
		[ValidateSet('SWInventory', 'HWInventory', 'SecInventory', 'ManagedSoftwareInventory', 'RestartDevice', 'ShutdownDevice', 'Lock', 'PasswordReset', 'Wipe')]
		[String]$Command,
		[Parameter(Mandatory = $true)]
		[String]$ChangelogComment
	)
	
	$value = $CapaSDK.SendUnitCommand($DeviceUUID, $Command, $ChangelogComment)
	return $value
}
