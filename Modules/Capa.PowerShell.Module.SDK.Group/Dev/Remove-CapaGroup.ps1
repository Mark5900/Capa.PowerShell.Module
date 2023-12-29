# TODO: #120 Update and add tests

<#
	.SYNOPSIS
		Removes a group.

	.DESCRIPTION
		Removes a group either from a business unit or from global.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER GroupName
		The name of the group.

	.PARAMETER GroupType
		The type of the group, either Dynamic_ADSI, Calendar, Department, Dynamic_SQL, Reinstall, Security or Static.

	.PARAMETER UnitType
		The type of the unit in the group, either Computer or User.

	.PARAMETER BusinessUnit
		If specified, the group will be removed in this business unit.

	.EXAMPLE
				PS C:\> Remove-CapaGroup -CapaSDK $CapaSDK -GroupName 'Lenovo' -GroupType Static -UnitType Computer

	.EXAMPLE
				PS C:\> Remove-CapaGroup -CapaSDK $CapaSDK -GroupName 'Lenovo' -GroupType Static -UnitType Computer -BusinessUnit 'Test'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246240/Delete+group
		And https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246248/Delete+Group+in+Business+Unit
#>
function Remove-CapaGroup {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Dynamic_ADSI', 'Calendar', 'Department', 'Dynamic_SQL', 'Reinstall', 'Security', 'Static')]
		[string]$GroupType,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType,
		[String]$BusinessUnit = ''
	)

	if ($BusinessUnit -eq '') {
		$value = $CapaSDK.DeleteGroup($GroupName, $GroupType, $UnitType)
	} else {
		$value = $CapaSDK.DeleteGroupInBusinessUnit($GroupName, $GroupType, $UnitType, $BusinessUnit)
	}

	Return $value
}
