# TODO: #176 Update and add tests

<#
	.SYNOPSIS
		Imports a package into CapaInstaller.

	.DESCRIPTION
		Imports a package into CapaInstaller.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER FilePath
		Specifies the path to the zip file containing the package.

	.PARAMETER OverrideCIPCdata
		If the zip file contains metadata used by the Package Creator, setting this to true will override these metadata if any already exists in the CMS database.

	.PARAMETER ImportFolderStructure
		Determines wether or not the folder structure will be imported from the exported package.
		If this is true, the package will be placed in the folder it was located in, when it was exported. Any folders in that structure that doesn't already exist, will be created in CMS.

	.PARAMETER ImportSchedule
		Determines wether or not the schedule will be imported from the package.

	.PARAMETER ChangelogComment
		An optional comment to add to the changelog.

	.EXAMPLE
				PS C:\> Import-CapaPackage -CapaSDK $value1 -FilePath 'C:\Temp\Package.zip' -OverrideCIPCdata $true -ImportFolderStructure $true -ImportSchedule $true

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246984/Import+package
#>
function Import-CapaPackage {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$FilePath,
		[Parameter(Mandatory = $true)]
		[bool]$OverrideCIPCdata,
		[Parameter(Mandatory = $true)]
		[bool]$ImportFolderStructure,
		[Parameter(Mandatory = $true)]
		[bool]$ImportSchedule,
		[String]$ChangelogComment = ''
	)

	$value = $CapaSDK.ImportPackage($FilePath, $OverrideCIPCdata, $ImportFolderStructure, $ImportSchedule, $ChangelogComment)
	return $value
}
