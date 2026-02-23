<#
	.SYNOPSIS
		Set the name of a unit.

	.DESCRIPTION
		Set a new name on an existing unit in CapaInstaller.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER UnitName
		The current unit name.

	.PARAMETER UnitType
		The unit type.

	.PARAMETER Name
		The new unit name.

	.EXAMPLE
		PS C:\> Set-CapaUnitName -CapaSDK $CapaSDK -UnitName 'PC001' -UnitType Computer -Name 'PC001-RENAMED'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247740/Set+unit+name
#>
function Set-CapaUnitName {
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
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
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$Name
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'SetUnitName')) {
		throw 'CapaSDK does not contain method SetUnitName.'
	}

	$target = "$UnitType unit '$UnitName'"
	$action = "Set name to '$Name'"
	if ($PSCmdlet.ShouldProcess($target, $action)) {
		$value = $CapaSDK.SetUnitName($UnitName, $UnitType, $Name)
		return $value
	}
}
