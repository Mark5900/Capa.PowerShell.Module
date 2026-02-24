<#
	.SYNOPSIS
		Adds a unit to a business unit.

	.DESCRIPTION
		Adds the specified unit to the specified business unit by calling the
		CapaSDK method AddUnitToBusinessUnit.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to add.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.PARAMETER BusinessUnit
		Name of the business unit.

	.EXAMPLE
		PS C:\> Add-CapaUnitToBusinessUnit -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer -BusinessUnit 'TestBU'

		Adds PC-01 to TestBU.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247294/Add+unit+to+business+unit
#>
function Add-CapaUnitToBusinessUnit {
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
		[ValidateSet('Computer', 'User')]
		[string]$UnitType,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$BusinessUnit
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'AddUnitToBusinessUnit')) {
		throw 'CapaSDK does not contain method AddUnitToBusinessUnit.'
	}

	$target = "$UnitType unit '$UnitName'"
	$action = "Add to business unit '$BusinessUnit'"
	if (-not $PSCmdlet.ShouldProcess($target, $action)) {
		return
	}

	$value = $CapaSDK.AddUnitToBusinessUnit($UnitName, $UnitType, $BusinessUnit)

	return $value
}
