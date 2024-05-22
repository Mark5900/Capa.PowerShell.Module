# TODO: #353 Update Get-Help for Get-PpCMSPackage
<#
	.SYNOPSIS
		Returns the specified package.

	.DESCRIPTION
		Returns the specified package, with the following data:
		- Serverdeploy
		- Platform
		- Dependendpackageid
		- Id
		- Name
		- Version
		- Type
		- Scheduleid
		- Ismandatory
		- Isinteractive
		- Synchronizepriority
		- Displayname
		- Description
		- Capapackid
		- Capapackupdate
		- Capapackupdates
		- Capapackappid
		- Capapackdateadded
		- Isinventorypackage
		- Iscapapack
		- Iscapapackandcanbeupdated
		- Priority
		- Icon
		- Cmpid
		- Release
		- Script
		- Swiid
		- Inactiveperiod
		- Hasinstallscript
		- Hasuninstallscript
		- Haspostscript
		- Hasuserconfigurationscript
		- Devicetypeid
		- Devicetype
		- Advertisementtag
		- Ispowerpack
		- Installscriptcontent
		- Uninstallscriptcontent
		- Postscriptcontent
		- Userconfigscriptcontent
		- Linkedunitcount
		- Linkedgroupcount
		- Folderid
		- Folderpath
		- Statuscancelledcount
		- Statusinstallingcount
		- Statusfailedcount
		- Statusuninstallcount
		- Statuswaitingcount
		- Scheduleactive
		- Guid
		- Objecttype

	.PARAMETER PackageName
		The name of the package to get.

	.PARAMETER PackageVersion
		The version of the package to get.

	.EXAMPLE
		$package = Get-PpCMSPackage -PackageName "MyPackage" -PackageVersion "1.0.0"
		if ($package) {
			Job_WriteLog -Text "Package found."
		} else {
			Job_WriteLog -Text "Package not found."
		}
#>
function Get-PpCMSPackage {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion
	)
	return CMS_GetPackage -package $PackageName -version $PackageVersion
}