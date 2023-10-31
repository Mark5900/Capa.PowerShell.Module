# TODO: Update and add tests

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
