# TODO: #115 Update and add tests

<#
	.SYNOPSIS
		Gets the folder structure of a group.

	.DESCRIPTION
		Returns a string with the folder structure of a group.
		Someting like: "Folder1\Folder2".

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER GroupName
		The name of the group.

	.PARAMETER GroupType
		The type of the group, either Dynamic_ADSI, Department, Dynamic_SQL or Static.

	.EXAMPLE
		PS C:\> Get-CapaGroupFolder -CapaSDK $CapaSDK -GroupName 'Default' -GroupType Dynamic_ADSI

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI67DOC/pages/20342580985/Get+Group+Folder
#>
function Get-CapaGroupFolder {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Dynamic_ADSI', 'Department', 'Dynamic_SQL', 'Static')]
		[String]$GroupType
	)

	$value = $CapaSDK.GetGroupFolder($GroupName, $GroupType)
	return $value
}
