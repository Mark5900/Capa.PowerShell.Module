<#
	.SYNOPSIS
		Remove a unit from a calendar group.

	.DESCRIPTION
		Remove an existing unit from a calendar group in CapaInstaller.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER UnitName
		The unit name.

	.PARAMETER UnitType
		The unit type.

	.PARAMETER CalendarGroupName
		The calendar group name.

	.EXAMPLE
		PS C:\> Remove-CapaUnitFromCalendarGroup -CapaSDK $CapaSDK -UnitName 'PC001' -UnitType Computer -CalendarGroupName 'Workstations - Nightly'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247656/Remove+unit+from+calendar+group
#>
function Remove-CapaUnitFromCalendarGroup {
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
		[ValidateSet('Computer', 'User')]
		[String]$UnitType,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$CalendarGroupName
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'RemoveUnitFromCalendarGroup')) {
		throw 'CapaSDK does not contain method RemoveUnitFromCalendarGroup.'
	}

	$target = "$UnitType unit '$UnitName'"
	$action = "Remove from calendar group '$CalendarGroupName'"
	if ($PSCmdlet.ShouldProcess($target, $action)) {
		$value = $CapaSDK.RemoveUnitFromCalendarGroup($UnitName, $UnitType, $CalendarGroupName)
		return $value
	}
}
