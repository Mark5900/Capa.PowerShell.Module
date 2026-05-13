<#
	.SYNOPSIS
		Remove a unit from a group.

	.DESCRIPTION
		Remove an existing unit from a group in CapaInstaller.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER UnitName
		The unit name.

	.PARAMETER UnitType
		The unit type.

	.PARAMETER GroupName
		The group name.

	.PARAMETER GroupType
		The group type.

	.EXAMPLE
		PS C:\> Remove-CapaUnitFromGroup -CapaSDK $CapaSDK -UnitName 'PC001' -UnitType Computer -GroupName 'Test Group' -GroupType Static

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247664/Remove+unit+from+group
#>
function Remove-CapaUnitFromGroup {
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
		[string]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Dynamic_ADSI', 'Calendar', 'Department', 'Dynamic_SQL', 'Reinstall', 'Security', 'Static')]
		[string]$GroupType
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'RemoveUnitFromGroup')) {
		throw 'CapaSDK does not contain method RemoveUnitFromGroup.'
	}

	$target = "$UnitType unit '$UnitName'"
	$action = "Remove from group '$GroupName' ($GroupType)"
	if ($PSCmdlet.ShouldProcess($target, $action)) {
		$bool = $CapaSDK.RemoveUnitFromGroup($UnitName, $UnitType, $GroupName, $GroupType)
		return $bool
	}
}
