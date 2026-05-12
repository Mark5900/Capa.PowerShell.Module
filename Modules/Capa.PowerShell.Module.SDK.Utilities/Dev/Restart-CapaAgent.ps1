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
