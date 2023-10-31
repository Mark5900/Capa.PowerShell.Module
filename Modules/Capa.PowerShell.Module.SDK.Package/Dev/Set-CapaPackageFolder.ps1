# TODO: Update and add tests

<#
	.SYNOPSIS
		Set the folder structure of a package.

	.DESCRIPTION
		Set the folder structure of a package.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER PackageType
		The type of package to set the folder structure of, either Computer or User.

	.PARAMETER PackageName
		The name of the package to set the folder structure of.

	.PARAMETER PackageVersion
		The version of the package to set the folder structure of.

	.PARAMETER FolderStructure
		The folder structure to set, for example 'Folder1\Folder2'.

	.PARAMETER ChangelogText
		An optional changelog text to set.

	.EXAMPLE
				PS C:\> Set-CapaPackageFolder -CapaSDK $CapaSDK -PackageType 'Computer' -PackageName 'Winrar' -PackageVersion '5.50' -FolderStructure 'Folder1\Folder2' -ChangelogText 'This is a changelog'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247032/Set+Package+Folder
#>
function Set-CapaPackageFolder {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$PackageType,
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[string]$FolderStructure,
		[string]$ChangelogText
	)

	$bool = $CapaSDK.SetPackageFolder($PackageName, $PackageVersion, $PackageType, $FolderStructure, $ChangelogText)

	Return $bool
}
