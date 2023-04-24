<#
	.SYNOPSIS
		Set a group description.
	
	.DESCRIPTION
		Sets a group description.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER GroupName
		The name of the group.
	
	.PARAMETER GroupType
		The type of the group, either Dynamic_ADSI, Calendar, Department, Dynamic_SQL, Reinstall, Security or Static.
	
	.PARAMETER Description
		The description of the group.
	
	.EXAMPLE
				PS C:\> Set-CapaGroupDescription -CapaSDK $CapaSDK -GroupName 'Lenovo' -GroupType Static
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246310/Set+Group+Description
#>
function Set-CapaGroupDescription {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Dynamic_ADSI', 'Calendar', 'Department', 'Dynamic_SQL', 'Reinstall', 'Security', 'Static')]
		[String]$GroupType,
		[Parameter(Mandatory = $false)]
		[String]$Description = ''
	)
	
	$value = $CapaSDK.SetGroupDescription($GroupName, $GroupType, $Description)
	return $value
}
