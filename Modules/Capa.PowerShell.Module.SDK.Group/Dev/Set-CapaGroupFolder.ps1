# TODO: Update and add tests

<#
	.SYNOPSIS
		Sets the folder structure of a group.

	.DESCRIPTION
		Sets the folder structure of a group, either in a business unit or global.

	.PARAMETER CapaSDK
		CapaSDK object.

	.PARAMETER GroupName
		The name of the group.

	.PARAMETER GroupType
		The type of the group, either Dynamic_ADSI, Calendar, Department, Dynamic_SQL or Static.

	.PARAMETER FolderStructure
		The folder structure example: "Folder1\Folder2\Folder3".

	.EXAMPLE
		PS C:\> Set-CapaGroupFolder -CapaSDK $CapaSDK -GroupName "Lenovo" -GroupType Static -FolderStructure  "Static\Manufacturers"

	.EXAMPLE
		PS C:\> Set-CapaGroupFolder -CapaSDK $CapaSDK -GroupName "Lenovo" -GroupType Static -FolderStructure  "Static\Manufacturers" -BusinessunitName "Test"

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246318/Set+Group+Folder
		And https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246326/Set+Group+folder+in+a+Business+Unit
#>
function Set-CapaGroupFolder {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Dynamic_ADSI', 'Department', 'Dynamic_SQL', 'Static')]
		$GroupType,
		[Parameter(Mandatory = $true)]
		$FolderStructure,
		[string]$BusinessunitName = ''
	)

	if ($BusinessunitName -eq '') {
		$value = $CapaSDK.SetGroupFolder($GroupName, $GroupType, $FolderStructure)
	} else {
		$value = $CapaSDK.SetGroupFolderBU($GroupName, $GroupType, $FolderStructure, $BusinessunitName)
	}

	return $value
}
