
# TODO: #314 Update Get-Help for Add-PpCMSComputerToCalendarGroup. Missing documentation for BU support.
<#
	.SYNOPSIS
		Adds the specified unit to the specified calendar group.

	.DESCRIPTION
		Adds the specified unit to the specified calendar group.

	.PARAMETER Group
		The name of the calendar group to add the unit to.

	.EXAMPLE
		$bStatus = Add-PpCMSComputerToCalendarGroup -Group "CapaInstaller"
		if ($bStatus) {
			Job_WriteLog -Text "Computer added to group."
		} else {
			Job_WriteLog -Text "Failed to add computer to group."
		}

	.NOTES
		https://capasystems.atlassian.net/wiki/spaces/CI66DOC/pages/19610726162/CMS+AddComputerToCalendarGroup
#>
function Add-PpCMSComputerToCalendarGroup {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$Group
	)
	return CMS_AddComputerToCalendarGroup -group $Group
}


# TODO: #317 Update Get-Help for Add-PpCMSComputerToDepartmentGroup, missing BU support description
<#
	.SYNOPSIS
		Adds a specified computer unit to a department group.

	.DESCRIPTION
		Adds a specified computer unit to a department group.

	.PARAMETER Group
		The name of the department group to which the computer unit should be added.

	.EXAMPLE
		$bStatus = Add-PpCMSComputerToDepartmentGroup -Group "MyDepartmentGroup"
		if ($bStatus) {
			Job_WriteLog -Text "Computer unit added to department group."
		} else {
			Job_WriteLog -Text "Failed to add computer unit to department group."
		}

	.NOTES
		https://capasystems.atlassian.net/wiki/spaces/CI66DOC/pages/19610726181/CMS+AddComputerToDepartmentGroup
#>
function Add-PpCMSComputerToDepartmentGroup {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$Group
	)
	return CMS_AddComputerToDepartmentGroup -group $Group
}


# TODO: #321 Update Get-Help for Add-PpCMSComputerToPowerSchemeGroup
<#
	.SYNOPSIS
		Adds a specified computer unit to a power scheme group.

	.DESCRIPTION
		Adds a specified computer unit to a power scheme group.

	.PARAMETER Group
		The name of the power scheme group to which the computer unit should be added.

	.EXAMPLE
		$bStatus = Add-PpCMSComputerToPowerSchemeGroup -Group "MyPowerSchemeGroup"
		if ($bStatus) {
			Job_WriteLog -Text "Computer unit added to power scheme group."
		} else {
			Job_WriteLog -Text "Failed to add computer unit to power scheme group."
		}

	.NOTES
		https://capasystems.atlassian.net/wiki/spaces/CI66DOC/pages/19610726200/CMS+AddComputerToPowerSchemeGroup
#>
function Add-PpCMSComputerToPowerSchemeGroup {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$Group
	)
	return CMS_AddComputerToPowerSchemeGroup -group $Group
}


# TODO: #325 Update Get-Help for Add-PpCMSComputerToReinstallGroup, missing BU support description
<#
	.SYNOPSIS
		Add a computer to a Reinstall Group.

	.DESCRIPTION
		Add a computer to a Reinstall Group.

	.PARAMETER Group
		The name of the Reinstall Group.

	.EXAMPLE
		$bStatus = Add-PpCMSComputerToReinstallGroup -Group "MyGroup"
		if ($bStatus) {
			Job_WriteLog -Text "Computer added to Reinstall Group."
		} else {
			Job_WriteLog -Text "Failed to add computer to Reinstall Group."
		}

	.NOTES
		https://capasystems.atlassian.net/wiki/spaces/CI66DOC/pages/19610726217/CMS+AddComputerToReinstallGroup
#>
function Add-PpCMSComputerToReinstallGroup {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$Group
	)
	return CMS_AddComputerToReinstallGroup -group $Group
}


# TODO: #309 Update Get-Help for Add-PpCMSComputerToStaticGroup. Missing documentation for BU support.
<#
	.SYNOPSIS
		Adds the specified unit to the specified static group.

	.DESCRIPTION
		Adds the specified unit to the specified static group.

	.PARAMETER Group
		The name of the static group to add the unit to.

	.EXAMPLE
		$bStatus = Add-PpCMSComputerToStaticGroup -Group "CapaInstaller"
		if ($bStatus) {
			Job_WriteLog -Text "Computer added to group."
		} else {
			Job_WriteLog -Text "Failed to add computer to group."
		}

	.NOTES
		https://capasystems.atlassian.net/wiki/spaces/CI66DOC/pages/19610726236/CMS+AddComputerToStaticGroup
#>
function Add-PpCMSComputerToStaticGroup {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$Group
	)
	return CMS_AddComputerToStaticGroup -group $Group
}


# TODO: #295 Update Get-Help CMS_AddCustomInventory
<#
	.SYNOPSIS
		Adds a custom inventory entry to the database.

	.DESCRIPTION
		Adds a persistent CustomInventory row to the database, meaning that the data will not be flushed out the next time that the CustomInventory package is run.

	.PARAMETER Category
		Category name

	.PARAMETER Entry
		Variable name

	.PARAMETER Value
		Value of the variable.
		If the ValueType is Time then the value should be epoch time, meaning the number of seconds since 1970-01-01 00:00:00 UTC.
		You can also set the Time at "" or "0" to set the current time.

	.PARAMETER ValueType
		Type of the value.
		Valid values are:
		- String
		- Integer
		- Time

	.EXAMPLE
		$bStatus = Add-PpCMSCustomInventory -Category "MyCategory" -Entry "MyEntry" -Value "MyValue" -ValueType "String"
		if ($bStatus) {
			Job_WriteLog -Text "Custom inventory added successfully."
		} else {
			Job_WriteLog -Text "Failed to add custom inventory."
		}

	.NOTES
		Please note, that this is an expensive call, seen from the Frontend/database perspective. Calling this function repeatedly from a package could result in overall slower performance. This function should be used with care.

		https://capasystems.atlassian.net/wiki/spaces/CI66DOC/pages/19610726255/CMS+AddCustomInventory
#>
function Add-PpCMSCustomInventory {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$Category,
		[Parameter(Mandatory = $true)]
		[string]$Entry,
		[Parameter(Mandatory = $true)]
		[string]$Value,
		[Parameter(Mandatory = $true)]
		[ValidateSet('String', 'Integer', 'Time')]
		[string]$ValueType
	)
	switch ($x) {
		String {
			$ValueTypeShort = 'S'
		}
		Integer {
			$ValueTypeShort = 'I'
		}
		Time {
			$ValueTypeShort = 'T'
		}
		Default {
			$ValueTypeShort = 'S'
		}
	}

	return CMS_AddCustomInventory -category $Category -entry $Entry -value $Value -valuetype $ValueTypeShort
}


# TODO: #301 Update Get-Help for Add-PpCMSHardwareInventory
<#
	.SYNOPSIS
		Adds a HardwareInventory row to the database that is persistent.

	.DESCRIPTION
		Adds a HardwareInventory row to the database that is persistent, meaning that the data will not be flushed out the next time that the HardwareInventory package is run.

	.PARAMETER Category
		Category name

	.PARAMETER Entry
		Variable name

	.PARAMETER Value
		Value of the variable.
		If the ValueType is Time then the value should be epoch time, meaning the number of seconds since 1970-01-01 00:00:00 UTC.
		You can also set the Time at "" or "0" to set the current time.

	.PARAMETER ValueType
		Type of the value.
		Valid values are:
		- String
		- Int
		- Time

	.EXAMPLE
		$bStatus = Add-PpCMSHardwareInventory -Category "MyCategory" -Entry "MyEntry" -Value "MyValue" -ValueType "String"
		if ($bStatus) {
			Job_WriteLog -Text "Hardware inventory added successfully."
		} else {
			Job_WriteLog -Text "Failed to add hardware inventory."
		}

	.NOTES
		https://capasystems.atlassian.net/wiki/spaces/CI66DOC/pages/19610726295/CMS+AddHardwareInventory
#>
function Add-PpCMSHardwareInventory {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$Category,
		[Parameter(Mandatory = $true)]
		[string]$Entry,
		[Parameter(Mandatory = $true)]
		[string]$Value,
		[Parameter(Mandatory = $true)]
		[ValidateSet('String', 'Int', 'Time')]
		[string]$ValueType
	)
	switch ($x) {
		'String' {
			$ValueTypeShort = 'S'
		}
		'Int' {
			$ValueTypeShort = 'I'
		}
		'Time' {
			$ValueTypeShort = 'T'
		}
		Default {
			$ValueTypeShort = 'S'
		}
	}

	return CMS_AddHardwareInventory -category $Category -entry $Entry -value $Value -valuetype $ValueTypeShort
}


# TODO: #329 Update Get-Help for Add-PpCMSPackageToUnit
<#
	.SYNOPSIS
		Adds the specified package to the unit on which the script is being executed

	.DESCRIPTION
		Adds the specified package to the unit on which the script is being executed

	.PARAMETER PackageName
		The name of the package to add to the unit

	.PARAMETER PackageVersion
		The version of the package to add to the unit

	.EXAMPLE
		$bStatus = Add-PpCMSPackageToUnit -PackageName "MyPackage" -PackageVersion "1.0.0"
		if ($bStatus) {
			Job_WriteLog -Text "Package added to unit."
		} else {
			Job_WriteLog -Text "Failed to add package to unit."
		}
#>
function Add-PpCMSPackageToUnit {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion
	)
	return CMS_AddPackageToUnit -package $PackageName -version $PackageVersion
}


# TODO: #341 Update Get-Help for Add-PpCMSUnitToBusinessUnit
<#
	.SYNOPSIS
		Adds the unit to the specified business unit

	.DESCRIPTION
		Adds the unit on which the script is executed to the specified Business Unit. UserJobs add user and ComputerJobs add the computer.

	.PARAMETER BusinessUnitName
		The name of the business unit to add the unit to

	.EXAMPLE
		$bStatus = Add-PpCMSUnitToBusinessUnit -BusinessUnitName "MyBusinessUnit"
		if ($bStatus) {
			Job_WriteLog -Text "Unit added to business unit."
		} else {
			Job_WriteLog -Text "Failed to add unit to business unit."
		}
#>
function Add-PpCMSUnitToBusinessUnit {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$BusinessUnitName
	)
	return CMS_AddUnitToBusinessUnit -businessunitname $BusinessUnitName
}


# TODO: #351 Update Get-Help for Get-PpCMSAdvertisedPackages
<#
	.SYNOPSIS
		Get a list of advertised packages.

	.DESCRIPTION
		Get a list of advertised packages. With JobId, Type, Name, Version, Uninstallscript, Catalogname, Description, Advertiseddate, Groupname and Autoexpand.

	.EXAMPLE
		$packages = Get-PpCMSAdvertisedPackages
		foreach ($package in $packages) {
			Job_WriteLog -Text "Package: $($package.PackageName) Version: $($package.PackageVersion)"
		}

#>
function Get-PpCMSAdvertisedPackages {
	[CmdletBinding()]
	param (
	)
	return CMS_GetAdvertisedPackages
}


# TODO: #291 Update Get-Help for Get-PpCMSDeploymentTemplateVariable
<#
	.SYNOPSIS
		Returns a variable from the deployment template linked to the current client

	.DESCRIPTION
		Returns a variable from the deployment template from which the client was installed. Alternatively, the
		template is fetched from the business unit that the client was linked to at installation time.

	.PARAMETER Section
		The name of the section in the template

	.PARAMETER Variable
		The name of the variable to return

	.PARAMETER MustExist
		True if the variable must exist, defaults is false

	.EXAMPLE
		$value = Get-PpCMSDeploymentTemplateVariable -Variable "title" -MustExist $true
		Job_WriteLog -Text "Title: $value"

	.EXAMPLE
		$value = Get-PpCMSDeploymentTemplateVariable -Section "domain" -Variable "joinDomain" -MustExist $true
		Job_WriteLog -Text "Join domain: $value"

	.NOTES
		Example configutation:
		{
			"operatingSystem": {
				"ImageId": 13,
				"diskConfigId": 1,
				"localAdmin": "true",
				"password": "15aarest"
			},
			"domain": {
				"joinDomain": "CAPADEMO.LOCAL",
				"domainName": "CAPADEMO.LOCAL",
				"domainUserName": "ciinst",
				"domainUserPassword": "dftgyhuj",
				"computerObjectOU": "OU=Computers,OU=Lazise,OU=Dev2,DC=CAPADEMO,DC=local"},
			"title": "Default",
			"customValues": [{
				"key": "a",
				"value": "1"
			}]
		}

#>
function Get-PpCMSDeploymentTemplateVariable {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $false)]
		[string]$Section = '',
		[Parameter(Mandatory = $true)]
		[string]$Variable,
		[Parameter(Mandatory = $false)]
		[bool]$MustExist = $false
	)

	return CMS_GetDeploymentTemplateVariable -section $Section -variable $Variable -mustexist $MustExist
}


# TODO: #359 Update Get-Help for Get-PpCMSGroupMembership
<#
	.SYNOPSIS
		Returns an array of the groups to which the client is linked.

	.DESCRIPTION
		Returns an array of the groups to which the client is linked, containing values:
		- Packagetype
		- Parentid
		- Unittype
		- Id
		- Name
		- Description
		- Type
		- Typedisplayname
		- Icon
		- Cmpid
		- Scheduleid
		- Groupdeleted
		- Businessunitid
		- Linkedprofilecount
		- Linkedapplicationcount
		- Linkedpackagecount
		- Linkedunitcount
		- Folderid
		- Guid
		- Objecttype

	.EXAMPLE
		$groups = Get-PpCMSGroupMembership
		foreach ($group in $groups) {
			Job_WriteLog -Text "Group: $($group.Name)"
		}
#>
function Get-PpCMSGroupMembership {
	[CmdletBinding()]
	param (	)
	return CMS_GetGroupMembership
}


# TODO: #293 Update the Get-Help for Get-PpCMSInventory
<#
	.SYNOPSIS
		Gets inventory values from the database.

	.DESCRIPTION
		Gets inventory values from the database, from either the Hardware, Custom, or Logon inventory tables.

	.PARAMETER Table
		This is the table toward which the request is made, and it can be either 'Hardware Inventory', 'Logon Inventory', or 'Custom Inventory'.

	.PARAMETER Category
		Category name

	.PARAMETER Entry
		Variable name

	.EXAMPLE
		$value = Get-PpCMSInventory -Table 'Hardware Inventory' -Category 'System' -Entry 'Name'
		Job_WriteLog -Text "Name: $value"

	.NOTES
		Please note, that this is an expensive call, seen from the Frontend/database perspective.
		Calling this function repeatedly from a package could result in overall slower performance. This function should be used with care.
#>
function Get-PpCMSInventory {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[ValidateSet('Hardware Inventory', 'Logon Inventory', 'Custom Inventory')]
		[string]$Table,
		[Parameter(Mandatory = $true)]
		[string]$Category,
		[Parameter(Mandatory = $true)]
		[string]$Entry
	)
	$TableShort

	switch ($Table) {
		'Hardware Inventory' {
			$TableShort = 'HWI'
		}
		'Logon Inventory' {
			$TableShort = 'LGI'
		}
		'Custom Inventory' {
			$TableShort = 'CSI'
		}
		Default {
			throw "Invalid table: $Table"
		}
	}

	return CMS_GetInventory -table $TableShort -category $Category -entry $Entry
}


# TODO: #355 Update Get-Help for Get-PpCMSIsPackageLinked
<#
	.SYNOPSIS
		Returns whether the specified package is linked to any unit or group.

	.DESCRIPTION
		Returns as boolean indicating if a package is linked to the unit.

	.PARAMETER PackageName
		The name of the package.

	.PARAMETER PackageVersion
		The version of the package.

	.EXAMPLE
		$bStatus = Get-PpCMSIsPackageLinked -PackageName "Adobe Reader" -PackageVersion "11.0.00"
		if ($bStatus) {
			Write-Host "Package is linked."
		} else {
			Write-Host "Package is not linked."
		}
#>
function Get-PpCMSIsPackageLinked {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion
	)
	return CMS_IsPackageLinked -package $PackageName -version $PackageVersion
}


# TODO: #357 Update Get-Help for Get-PpCMSIsPackageScheduleEnabled
<#
	.SYNOPSIS
		Returns as boolean indicating if the schedule for a package is enabled.

	.DESCRIPTION
		Returns as boolean indicating if the schedule for a package is enabled.

	.PARAMETER PackageName
		The name of the package.

	.PARAMETER PackageVersion
		The version of the package.

	.EXAMPLE
		$bStatus = Get-PpCMSIsPackageScheduleEnabled -PackageName "Adobe Reader" -PackageVersion "11.0.00"
		if ($bStatus) {
			Write-Host "Package schedule is enabled."
		} else {
			Write-Host "Package schedule is not enabled."
	}
#>
function Get-PpCMSIsPackageScheduleEnabled {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion
	)
	return CMS_IsPackageScheduleEnabled -package $PackageName -version $PackageVersion
}


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


# TODO: #349 Update Get-Help for Get-PpCMSPackageStatus
<#
	.SYNOPSIS
		Returns the package status for the specified package.

	.DESCRIPTION
		Returns the package status for the specified package.
		Values can be 'Installed', 'Installing', 'Waiting' 'Failed' or 'Not Scheduled'.
		'Not scheduled' indicates that the package is not linked to the unit.

	.PARAMETER PackageName
		The name of the package to get the status for.

	.PARAMETER PackageVersion
		The version of the package to get the status for.

	.EXAMPLE
		$status = Get-PpCMSPackageStatus -PackageName "MyPackage" -PackageVersion "1.0.0"
		if ($status -eq "Installed") {
			Job_WriteLog -Text "Package is installed."
		} elseif ($status -eq "Installing") {
			Job_WriteLog -Text "Package is installing."
		} elseif ($status -eq "Waiting") {
			Job_WriteLog -Text "Package is waiting."
		} elseif ($status -eq "Failed") {
			Job_WriteLog -Text "Package failed."
		} elseif ($status -eq "Not Scheduled") {
			Job_WriteLog -Text "Package is not scheduled."
		} else {
			Job_WriteLog -Text "Unknown package status."
		}
#>
function Get-PpCMSPackageStatus {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion
	)
	return CMS_GetPackageStatus -package $PackageName -version $PackageVersion
}


# TODO: #290 Update Get-Help for Get-PpCMSProperty
<#
	.SYNOPSIS
		Returns a property from the property table in the SQL database

	.DESCRIPTION
		Returns a property from the property table in the SQL database

	.PARAMETER Property
		The property to return, must be one of the following: CapaOneOrgId, CapaOneOrgKey, CapaOneOrgName, CapaOneOrgTag

	.EXAMPLE
		$value = Get-PpCmsProperty -Property CapaOneOrgId
		Job_WriteLog -Text "CapaOneOrgId: $value"
#>
function Get-PpCMSProperty {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[ValidateSet('CapaOneOrgId', 'CapaOneOrgKey', 'CapaOneOrgName', 'CapaOneOrgTag')]
		[string]$Property
	)

	return CMS_GetProperty -prop $Property
}


# TODO: #335 Update Get-Help for Initialize-PpCMSRerunPackage
<#
	.SYNOPSIS
		Sets status for the specified package to 'Waiting' causing it to rerun the next time the Agent is being executed.

	.DESCRIPTION
		Sets status for the specified package to 'Waiting' causing it to rerun the next time the Agent is being executed.

	.PARAMETER PackageName
		Name of the package to rerun.

	.PARAMETER PackageVersion
		Version of the package to rerun.

	.EXAMPLE
		$bStatus = Initialize-PpCMSRerunPackage -PackageName "MyPackage" -PackageVersion "v1.0"
		if ($bStatus) {
			Job_WriteLog -Text "Package 'MyPackage' with version 'v1.0' has been set to rerun."
		} else {
			Job_WriteLog -Text "Failed to set package 'MyPackage' with version 'v1.0' to rerun."
		}
#>
function Initialize-PpCMSRerunPackage {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion
	)
	return CMS_RerunPackage -package $PackageName -version $PackageVersion
}


# TODO: #331 Update Get-Help for Install-PpCMSAdvertisedPackage
<#
	.SYNOPSIS
		Installs an advertised package on the unit on which the script is being executed

	.DESCRIPTION
		Installs an advertised package on the unit on which the script is being executed

	.PARAMETER PackageName
		The name of the package to install

	.PARAMETER PackageVersion
		The version of the package to install

	.EXAMPLE
		$bStatus = Install-PpCMSAdvertisedPackage -PackageName "MyPackage" -PackageVersion "1.0.0"
		if ($bStatus) {
			Job_WriteLog -Text "Package installed."
		} else {
			Job_WriteLog -Text "Failed to install package."
	}
#>
function Install-PpCMSAdvertisedPackage {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion
	)
	return CMS_InstallAdvertisedPackage -package $PackageName -version $PackageVersion
}


# TODO: #337 Update Get-Help for Invoke-PpCMSRunSystemAgent
<#
	.SYNOPSIS
		Reruns the CapaInstaller Service Agent

	.DESCRIPTION
		Sends a CallHome UnitCommand to the BaseAgent which in turn will request the Cistub service to run the Agent script in the system context.

	.PARAMETER Delay
		If the delay is empty, the command will be set to now.
		Delay examples: 10s (in 10 seconds), 5m (5 minutes) or 1h20m (1 hour and 20 minutes)

	.EXAMPLE
		$bStatus = Invoke-PpCMSRunSystemAgent -Delay "10s"
		if ($bStatus) {
			Job_WriteLog -Text "System Agent has been set to run in 10 seconds."
		} else {
			Job_WriteLog -Text "Failed to set System Agent to run in 10 seconds."
		}
#>
function Invoke-PpCMSRunSystemAgent {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $false)]
		[string]$Delay
	)
	return CMS_RunSystemAgent -delay $Delay
}


# TODO: #339 Update Get-Help for Invoke-PpCMSRunUserAgent
<#
	.SYNOPSIS
		Sends a CallHomeUser UnitCommand to the BaseAgent which in turn will request the InfoCenter to run the Agent script in the user context.

	.DESCRIPTION
		Sends a CallHomeUser UnitCommand to the BaseAgent which in turn will request the InfoCenter to run the Agent script in the user context.

	.PARAMETER Delay
		If the delay is empty, the command will be set to now.
		Delay examples: 10s (in 10 seconds), 5m (5 minutes) or 1h20m (1 hour and 20 minutes)

	.EXAMPLE
		$bStatus = Invoke-PpCMSRunUserAgent -Delay "10s"
		if ($bStatus) {
			Job_WriteLog -Text "User Agent has been set to run in 10 seconds."
		} else {
			Job_WriteLog -Text "Failed to set User Agent to run in 10 seconds."
		}
#>
function Invoke-PpCMSRunUserAgent {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $false)]
		[string]$Delay
	)
	return CMS_RunUserAgent -delay $Delay
}


# TODO: #287 Add Get-Help for Invoke-PpJobRetryLater
function Invoke-PpJobRetryLater {
	[CmdletBinding()]
	[Alias('CMS_JobRetryLater')]
	param ()

	$Global:Cs.CMS_JobRetryLater()
}


# TODO: #315 Update Get-Help for Remove-PpCMSComputerFromCalendarGroup
<#
	.SYNOPSIS
		Removes a specified computer unit from a calendar group.

	.DESCRIPTION
		Removes a specified computer unit from a calendar group.

	.PARAMETER Group
		The name of the calendar group from which the computer unit should be removed.

	.EXAMPLE
		$bStatus = Remove-PpCMSComputerFromCalendarGroup -Group "MyCalendarGroup"
		if ($bStatus) {
			Job_WriteLog -Text "Computer unit removed from calendar group."
		} else {
			Job_WriteLog -Text "Failed to remove computer unit from calendar group."
		}
#>
function Remove-PpCMSComputerFromCalendarGroup {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$Group
	)
	return CMS_RemoveComputerFromCalendarGroup -group $Group
}


# TODO: #319 Update Get-Help for Remove-PpCMSComputerFromDepartmentGroup, missing BU support description
<#
	.SYNOPSIS
		Removes a specified computer unit from a department group.

	.DESCRIPTION
		Removes a specified computer unit from a department group.

	.PARAMETER Group
		The name of the department group from which the computer unit should be removed.

	.EXAMPLE
		$bStatus = Remove-PpCMSComputerFromDepartmentGroup -Group "MyDepartmentGroup"
		if ($bStatus) {
			Job_WriteLog -Text "Computer unit removed from department group."
		} else {
			Job_WriteLog -Text "Failed to remove computer unit from department group."
		}
#>
function Remove-PpCMSComputerFromDepartmentGroup {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$Group
	)
	return CMS_RemoveComputerFromDepartmentGroup -group $Group
}


# TODO: #323 Update Get-Help for Remove-PpCMSComputerFromPowerSchemeGroup
<#
	.SYNOPSIS
		Remove a computer from a Power Scheme Group.

	.DESCRIPTION
		Remove a computer from a Power Scheme Group.

	.PARAMETER Group
		The name of the Power Scheme Group.

	.EXAMPLE
		$bStatus = Remove-PpCMSComputerFromPowerSchemeGroup -Group "MyGroup"
		if ($bStatus) {
			Job_WriteLog -Text "Computer removed from Power Scheme Group."
		} else {
			Job_WriteLog -Text "Failed to remove computer from Power Scheme Group."
		}
#>
function Remove-PpCMSComputerFromPowerSchemeGroup {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$Group
	)
	return CMS_RemoveComputerFromPowerSchemeGroup -group $Group
}


# TODO: #327 Update Get-Help for Remove-PpCMSComputerFromReinstallGroup, missing BU support description
<#
	.SYNOPSIS
		Remove a computer from a Reinstall Group.

	.DESCRIPTION
		Remove a computer from a Reinstall Group.

	.PARAMETER Group
		The name of the Reinstall Group.

	.EXAMPLE
		$bStatus = Remove-PpCMSComputerFromReinstallGroup -Group "MyGroup"
		if ($bStatus) {
			Job_WriteLog -Text "Computer removed from Reinstall Group."
		} else {
			Job_WriteLog -Text "Failed to remove computer from Reinstall Group."
		}
#>
function Remove-PpCMSComputerFromReinstallGroup {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$Group
	)
	return CMS_RemoveComputerFromReinstallGroup -group $Group
}


# TODO: #311 Update Get-Help for Remove-PpCMSComputerFromStaticGroup. Missing documentation for BU support.
<#
	.SYNOPSIS
		Removes the specified unit from the specified static group.

	.DESCRIPTION
		Removes the specified unit from the specified static group.

	.PARAMETER Group
		The name of the static group to remove the unit from.

	.EXAMPLE
		$bStatus = Remove-PpCMSComputerFromStaticGroup -Group "CapaInstaller"
		if ($bStatus) {
			Job_WriteLog -Text "Computer removed from group."
		} else {
			Job_WriteLog -Text "Failed to remove computer from group."
		}
#>
function Remove-PpCMSComputerFromStaticGroup {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$Group
	)
	return CMS_RemoveComputerFromStaticGroup -group $Group
}


# TODO: #297 Update Get-Help for Remove-PpCMSCustomInventory
<#
	.SYNOPSIS
		Removes a CustomInventory row from the database that is persistent.

	.DESCRIPTION
		Removes a persistent CustomInventory row from the database.

	.PARAMETER Category
		Category name

	.PARAMETER Entry
		Variable name

	.EXAMPLE
		$bStatus = Remove-PpCMSCustomInventory -Category "Bitlocker" -Entry "BitlockerStatus"
#>
function Remove-PpCMSCustomInventory {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$Category,
		[Parameter(Mandatory = $true)]
		[string]$Entry
	)

	return CMS_RemoveCustomInventory -category $Category -entry $Entry
}


# TODO: #303 Add Get-Help for Remove-PpCMSHardwareInventory
<#
	.SYNOPSIS
		Removes a HardwareInventory row from the database that is persistent.

	.DESCRIPTION
		Removes a HardwareInventory row from the database that is persistent.

	.PARAMETER Category
		Category name

	.PARAMETER Entry
		Variable name

	.EXAMPLE
		$bStatus = Remove-PpCMSHardwareInventory -Category "MyCategory" -Entry "MyEntry"
		if ($bStatus) {
			Job_WriteLog -Text "Hardware inventory removed successfully."
		} else {
			Job_WriteLog -Text "Failed to remove hardware inventory."
	}
#>
function Remove-PpCMSHardwareInventory {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$Category,
		[Parameter(Mandatory = $true)]
		[string]$Entry
	)
	return CMS_RemoveHardwareInventory -category $Category -entry $Entry
}


# TODO: #333 Update Get-Help for Remove-PpCMSPackageFromUnit
<#
	.SYNOPSIS
		Removes the specified package from the unit on which the script is being executed

	.DESCRIPTION
		Removes the specified package from the unit on which the script is being executed

	.PARAMETER PackageName
		The name of the package to remove from the unit

	.PARAMETER PackageVersion
		The version of the package to remove from the unit

	.EXAMPLE
		$bStatus = Remove-PpCMSPackageFromUnit -PackageName "MyPackage" -PackageVersion "1.0.0"
		if ($bStatus) {
			Job_WriteLog -Text "Package removed from unit."
		} else {
			Job_WriteLog -Text "Failed to remove package from unit."
	}
#>
function Remove-PpCMSPackageFromUnit {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion
	)
	return CMS_RemovePackageFromUnit -package $PackageName -version $PackageVersion
}


# TODO: #299 Add Get-Help for Reset-PpCMSCustomInventory
function Reset-PpCMSCustomInventory {
	[CmdletBinding()]
	param (
		[string]$Category
	)
	return CMS_ClearCustomInventory -category $Category
}


# TODO: #305 Add Get-Help for Add-PpCMSCustomInventory
function Set-PpCMSCurrentUser {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$Username
	)
	return CMS_SetCurrentUser -username $Username
}


# TODO: #345 Update Get-Help for Set-PpCMSPackageStatusToInstalled
<#
	.SYNOPSIS
		Sets the status of the specified package to installed.

	.DESCRIPTION
		Sets the status of the specified package to installed.

	.PARAMETER PackageName
		The name of the package to set the status for.

	.PARAMETER PackageVersion
		The version of the package to set the status for.

	.EXAMPLE
		$bStatus = Set-PpCMSPackageStatusToInstalled -PackageName "MyPackage" -PackageVersion "1.0.0"
		if ($bStatus) {
			Job_WriteLog -Text "Package status set to installed."
		} else {
			Job_WriteLog -Text "Failed to set package status to installed."
		}
#>
function Set-PpCMSPackageStatusToInstalled {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion
	)
	return CMS_SetPackageStatusToInstalled -package $PackageName -version $PackageVersion
}


# TODO: #347 Update Get-Help for Set-PpCMSPackageStatusToNotCompliant
<#
	.SYNOPSIS
		Set the status of a package to Not Compliant.

	.DESCRIPTION
		Set the status of a package to Not Compliant.

	.PARAMETER PackageName
		The name of the package to set the status for.

	.PARAMETER PackageVersion
		The version of the package to set the status for.

	.EXAMPLE
		$bStatus = Set-PpCMSPackageStatusToNotCompliant -PackageName "MyPackage" -PackageVersion "1.0.0"
		if ($bStatus) {
			Job_WriteLog -Text "Package status set to Not Compliant."
		} else {
			Job_WriteLog -Text "Failed to set package status to Not Compliant."
		}
#>
function Set-PpCMSPackageStatusToNotCompliant {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion
	)
	return CMS_SetPackageStatusToNotCompliant -package $PackageName -version $PackageVersion
}


# TODO: #343 Update Get-Help for Test-PpCMSExistPackageOnManagementServer
<#
	.SYNOPSIS
		Checks if the specified package exists on the management server the agent is connected to.

	.DESCRIPTION
		Checks if the specified package exists on the management server the agent is connected to.

	.PARAMETER PackageName
		The name of the package to check for.

	.PARAMETER PackageVersion
		The version of the package to check for.

	.PARAMETER MustExist
		If the package must exist or not. Default is false.

	.EXAMPLE
		$bStatus = Test-PpCMSExistPackageOnManagementServer -PackageName "MyPackage" -PackageVersion "1.0.0"
		if ($bStatus) {
			Job_WriteLog -Text "Package exists on management server."
		} else {
			Job_WriteLog -Text "Package does not exist on management server."
		}
#>
function Test-PpCMSExistPackageOnManagementServer {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion,
		[Parameter(Mandatory = $false)]
		[bool]$MustExist = $false
	)
	return CMS_ExistPackageOnManagementServer -package $PackageName -version $PackageVersion -mustexist $MustExist
}


# TODO: #307 Update Get-Help for Uninstall-PpCMSPackageFromUnit
<#
	.SYNOPSIS
		Uninstalls package from unit.

	.DESCRIPTION
		Uninstalls package from unit.

	.PARAMETER PackageID
		ID of the package (JobId from the JOB table).

	.PARAMETER PackageName
		Name of the package.

	.PARAMETER PackageVersion
		Version of the package.

	.EXAMPLE
		$bStatus = Uninstall-PpCMSPackageFromUnit -PackageID 1234
		if ($bStatus) {
			Job_WriteLog -Text "Package uninstalled"
		} else {
			Job_WriteLog -Text "Failed to uninstall package"
		}

	.EXAMPLE
		$bStatus = Uninstall-PpCMSPackageFromUnit -PackageName 'MyPackage' -PackageVersion 'v1.0'
		if ($bStatus) {
			Job_WriteLog -Text "Package uninstalled"
		} else {
			Job_WriteLog -Text "Failed to uninstall package"
		}
#>
function Uninstall-PpCMSPackageFromUnit {
	[CmdletBinding()]
	param (
		[Parameter(ParameterSetName = 'ID', Mandatory = $true)]
		[string]$PackageID,
		[Parameter(ParameterSetName = 'NameVersion', Mandatory = $true)]
		[string]$PackageName,
		[Parameter(ParameterSetName = 'NameVersion', Mandatory = $true)]
		[string]$PackageVersion
	)
	if ($PackageID) {
		return CMS_UninstallPackageFromUnitByID -packageid $PackageID
	} else {
		return CMS_UninstallPackageFromUnit -package $PackageName -version $PackageVersion
	}
}


