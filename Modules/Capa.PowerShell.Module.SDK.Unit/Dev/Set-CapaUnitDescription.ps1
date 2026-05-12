<#
	.SYNOPSIS
		Set the description on a unit.

	.DESCRIPTION
		Set or update description for an existing unit in CapaInstaller.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER UnitName
		The name of the unit.

	.PARAMETER UnitType
		The unit type.

	.PARAMETER Description
		The description value to set. Leave empty string to clear description.

	.EXAMPLE
		PS C:\> Set-CapaUnitDescription -CapaSDK $CapaSDK -UnitName 'PC001' -UnitType Computer -Description 'Production workstation'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247724/Set+unit+description
#>
function Set-CapaUnitDescription {
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType,
		[String]$Description = ''
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'SetUnitDescription')) {
		throw 'CapaSDK does not contain method SetUnitDescription.'
	}

	$target = "$UnitType unit '$UnitName'"
	$action = "Set description"
	if ($PSCmdlet.ShouldProcess($target, $action)) {
		$value = $CapaSDK.SetUnitDescription($UnitName, $UnitType, $Description)
		return $value
	}
}
