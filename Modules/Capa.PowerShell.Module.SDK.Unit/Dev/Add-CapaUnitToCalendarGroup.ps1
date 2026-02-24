<#
	.SYNOPSIS
		Adds a unit to a calendar group.

	.DESCRIPTION
		Adds the specified unit to the specified calendar group by calling the
		CapaSDK method AddUnitToCalendarGroup.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to add.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.PARAMETER CalendarGroupName
		Name of the calendar group.

	.EXAMPLE
		PS C:\> Add-CapaUnitToCalendarGroup -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer -CalendarGroupName 'Nightly Window'

		Adds PC-01 to the calendar group Nightly Window.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247302/Add+unit+to+calendar+group
#>
function Add-CapaUnitToCalendarGroup {
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
		[ValidateNotNullOrEmpty()]
		[String]$CalendarGroupName
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'AddUnitToCalendarGroup')) {
		throw 'CapaSDK does not contain method AddUnitToCalendarGroup.'
	}

	$target = "$UnitType unit '$UnitName'"
	$action = "Add to calendar group '$CalendarGroupName'"
	if (-not $PSCmdlet.ShouldProcess($target, $action)) {
		return
	}

	$value = $CapaSDK.AddUnitToCalendarGroup($UnitName, $UnitType, $CalendarGroupName)
	return $value
}
