<#
	.SYNOPSIS
		Remove a unit from a business unit.

	.DESCRIPTION
		Remove an existing unit from a business unit relation in CapaInstaller.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER UnitName
		The unit name.

	.PARAMETER UnitType
		The unit type.

	.EXAMPLE
		PS C:\> Remove-CapaUnitFromBusinessUnit -CapaSDK $CapaSDK -UnitName 'PC001' -UnitType Computer

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247648/Remove+unit+from+business+unit
#>
function Remove-CapaUnitFromBusinessUnit {
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
		[string]$UnitType
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'RemoveUnitFromBusinessUnit')) {
		throw 'CapaSDK does not contain method RemoveUnitFromBusinessUnit.'
	}

	$target = "$UnitType unit '$UnitName'"
	$action = 'Remove from business unit'
	if ($PSCmdlet.ShouldProcess($target, $action)) {
		$value = $CapaSDK.RemoveUnitFromBusinessUnit($UnitName, $UnitType)
		return $value
	}
}
