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
