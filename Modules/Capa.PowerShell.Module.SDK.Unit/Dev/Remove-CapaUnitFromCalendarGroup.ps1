# TODO: #226 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247656/Remove+unit+from+calendar+group

	.DESCRIPTION
		A detailed description of the Remove-CapaUnitFromCalendarGroup function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.PARAMETER CalendarGroupName
		A description of the CalendarGroupName parameter.

	.EXAMPLE
				PS C:\> Remove-CapaUnitFromCalendarGroup -CapaSDK $value1 -UnitName 'Value2' -UnitType Computer -CalendarGroupName 'Value4'

	.NOTES
		Additional information about the function.
#>
function Remove-CapaUnitFromCalendarGroup {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType,
		[Parameter(Mandatory = $true)]
		[String]$CalendarGroupName
	)

	$value = $CapaSDK.RemoveUnitFromCalendarGroup($UnitName, $UnitType, $CalendarGroupName)
	return $value
}
