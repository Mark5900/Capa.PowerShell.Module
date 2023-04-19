<#
	.SYNOPSIS
		Get a groups description.
	
	.DESCRIPTION
		Returns a string with the description of the group.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER GroupName
		The name of the group.
	
	.PARAMETER GroupType
		The type of the group, either Dynamic_ADSI, Calendar, Department, Dynamic_SQL, Reinstall, Security or Static.
	
	.EXAMPLE
				PS C:\> Get-CapaGroupDescription -CapaSDK $CapaSDK -GroupName 'Default' -GroupType Static
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246264/Get+Group+Description
#>
function Get-CapaGroupDescription {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Dynamic_ADSI', 'Calendar', 'Department', 'Dynamic_SQL', 'Reinstall', 'Security', 'Static')]
		[String]$GroupType
	)
	
	$value = $CapaSDK.GetGroupDescription($GroupName, $GroupType)
	return $value
}
