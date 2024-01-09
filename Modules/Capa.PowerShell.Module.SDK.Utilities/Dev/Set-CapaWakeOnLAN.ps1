# TODO: #245 Update and add tests

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
