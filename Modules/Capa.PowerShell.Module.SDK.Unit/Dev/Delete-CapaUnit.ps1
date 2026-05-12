<#
	.SYNOPSIS
		Deletes a unit.

	.DESCRIPTION
		Deletes an existing unit in CapaInstaller by calling the CapaSDK method
		DeleteUnit.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to delete.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.EXAMPLE
		PS C:\> Delete-CapaUnit -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer -Confirm:$false

		Deletes unit PC-01.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247372/Delete+unit
#>
function Delete-CapaUnit {
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
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
		[String]$UnitType
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'DeleteUnit')) {
		throw 'CapaSDK does not contain method DeleteUnit.'
	}

	$target = "$UnitType unit '$UnitName'"
	$action = 'Delete unit'
	if (-not $PSCmdlet.ShouldProcess($target, $action)) {
		return
	}

	$value = $CapaSDK.DeleteUnit($UnitName, $UnitType)
	return $value
}
