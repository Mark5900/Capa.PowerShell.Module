<#
	.SYNOPSIS
		Adds a printer to a unit.

	.DESCRIPTION
		Adds the specified printer share to the specified unit by calling the
		CapaSDK method AddPrinterToUnit.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to add the printer to.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.PARAMETER PrinterShareName
		Printer share name.

	.EXAMPLE
		PS C:\> Add-CapaPrinterToUnit -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer -PrinterShareName '\\PRINT01\\Office-Color'

		Adds printer share \\PRINT01\\Office-Color to PC-01.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247286/Add+printer+to+unit
#>
function Add-CapaPrinterToUnit {
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
		[String]$PrinterShareName
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'AddPrinterToUnit')) {
		throw 'CapaSDK does not contain method AddPrinterToUnit.'
	}

	$target = "$UnitType unit '$UnitName'"
	$action = "Add printer share '$PrinterShareName'"
	if (-not $PSCmdlet.ShouldProcess($target, $action)) {
		return
	}

	$value = $CapaSDK.AddPrinterToUnit($UnitName, $UnitType, $PrinterShareName)
	return $value
}
