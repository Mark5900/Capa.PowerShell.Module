<#
	.SYNOPSIS
		Rename an existing unit.

	.DESCRIPTION
		Rename an existing unit in CapaInstaller.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER CurrentUnitName
		The current unit name.

	.PARAMETER UnitType
		The unit type.

	.PARAMETER NewUnitName
		The new unit name.

	.EXAMPLE
		PS C:\> Rename-CapaUnit -CapaSDK $CapaSDK -CurrentUnitName 'PC001' -UnitType Computer -NewUnitName 'PC001-RENAMED'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247688/Rename+unit
#>
function Rename-CapaUnit {
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]
		$CurrentUnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]
		$UnitType,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]
		$NewUnitName
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'RenameUnit')) {
		throw 'CapaSDK does not contain method RenameUnit.'
	}

	$target = "$UnitType unit '$CurrentUnitName'"
	$action = "Rename to '$NewUnitName'"
	if ($PSCmdlet.ShouldProcess($target, $action)) {
		$value = $CapaSDK.RenameUnit($CurrentUnitName, $UnitType, $NewUnitName)
		return $value
	}
}
