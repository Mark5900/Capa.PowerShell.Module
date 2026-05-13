<#
	.SYNOPSIS
		Set the folder structure of a package.

	.DESCRIPTION
		Set the folder structure of a package.
		Returns True if the folder structure was set, otherwise False.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER PackageName
		The name of the package to set the folder structure of.

	.PARAMETER PackageVersion
		The version of the package to set the folder structure of.

	.PARAMETER PackageType
		The type of package to set the folder structure of, either Computer or User.

	.PARAMETER PackageFolder
		The folder structure to set, for example 'Folder1\Folder2'.

	.PARAMETER ChangelogComment
		An optional changelog text to set.

	.EXAMPLE
				PS C:\> Set-CapaPackageFolder -CapaSDK $CapaSDK -PackageName 'Winrar' -PackageVersion '5.50' -PackageType 'Computer' -PackageFolder 'Folder1\Folder2' -ChangelogComment 'This is a changelog'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247032/Set+Package+Folder
#>
function Set-CapaPackageFolder {
	[CmdletBinding()]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$PackageType,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[Alias('FolderStructure')]
		[string]$PackageFolder,
		[Alias('ChangelogText')]
		[string]$ChangelogComment
	)

	$bool = $CapaSDK.SetPackageFolder($PackageName, $PackageVersion, $PackageType, $PackageFolder, $ChangelogComment)

	Return $bool
}
