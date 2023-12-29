# TODO: #199 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247302/Add+unit+to+calendar+group

	.DESCRIPTION
		A detailed description of the Add-CapaUnitToCalendarGroup function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName  parameter.

	.PARAMETER UnitType
		A description of the UnitType  parameter.

	.PARAMETER CalendarGroupName
		A description of the CalendarGroupName parameter.

	.EXAMPLE
				PS C:\> Add-CapaUnitToCalendarGroup -CapaSDK $value1 -UnitName  'Value2' -UnitType  'Value3' -CalendarGroupName 'Value4'

	.NOTES
		Additional information about the function.
#>
function Add-CapaUnitToCalendarGroup {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[String]$UnitType,
		[Parameter(Mandatory = $true)]
		[String]$CalendarGroupName
	)

	$value = $CapaSDK.AddUnitToCalendarGroup($UnitName, $UnitType, $CalendarGroupName)
	return $value
}
