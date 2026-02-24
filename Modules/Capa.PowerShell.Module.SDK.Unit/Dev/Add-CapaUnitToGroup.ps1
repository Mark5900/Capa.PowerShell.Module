<#
	.SYNOPSIS
		Adds a unit to a group.

	.DESCRIPTION
		Adds the specified unit to the specified group by calling AddUnitToGroup
		or AddUnitToGroupBU on the CapaSDK instance.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to add to the group.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer, User, and Printer.

	.PARAMETER GroupName
		Name of the group.

	.PARAMETER GroupType
		Type of group. Dynamic_SQL and Dynamic_ADSI are only valid for Printer units.

	.PARAMETER BusinessUnitName
		Optional business unit name. When specified, AddUnitToGroupBU is used.

	.EXAMPLE
		PS C:\> Add-CapaUnitToGroup -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer -GroupName 'Workstations' -GroupType Static

		Adds PC-01 to the Workstations static group.

	.EXAMPLE
		PS C:\> Add-CapaUnitToGroup -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer -GroupName 'HQ Devices' -GroupType Static -BusinessUnitName 'Headquarters'

		Adds PC-01 to the group in the specified business unit.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247318/Add+unit+to+group
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247332/Add+unit+to+group+BU
#>
function Add-CapaUnitToGroup {
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User', 'Printer')]
		[string]$UnitType,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Calendar', 'Department', 'Reinstall', 'Security', 'Static', 'Dynamic_SQL', 'Dynamic_ADSI')]
		[string]$GroupType,
		[ValidateNotNullOrEmpty()]
		[String]$BusinessUnitName
	)

	if (($GroupType -eq 'Dynamic_SQL' -or $GroupType -eq 'Dynamic_ADSI') -and $UnitType -ne 'Printer') {
		throw "GroupType '$GroupType' only supports UnitType 'Printer'."
	}

	$usingBusinessUnit = -not [string]::IsNullOrEmpty($BusinessUnitName)
	if ($usingBusinessUnit) {
		if (-not ($CapaSDK.PSObject.Methods.Name -contains 'AddUnitToGroupBU')) {
			throw 'CapaSDK does not contain method AddUnitToGroupBU.'
		}
	}
	else {
		if (-not ($CapaSDK.PSObject.Methods.Name -contains 'AddUnitToGroup')) {
			throw 'CapaSDK does not contain method AddUnitToGroup.'
		}
	}

	$target = "$UnitType unit '$UnitName'"
	$action = if ($usingBusinessUnit) {
		"Add to group '$GroupName' ($GroupType) in business unit '$BusinessUnitName'"
	}
	else {
		"Add to group '$GroupName' ($GroupType)"
	}

	if (-not $PSCmdlet.ShouldProcess($target, $action)) {
		return
	}

	if ($usingBusinessUnit) {
		$value = $CapaSDK.AddUnitToGroupBU($UnitName, $UnitType, $GroupName, $GroupType, $BusinessUnitName)
	}
	else {
		$value = $CapaSDK.AddUnitToGroup($UnitName, $UnitType, $GroupName, $GroupType)
	}

	return $value
}
