# TODO: Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247286/Add+printer+to+unit

	.DESCRIPTION
		A detailed description of the Add-CapaPrinterToUnit function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName  parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.PARAMETER PrinterShareName
		A description of the PrinterShareName  parameter.

	.EXAMPLE
				PS C:\> Add-CapaPrinterToUnit -CapaSDK $value1 -UnitName  'Value2' -UnitType Computer -PrinterShareName  'Value4'

	.NOTES
		Additional information about the function.
#>
function Add-CapaPrinterToUnit {
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
		[String]$PrinterShareName
	)

	$value = $CapaSDK.AddPrinterToUnit($UnitName, $UnitType, $PrinterShareName)
	return $value
}
