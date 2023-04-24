<#
	.SYNOPSIS
		Create a group.
	
	.DESCRIPTION
		Create a group, either in global scope or in a business unit.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER GroupName
		The name of the group.
	
	.PARAMETER GroupType
		The type of the group, either Calendar, Department or Static.
	
	.PARAMETER UnitType
		The type of elements in the group, either Computer or User.

	.PARAMETER BusinessUnit
		The name of the business unit to create the group in, if not specified the group will be created in global scope.
	
	.EXAMPLE
		PS C:\> Create-CapaGroup -CapaSDK $CapaSDk -GroupName  'Jylland' -GroupType  Static -UnitType Computer

	.EXAMPLE
		PS C:\> Create-CapaGroup -CapaSDK $CapaSDk -GroupName  'Jylland' -GroupType  Static -UnitType Computer -BusinessUnit 'Denmark'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246224/Create+group
		And https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246232/Create+group+in+Business+Unit
#>
function Create-CapaGroup {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Calendar', 'Department', 'Static')]
		[string]$GroupType,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType,
		[string]$BusinessUnit = ''
	)
	
	if ($BusinessUnit -eq '') {
		$value = $CapaSDK.CreateGroup($GroupName, $GroupType, $UnitType)
	} else {
		$value = $CapaSDK.CreateGroupInBusinessUnit($GroupName, $GroupType, $UnitType, $BusinessUnit)
	}
	
	return $value
}
