<#
	.SYNOPSIS
		Set the label on a unit.

	.DESCRIPTION
		Set or update the label for an existing unit in CapaInstaller.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER UnitName
		The name of the unit.

	.PARAMETER UnitType
		The unit type.

	.PARAMETER Label
		The label value to set.

	.EXAMPLE
		PS C:\> Set-CapaUnitLabel -CapaSDK $CapaSDK -UnitName 'PC001' -UnitType Computer -Label 'Production'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247732/Set+unit+label
#>
function Set-CapaUnitLabel {
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$Label
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'SetUnitLabel')) {
		throw 'CapaSDK does not contain method SetUnitLabel.'
	}

	$target = "$UnitType unit '$UnitName'"
	$action = "Set label to '$Label'"
	if ($PSCmdlet.ShouldProcess($target, $action)) {
		$value = $CapaSDK.SetUnitLabel($UnitName, $UnitType, $Label)
		return $value
	}
}
