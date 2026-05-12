
<#
	.SYNOPSIS
		Adds a printer to a unit.

	.DESCRIPTION
		Adds the specified printer share to the specified unit by calling the
		CapaSDK method AddPrinterToUnit.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to add the printer to.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.PARAMETER PrinterShareName
		Printer share name.

	.EXAMPLE
		PS C:\> Add-CapaPrinterToUnit -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer -PrinterShareName '\\PRINT01\\Office-Color'

		Adds printer share \\PRINT01\\Office-Color to PC-01.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247286/Add+printer+to+unit
#>
function Add-CapaPrinterToUnit {
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$PrinterShareName
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'AddPrinterToUnit')) {
		throw 'CapaSDK does not contain method AddPrinterToUnit.'
	}

	$target = "$UnitType unit '$UnitName'"
	$action = "Add printer share '$PrinterShareName'"
	if (-not $PSCmdlet.ShouldProcess($target, $action)) {
		return
	}

	$value = $CapaSDK.AddPrinterToUnit($UnitName, $UnitType, $PrinterShareName)
	return $value
}


<#
	.SYNOPSIS
		Adds a unit to a business unit.

	.DESCRIPTION
		Adds the specified unit to the specified business unit by calling the
		CapaSDK method AddUnitToBusinessUnit.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to add.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.PARAMETER BusinessUnit
		Name of the business unit.

	.EXAMPLE
		PS C:\> Add-CapaUnitToBusinessUnit -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer -BusinessUnit 'TestBU'

		Adds PC-01 to TestBU.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247294/Add+unit+to+business+unit
#>
function Add-CapaUnitToBusinessUnit {
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$BusinessUnit
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'AddUnitToBusinessUnit')) {
		throw 'CapaSDK does not contain method AddUnitToBusinessUnit.'
	}

	$target = "$UnitType unit '$UnitName'"
	$action = "Add to business unit '$BusinessUnit'"
	if (-not $PSCmdlet.ShouldProcess($target, $action)) {
		return
	}

	$value = $CapaSDK.AddUnitToBusinessUnit($UnitName, $UnitType, $BusinessUnit)

	return $value
}


<#
	.SYNOPSIS
		Adds a unit to a calendar group.

	.DESCRIPTION
		Adds the specified unit to the specified calendar group by calling the
		CapaSDK method AddUnitToCalendarGroup.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to add.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.PARAMETER CalendarGroupName
		Name of the calendar group.

	.EXAMPLE
		PS C:\> Add-CapaUnitToCalendarGroup -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer -CalendarGroupName 'Nightly Window'

		Adds PC-01 to the calendar group Nightly Window.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247302/Add+unit+to+calendar+group
#>
function Add-CapaUnitToCalendarGroup {
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$CalendarGroupName
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'AddUnitToCalendarGroup')) {
		throw 'CapaSDK does not contain method AddUnitToCalendarGroup.'
	}

	$target = "$UnitType unit '$UnitName'"
	$action = "Add to calendar group '$CalendarGroupName'"
	if (-not $PSCmdlet.ShouldProcess($target, $action)) {
		return
	}

	$value = $CapaSDK.AddUnitToCalendarGroup($UnitName, $UnitType, $CalendarGroupName)
	return $value
}


<#
	.SYNOPSIS
		Adds a unit to a folder.

	.DESCRIPTION
		Adds the specified unit to the specified folder path by calling the CapaSDK
		method AddUnitToFolder.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to move.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.PARAMETER FolderStructure
		Destination folder structure.

	.PARAMETER CreateFolder
		Whether to create missing folders. Valid values are true and false.
		Default is false.

	.EXAMPLE
		PS C:\> Add-CapaUnitToFolder -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer -FolderStructure 'Pester\\Computers' -CreateFolder true

		Moves PC-01 to Pester\\Computers and creates missing folders.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247310/Add+unit+to+folder
#>
function Add-CapaUnitToFolder {
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$FolderStructure,
		[ValidateSet('true', 'false')]
		[string]$CreateFolder = 'false'
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'AddUnitToFolder')) {
		throw 'CapaSDK does not contain method AddUnitToFolder.'
	}

	$target = "$UnitType unit '$UnitName'"
	$action = "Move to folder '$FolderStructure' (CreateFolder=$CreateFolder)"
	if (-not $PSCmdlet.ShouldProcess($target, $action)) {
		return
	}

	$aUnits = $CapaSDK.AddUnitToFolder($UnitName, $UnitType, $FolderStructure, $CreateFolder)

	return $aUnits
}


<#
	.SYNOPSIS
		Adds a unit to a group.

	.DESCRIPTION
		Adds the specified unit to the specified group by calling AddUnitToGroup
		or AddUnitToGroupBU on the CapaSDK instance.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to add to the group.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer, User, and Printer.

	.PARAMETER GroupName
		Name of the group.

	.PARAMETER GroupType
		Type of group. Dynamic_SQL and Dynamic_ADSI are only valid for Printer units.

	.PARAMETER BusinessUnitName
		Optional business unit name. When specified, AddUnitToGroupBU is used.

	.EXAMPLE
		PS C:\> Add-CapaUnitToGroup -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer -GroupName 'Workstations' -GroupType Static

		Adds PC-01 to the Workstations static group.

	.EXAMPLE
		PS C:\> Add-CapaUnitToGroup -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer -GroupName 'HQ Devices' -GroupType Static -BusinessUnitName 'Headquarters'

		Adds PC-01 to the group in the specified business unit.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247318/Add+unit+to+group
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247332/Add+unit+to+group+BU
#>
function Add-CapaUnitToGroup {
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User', 'Printer')]
		[string]$UnitType,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Calendar', 'Department', 'Reinstall', 'Security', 'Static', 'Dynamic_SQL', 'Dynamic_ADSI')]
		[string]$GroupType,
		[ValidateNotNullOrEmpty()]
		[String]$BusinessUnitName
	)

	if (($GroupType -eq 'Dynamic_SQL' -or $GroupType -eq 'Dynamic_ADSI') -and $UnitType -ne 'Printer') {
		throw "GroupType '$GroupType' only supports UnitType 'Printer'."
	}

	$usingBusinessUnit = -not [string]::IsNullOrEmpty($BusinessUnitName)
	if ($usingBusinessUnit) {
		if (-not ($CapaSDK.PSObject.Methods.Name -contains 'AddUnitToGroupBU')) {
			throw 'CapaSDK does not contain method AddUnitToGroupBU.'
		}
	}
	else {
		if (-not ($CapaSDK.PSObject.Methods.Name -contains 'AddUnitToGroup')) {
			throw 'CapaSDK does not contain method AddUnitToGroup.'
		}
	}

	$target = "$UnitType unit '$UnitName'"
	$action = if ($usingBusinessUnit) {
		"Add to group '$GroupName' ($GroupType) in business unit '$BusinessUnitName'"
	}
	else {
		"Add to group '$GroupName' ($GroupType)"
	}

	if (-not $PSCmdlet.ShouldProcess($target, $action)) {
		return
	}

	if ($usingBusinessUnit) {
		$value = $CapaSDK.AddUnitToGroupBU($UnitName, $UnitType, $GroupName, $GroupType, $BusinessUnitName)
	}
	else {
		$value = $CapaSDK.AddUnitToGroup($UnitName, $UnitType, $GroupName, $GroupType)
	}

	return $value
}


<#
	.SYNOPSIS
		Adds a unit to a package.

	.DESCRIPTION
		Adds the specified unit to the specified package by calling the CapaSDK
		method AddUnitToPackage.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER PackageType
		Package type. Valid values are Computer, User, 1, and 2.

	.PARAMETER PackageName
		Name of the package.

	.PARAMETER PackageVersion
		Version of the package.

	.PARAMETER UnitName
		Name of the unit to add.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.EXAMPLE
		PS C:\> Add-CapaUnitToPackage -CapaSDK $CapaSDK -PackageType Computer -PackageName 'MyPkg' -PackageVersion 'v1.0' -UnitName 'PC-01' -UnitType Computer

		Adds PC-01 to package MyPkg v1.0.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247340/Add+unit+to+package
#>
function Add-CapaUnitToPackage {
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User', '1', '2')]
		[string]$PackageType,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'AddUnitToPackage')) {
		throw 'CapaSDK does not contain method AddUnitToPackage.'
	}

	if ($PackageType -eq 'Computer') {
		$PackageType = '1'
	} elseif ($PackageType -eq 'User') {
		$PackageType = '2'
	}

	$target = "$UnitType unit '$UnitName'"
	$action = "Add to package '$PackageName' ($PackageVersion)"
	if (-not $PSCmdlet.ShouldProcess($target, $action)) {
		return
	}

	$bool = $CapaSDK.AddUnitToPackage($UnitName, $UnitType, $PackageName, $PackageVersion, $PackageType)

	return $bool
}


<#
	.SYNOPSIS
		Adds a unit to reinstall.

	.DESCRIPTION
		Adds the specified unit to reinstall by calling the CapaSDK method
		AddUnitToReinstall.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER ComputerName
		Computer unit name (or UUID alias) to add to reinstall.

	.PARAMETER OSpointID
		OS point ID.

	.PARAMETER OSserverID
		OS server ID.

	.PARAMETER OSImageID
		OS image ID.

	.PARAMETER DiskConfigID
		Disk configuration ID.

	.PARAMETER InstallTypeID
		Installation type ID.

	.PARAMETER NewUnitName
		Optional new unit name after reinstall.

	.PARAMETER ReinstallMode
		Reinstall mode.

	.PARAMETER Active
		Whether reinstall entry is active.

	.PARAMETER UnlinkAllPackagesAndGroups
		Whether to unlink all packages and groups.

	.PARAMETER UnlinkAllAdvPackages
		Whether to unlink all advanced packages.

	.PARAMETER ChangelogComment
		Optional changelog comment.

	.PARAMETER ReinstallStartDate
		Optional reinstall start date.

	.PARAMETER CustomField1
		Optional custom field 1.

	.PARAMETER CustomField2
		Optional custom field 2.

	.EXAMPLE
		PS C:\> Add-CapaUnitToReinstall -CapaSDK $CapaSDK -ComputerName 'PC-01' -OSpointID 1 -OSserverID 1 -OSImageID 1 -DiskConfigID 1 -InstallTypeID 1

		Adds PC-01 to reinstall.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247348/Add+unit+to+reinstall
#>
function Add-CapaUnitToReinstall {
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[Alias('UUID')]
		[ValidateNotNullOrEmpty()]
		[String]$ComputerName,
		[Parameter(Mandatory = $true)]
		[ValidateRange(1, 2147483647)]
		[int]$OSpointID,
		[Parameter(Mandatory = $true)]
		[ValidateRange(1, 2147483647)]
		[int]$OSserverID,
		[Parameter(Mandatory = $true)]
		[ValidateRange(1, 2147483647)]
		[int]$OSImageID,
		[Parameter(Mandatory = $true)]
		[ValidateRange(1, 2147483647)]
		[int]$DiskConfigID,
		[Parameter(Mandatory = $true)]
		[ValidateRange(1, 2147483647)]
		[int]$InstallTypeID,
		[String]$NewUnitName = '',
		[Parameter(Mandatory = $false)]
		[ValidateSet('Silent', 'AlwaysConfirm', 'ConfirmOnlyIfUserLoggedOn')]
		[String]$ReinstallMode = 'Silent',
		[bool]$Active = $true,
		[bool]$UnlinkAllPackagesAndGroups = $false,
		[bool]$UnlinkAllAdvPackages = $false,
		[String]$ChangelogComment = '',
		[String]$ReinstallStartDate = '',
		[String]$CustomField1 = '',
		[String]$CustomField2 = ''
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'AddUnitToReinstall')) {
		throw 'CapaSDK does not contain method AddUnitToReinstall.'
	}

	$target = "Computer unit '$ComputerName'"
	$action = 'Add to reinstall'
	if (-not $PSCmdlet.ShouldProcess($target, $action)) {
		return
	}

	$value = $CapaSDK.AddUnitToReinstall($ComputerName, $OSpointID, $OSserverID, $OSImageID, $DiskConfigID, $InstallTypeID, $NewUnitName, $ReinstallMode, $Active, $UnlinkAllPackagesAndGroups, $UnlinkAllAdvPackages, $ChangelogComment, $ReinstallStartDate, $CustomField1, $CustomField2)
	return $value
}


<#
	.SYNOPSIS
		Creates a unit.

	.DESCRIPTION
		Creates a unit in CapaInstaller by calling the CapaSDK method CreateUnit.
		Supports creating both basic units and device-specific units.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to create.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.PARAMETER LinkToManagementServerID
		Management server ID to link the unit to.

	.PARAMETER Status
		Status of the unit. Valid values are Active and Inactive.

	.PARAMETER Uuid
		Optional UUID used when UnitDeviceType is specified.

	.PARAMETER SerialNumber
		Optional serial number used when UnitDeviceType is specified.

	.PARAMETER UnitDeviceType
		Optional device type. When specified, the extended CreateUnit overload is used.

	.EXAMPLE
		PS C:\> Create-CapaUnit -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer -LinkToManagementServerID 2

		Creates a computer unit named PC-01 linked to management server ID 2.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247364/Create+unit
#>
function Create-CapaUnit {
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType,
		[Parameter(Mandatory = $true)]
		[ValidateRange(1, [int]::MaxValue)]
		[int]$LinkToManagementServerID,
		[Parameter(Mandatory = $false)]
		[ValidateSet('Active', 'Inactive')]
		[String]$Status = 'Active',
		[ValidatePattern('^$|^[0-9a-fA-F-]{36}$')]
		[String]$Uuid = '',
		[String]$SerialNumber = '',
		[ValidateSet('Windows', 'OSX', 'iOS', 'Android', 'WindowsPhone')]
		[String]$UnitDeviceType = ''
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'CreateUnit')) {
		throw 'CapaSDK does not contain method CreateUnit.'
	}

	$target = "$UnitType unit '$UnitName'"
	$action = "Create unit linked to management server ID $LinkToManagementServerID"
	if (-not $PSCmdlet.ShouldProcess($target, $action)) {
		return
	}

	if ($UnitDeviceType -eq '') {
		$value = $CapaSDK.CreateUnit($UnitName, $UnitType, $LinkToManagementServerID, $Status)
	} else {
		$value = $CapaSDK.CreateUnit($UnitName, $UnitType, $LinkToManagementServerID, $Status, $Uuid, $SerialNumber, $UnitDeviceType)
	}

	return $value
}


<#
	.SYNOPSIS
		Deletes a unit.

	.DESCRIPTION
		Deletes an existing unit in CapaInstaller by calling the CapaSDK method
		DeleteUnit.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to delete.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.EXAMPLE
		PS C:\> Delete-CapaUnit -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer -Confirm:$false

		Deletes unit PC-01.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247372/Delete+unit
#>
function Delete-CapaUnit {
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'DeleteUnit')) {
		throw 'CapaSDK does not contain method DeleteUnit.'
	}

	$target = "$UnitType unit '$UnitName'"
	$action = 'Delete unit'
	if (-not $PSCmdlet.ShouldProcess($target, $action)) {
		return
	}

	$value = $CapaSDK.DeleteUnit($UnitName, $UnitType)
	return $value
}


<#
	.SYNOPSIS
		Checks whether a unit exists by name/type or UUID.

	.DESCRIPTION
		Checks whether a unit exists in CapaInstaller by using either the NameType
		parameter set (UnitName + UnitType) or the Uuid parameter set.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to check.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.PARAMETER Uuid
		UUID of the unit to check.

	.EXAMPLE
		PS C:\> Exist-CapaUnit -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer

		Checks whether PC-01 exists as a computer unit.

	.EXAMPLE
		PS C:\> Exist-CapaUnit -CapaSDK $CapaSDK -Uuid '4f5e6d7c-8b9a-4c3d-9e0f-1a2b3c4d5e6f'

		Checks whether a unit exists with the specified UUID.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247388/Exist+unit
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247418/Exist+uuid
#>
function Exist-CapaUnit {
	[CmdletBinding()]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(ParameterSetName = 'NameType',
			Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$UnitName,
		[Parameter(ParameterSetName = 'NameType',
			Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType,
		[Parameter(ParameterSetName = 'Uuid',
			Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[ValidatePattern('^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$')]
		[String]$Uuid
	)

	if ($PSCmdlet.ParameterSetName -eq 'NameType') {
		if (-not ($CapaSDK.PSObject.Methods.Name -contains 'ExistUnit')) {
			throw 'CapaSDK does not contain method ExistUnit.'
		}
		$value = $CapaSDK.ExistUnit($UnitName, $UnitType)
	} else {
		if (-not ($CapaSDK.PSObject.Methods.Name -contains 'ExistUUID')) {
			throw 'CapaSDK does not contain method ExistUUID.'
		}
		$value = $CapaSDK.ExistUUID($Uuid)
	}

	return $value
}


<#
	.SYNOPSIS
		Checks whether a unit exists on a specific location.

	.DESCRIPTION
		Checks whether the specified unit exists on the specified location by
		calling the CapaSDK method ExistUnitLocation.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to check.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.PARAMETER Location
		Location path to validate for the unit.

	.EXAMPLE
		PS C:\> Exist-CapaUnitLocation -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer -Location 'Default\\Devices'

		Returns whether PC-01 exists on location Default\Devices.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247402/Exist+unit+location
#>
function Exist-CapaUnitLocation {
	[CmdletBinding()]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$Location
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'ExistUnitLocation')) {
		throw 'CapaSDK does not contain method ExistUnitLocation.'
	}

	$value = $CapaSDK.ExistUnitLocation($UnitName, $UnitType, $Location)
	return $value
}


<#
	.SYNOPSIS
		Checks whether a unit exists on a management point.

	.DESCRIPTION
		Checks whether the specified unit exists on the specified management point
		by calling the CapaSDK method ExistUnitOnManagementPoint.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to check.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.PARAMETER CMPID
		Management point ID to check against.

	.EXAMPLE
		PS C:\> Exist-CapaUnitOnManagementPoint -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer -CMPID 2

		Returns whether PC-01 exists on management point 2.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247410/Exist+Unit+On+Management+Point
#>
function Exist-CapaUnitOnManagementPoint {
	[CmdletBinding()]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType,
		[Parameter(Mandatory = $true)]
		[ValidateRange(1, 2147483647)]
		[int]$CMPID
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'ExistUnitOnManagementPoint')) {
		throw 'CapaSDK does not contain method ExistUnitOnManagementPoint.'
	}

	$value = $CapaSDK.ExistUnitOnManagementPoint($UnitName, $UnitType, $CMPID)
	return $value
}


<#
	.SYNOPSIS
		Gets description for a unit.

	.DESCRIPTION
		Gets the description for the specified unit by calling the CapaSDK method
		GetUnitDescription.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to query description for.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.EXAMPLE
		PS C:\> Get-CapaUnitDescription -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer

		Returns the description for PC-01.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247474/Get+unit+description
#>
function Get-CapaUnitDescription {
	[CmdletBinding()]
	[OutputType([object])]
	param (
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'GetUnitDescription')) {
		throw 'CapaSDK does not contain method GetUnitDescription.'
	}

	$value = $CapaSDK.GetUnitDescription($UnitName, $UnitType)
	return $value
}


<#
	.SYNOPSIS
		Gets folder path for a unit.

	.DESCRIPTION
		Gets the folder location for the specified unit by calling the CapaSDK
		method GetUnitFolder.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to query folder path for.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.EXAMPLE
		PS C:\> Get-CapaUnitFolder -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer

		Returns the folder path for PC-01.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247632/GetUnitFolder
#>
function Get-CapaUnitFolder {
	[CmdletBinding()]
	[OutputType([object])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'GetUnitFolder')) {
		throw 'CapaSDK does not contain method GetUnitFolder.'
	}

	$value = $CapaSDK.GetUnitFolder($UnitName, $UnitType)

	return $value
}


<#
	.SYNOPSIS
		Gets groups linked to a unit.

	.DESCRIPTION
		Gets groups linked to the specified unit by calling the CapaSDK method
		GetUnitGroups and returns parsed group objects.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to query groups for.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.EXAMPLE
		PS C:\> Get-CapaUnitGroups -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer

		Returns groups linked to PC-01.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247482/Get+unit+groups
#>
function Get-CapaUnitGroups {
	[CmdletBinding()]
	[OutputType([pscustomobject[]])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'GetUnitGroups')) {
		throw 'CapaSDK does not contain method GetUnitGroups.'
	}

	$aUnits = $CapaSDK.GetUnitGroups($UnitName, $UnitType)
	if ($null -eq $aUnits) {
		return @()
	}

	$oaUnits = foreach ($sItem in $aUnits) {
		if ([string]::IsNullOrWhiteSpace([string]$sItem)) {
			continue
		}

		$aItem = [string]$sItem -split ';', 6
		if ($aItem.Count -lt 6) {
			continue
		}

		[pscustomobject]@{
			Name        = $aItem[0];
			Type        = $aItem[1];
			unitTypeID  = $aItem[2];
			Description = $aItem[3];
			GUID        = $aItem[4];
			ID          = $aItem[5]
		}
	}

	return @($oaUnits)
}


<#
	.SYNOPSIS
		Gets last runtime for a unit.

	.DESCRIPTION
		Gets the last runtime value for a unit by calling the CapaSDK method
		GetUnitLastRuntime.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to query.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.EXAMPLE
		PS C:\> Get-CapaUnitLastRuntime -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer

		Returns last runtime information for PC-01.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247492/Get+unit+last+runtime
#>
function Get-CapaUnitLastRuntime {
	[CmdletBinding()]
	[OutputType([object])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User', '1', '2')]
		[string]$UnitType
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'GetUnitLastRuntime')) {
		throw 'CapaSDK does not contain method GetUnitLastRuntime.'
	}

	if ($UnitType -eq 'Computer') {
		$UnitType = '1'
	} elseif ($UnitType -eq 'User') {
		$UnitType = '2'
	}

	$aUnits = $CapaSDK.GetUnitLastRuntime($UnitName, $UnitType)

	return $aUnits
}


<#
	.SYNOPSIS
		Gets units linked to a unit.

	.DESCRIPTION
		Gets linked units for the specified unit by calling the CapaSDK method
		GetUnitLinkedUnits. If that method is deprecated in the SDK, the function
		falls back to GetUnitRelations.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to query linked units for.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.EXAMPLE
		PS C:\> Get-CapaUnitLinkedUnits -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer

		Returns linked units for PC-01.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247500/Get+unit+linked+units
#>
function Get-CapaUnitLinkedUnits {
	[CmdletBinding()]
	[OutputType([pscustomobject[]])]
	param (
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType
	)

	$CanUseLinkedUnitsMethod = $CapaSDK.PSObject.Methods.Name -contains 'GetUnitLinkedUnits'
	$CanUseRelationsMethod = $CapaSDK.PSObject.Methods.Name -contains 'GetUnitRelations'

	if (-not $CanUseLinkedUnitsMethod -and -not $CanUseRelationsMethod) {
		throw 'CapaSDK does not contain method GetUnitLinkedUnits or GetUnitRelations.'
	}

	$aUnits = $null
	$UseRelationsFallback = $false

	if ($CanUseLinkedUnitsMethod) {
		try {
			$aUnits = $CapaSDK.GetUnitLinkedUnits($UnitName, $UnitType)
		} catch {
			if ($CanUseRelationsMethod -and $_.Exception.Message -like '*no longer supported*GetUnitRelations*') {
				$UseRelationsFallback = $true
			} else {
				throw
			}
		}
	} else {
		$UseRelationsFallback = $true
	}

	if ($UseRelationsFallback) {
		$aUnits = $CapaSDK.GetUnitRelations($UnitName, $UnitType)
	}

	if ($null -eq $aUnits) {
		return @()
	}

	$oaUnits = foreach ($sItem in $aUnits) {
		if ([string]::IsNullOrWhiteSpace([string]$sItem)) {
			continue
		}

		if ($UseRelationsFallback) {
			$aItem = [string]$sItem -split ';', 15
			if ($aItem.Count -lt 15) {
				continue
			}

			if ($aItem[9] -eq $UnitType) {
				continue
			}

			[pscustomobject]@{
				Name         = $aItem[1];
				Created      = $aItem[2];
				LastExecuted = $aItem[3];
				Status       = $aItem[4];
				Description  = $aItem[5];
				GUID         = $aItem[7];
				ID           = $aItem[8];
				TypeName     = $aItem[9]
			}
		} else {
			$aItem = [string]$sItem -split ';', 9
			if ($aItem.Count -lt 9) {
				continue
			}

			[pscustomobject]@{
				Name         = $aItem[0];
				Created      = $aItem[1];
				LastExecuted = $aItem[2];
				Status       = $aItem[3];
				Description  = $aItem[4];
				GUID         = $aItem[5];
				ID           = $aItem[7];
				TypeName     = $aItem[8]
			}
		}
	}

	return @($oaUnits)
}


<#
	.SYNOPSIS
		Gets linked user entries for a computer unit.

	.DESCRIPTION
		Gets users linked to the specified computer by calling the CapaSDK method
		GetUnitLinkedUser and returns parsed user objects.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER ComputerName
		Name of the computer unit to query linked users for.

	.EXAMPLE
		PS C:\> Get-CapaUnitLinkedUser -CapaSDK $CapaSDK -ComputerName 'PC-01'

		Returns linked user entries for PC-01.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247510/Get+unit+linked+user
#>
function Get-CapaUnitLinkedUser {
	[CmdletBinding()]
	[OutputType([pscustomobject[]])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$ComputerName
	)

	$CanUseLinkedUserMethod = $CapaSDK.PSObject.Methods.Name -contains 'GetUnitLinkedUser'
	$CanUseRelationsMethod = $CapaSDK.PSObject.Methods.Name -contains 'GetUnitRelations'

	if (-not $CanUseLinkedUserMethod -and -not $CanUseRelationsMethod) {
		throw 'CapaSDK does not contain method GetUnitLinkedUser or GetUnitRelations.'
	}

	$aUnits = $null
	$UseRelationsFallback = $false

	if ($CanUseLinkedUserMethod) {
		try {
			$aUnits = $CapaSDK.GetUnitLinkedUser($ComputerName)
		} catch {
			if ($CanUseRelationsMethod -and $_.Exception.Message -like '*no longer supported*GetUnitRelations*') {
				$UseRelationsFallback = $true
			} else {
				throw
			}
		}
	} else {
		$UseRelationsFallback = $true
	}

	if ($UseRelationsFallback) {
		$aUnits = $CapaSDK.GetUnitRelations($ComputerName, 'Computer')
	}

	if ($null -eq $aUnits) {
		return @()
	}

	$oaUnits = foreach ($sItem in $aUnits) {
		if ([string]::IsNullOrWhiteSpace([string]$sItem)) {
			continue
		}

		if ($UseRelationsFallback) {
			$aItem = [string]$sItem -split ';', 15
			if ($aItem.Count -lt 15) {
				continue
			}

			if ($aItem[9] -ne 'User') {
				continue
			}

			[pscustomobject]@{
				Name         = $aItem[1];
				Created      = $aItem[2];
				LastExecuted = $aItem[3];
				Status       = $aItem[4];
				Description  = $aItem[5];
				GUID         = $aItem[7];
				ID           = $aItem[8];
				TypeName     = $aItem[9]
			}
		} else {
			$aItem = [string]$sItem -split ';', 9
			if ($aItem.Count -lt 9) {
				continue
			}

			[pscustomobject]@{
				Name         = $aItem[0];
				Created      = $aItem[1];
				LastExecuted = $aItem[2];
				Status       = $aItem[3];
				Description  = $aItem[4];
				GUID         = $aItem[5];
				ID           = $aItem[7];
				TypeName     = $aItem[8]
			}
		}
	}

	return @($oaUnits)
}


<#
	.SYNOPSIS
		Gets management point for a unit.

	.DESCRIPTION
		Gets management point data for the specified unit by calling
		the CapaSDK method GetUnitManagementPoint.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to query management point for.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.EXAMPLE
		PS C:\> Get-CapaUnitManagementPoint -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer

		Returns management point information for PC-01.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247520/Get+Unit+Management+Point
#>
function Get-CapaUnitManagementPoint {
	[CmdletBinding()]
	[OutputType([object])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'GetUnitManagementPoint')) {
		throw 'CapaSDK does not contain method GetUnitManagementPoint.'
	}

	$value = $CapaSDK.GetUnitManagementPoint($UnitName, $UnitType)
	return $value
}


<#
	.SYNOPSIS
		Gets management server relation for a unit.

	.DESCRIPTION
		Gets management server relation data for the specified unit by calling
		the CapaSDK method GetUnitManagementServerRelation.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to query relation for.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.EXAMPLE
		PS C:\> Get-CapaUnitManagementServerRelation -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer

		Returns management server relation for PC-01.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247528/Get+unit+management+server+relation
#>
function Get-CapaUnitManagementServerRelation {
	[CmdletBinding()]
	[OutputType([object])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'GetUnitManagementServerRelation')) {
		throw 'CapaSDK does not contain method GetUnitManagementServerRelation.'
	}

	$value = $CapaSDK.GetUnitManagementServerRelation($UnitName, $UnitType)
	return $value
}


<#
	.SYNOPSIS
		Gets packages linked to a unit.

	.DESCRIPTION
		Gets packages linked to a unit by calling the CapaSDK method GetUnitPackages
		and returns parsed package objects.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to query packages for.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.EXAMPLE
		PS C:\> Get-CapaUnitPackages -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer

		Returns packages linked to PC-01.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247544/Get+unit+packages
#>
function Get-CapaUnitPackages {
	[CmdletBinding()]
	[OutputType([pscustomobject[]])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'GetUnitPackages')) {
		throw 'CapaSDK does not contain method GetUnitPackages.'
	}

	$aUnits = $CapaSDK.GetUnitPackages($UnitName, $UnitType)
	if ($null -eq $aUnits) {
		return @()
	}

	$oaUnits = foreach ($sItem in $aUnits) {
		if ([string]::IsNullOrWhiteSpace([string]$sItem)) {
			continue
		}

		$aItem = [string]$sItem -split ';', 16
		if ($aItem.Count -lt 16) {
			continue
		}

		[pscustomobject]@{
			Name               = $aItem[0];
			Version            = $aItem[1];
			Type               = $aItem[2];
			DisplayName        = $aItem[3];
			IsMandatory        = $aItem[4];
			ScheduleId         = $aItem[5];
			Description        = $aItem[7];
			GUID               = $aItem[8];
			ID                 = $aItem[9];
			IsInteractive      = $aItem[10];
			DependendPackageID = $aItem[11];
			IsInventoryPackage = $aItem[12];
			CollectMode        = $aItem[13];
			Priority           = $aItem[14];
			ServerDeploy       = $aItem[15]
		}
	}

	return @($oaUnits)
}


<#
	.SYNOPSIS
		Gets package status for a unit.

	.DESCRIPTION
		Gets the status of a package on a unit by calling the CapaSDK method
		GetUnitPackageStatus.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to query package status for.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.PARAMETER PackageName
		Name of the package.

	.PARAMETER PackageVersion
		Version of the package.

	.EXAMPLE
		PS C:\> Get-CapaUnitPackageStatus -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer -PackageName 'MyPkg' -PackageVersion 'v1.0'

		Returns package status for MyPkg v1.0 on PC-01.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247536/Get+unit+package+status
#>
function Get-CapaUnitPackageStatus {
	[CmdletBinding()]
	[OutputType([object])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$PackageName,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$PackageVersion
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'GetUnitPackageStatus')) {
		throw 'CapaSDK does not contain method GetUnitPackageStatus.'
	}

	if ($UnitType -eq 'Computer') {
		$PackageType = '1'
	} else {
		$PackageType = '2'
	}

	$value = $CapaSDK.GetUnitPackageStatus($UnitName, $UnitType, $PackageName, $PackageVersion, $PackageType)
	return $value
}


<#
	.SYNOPSIS
		Gets relations for a unit.

	.DESCRIPTION
		Gets unit relations by calling the CapaSDK method GetUnitRelations and
		returns parsed relation objects.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to query relations for.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.EXAMPLE
		PS C:\> Get-CapaUnitRelations -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer

		Returns relation rows for unit PC-01.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247554/Get+Unit+Relations
#>
function Get-CapaUnitRelations {
	[CmdletBinding()]
	[OutputType([pscustomobject[]])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true, ValueFromPipeline = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType
	)

	begin {
		if (-not ($CapaSDK.PSObject.Methods.Name -contains 'GetUnitRelations')) {
			throw 'CapaSDK does not contain method GetUnitRelations.'
		}
	}

	process {
		$aRelations = $CapaSDK.GetUnitRelations($UnitName, $UnitType)
		if ($null -eq $aRelations) {
			return @()
		}

		$oaRelations = foreach ($item in $aRelations) {
			if ([string]::IsNullOrWhiteSpace([string]$item)) {
				continue
			}

			$aItem = [string]$item -split ';', 15
			if ($aItem.Count -lt 15) {
				continue
			}

			[pscustomobject]@{
				RelationType = $aItem[0];
				Name         = $aItem[1];
				Created      = $aItem[2];
				LastExecuted = $aItem[3];
				Status       = $aItem[4];
				Description  = $aItem[5];
				GUID         = $aItem[7];
				ID           = $aItem[8];
				TypeName     = $aItem[9];
				UUID         = $aItem[10];
				IsMobile     = $aItem[11];
				Location     = $aItem[12];
				CmpId        = $aItem[13];
				BuId         = $aItem[14]
			}
		}

		return @($oaRelations)
	}
}


<#
	.SYNOPSIS
		Gets units from CapaInstaller.

	.DESCRIPTION
		Gets units by type, or from a specific business unit, by calling CapaSDK.
		If BusinessUnit is provided, data is retrieved with GetUnitsOnBusinessUnit.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER Type
		Optional unit type filter. Valid values are Computer and User.

	.PARAMETER BusinessUnit
		Optional business unit name. When provided, units are fetched from
		the specified business unit.

	.EXAMPLE
		PS C:\> Get-CapaUnits -CapaSDK $CapaSDK -Type Computer

		Returns computer units.

	.EXAMPLE
		PS C:\> Get-CapaUnits -CapaSDK $CapaSDK -BusinessUnit 'Default'

		Returns units on business unit Default.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247572/Get+units
#>
function Get-CapaUnits {
	[CmdletBinding()]
	[OutputType([pscustomobject[]])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $false)]
		[string]$Type = '',
		[Parameter(Mandatory = $false)]
		[AllowEmptyString()]
		[string]$BusinessUnit = ''
	)

	if (-not [string]::IsNullOrWhiteSpace($Type) -and @('Computer', 'User') -notcontains $Type) {
		throw "Type must be either 'Computer' or 'User'."
	}

	if (-not [string]::IsNullOrWhiteSpace($BusinessUnit) -and -not ($CapaSDK.PSObject.Methods.Name -contains 'GetUnitsOnBusinessUnit')) {
		throw 'CapaSDK does not contain method GetUnitsOnBusinessUnit.'
	}

	if ([string]::IsNullOrWhiteSpace($BusinessUnit) -and -not ($CapaSDK.PSObject.Methods.Name -contains 'GetUnits')) {
		throw 'CapaSDK does not contain method GetUnits.'
	}

	if ([string]::IsNullOrWhiteSpace($BusinessUnit)) {
		$aUnits = $CapaSDK.GetUnits($Type)
	} else {
		if ([string]::IsNullOrWhiteSpace($Type)) {
			$aUnits = $CapaSDK.GetUnitsOnBusinessUnit($BusinessUnit)
		} else {
			$aUnits = $CapaSDK.GetUnitsOnBusinessUnit($BusinessUnit, $Type)
		}
	}

	if ($null -eq $aUnits) {
		return @()
	}

	$oaUnits = foreach ($sItem in $aUnits) {
		if ([string]::IsNullOrWhiteSpace([string]$sItem)) {
			continue
		}

		$aItem = [string]$sItem -split ';', 11
		if ($aItem.Count -lt 11) {
			continue
		}

		[pscustomobject]@{
			Name           = $aItem[0];
			Created        = $aItem[1];
			LastExecuted   = $aItem[2];
			Status         = $aItem[3];
			Description    = $aItem[4];
			GUID           = $aItem[5];
			ID             = $aItem[6];
			TypeName       = $aItem[7];
			UUID           = $aItem[8];
			IsMobileDevice = $aItem[9];
			Location       = $aItem[10]
		}
	}

	return @($oaUnits)
}


<#
	.SYNOPSIS
		Gets units located in a specific folder.

	.DESCRIPTION
		Gets units in the specified folder for a given business unit and unit type
		by calling the CapaSDK method GetUnitsInFolder.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER FolderStructure
		Folder path to query within the selected business unit.

	.PARAMETER UnitType
		Type of units to return. Valid values are Computer and User.

	.PARAMETER BusinessUnitName
		Name of the business unit to query in.

	.EXAMPLE
		PS C:\> Get-CapaUnitsInFolder -CapaSDK $CapaSDK -FolderStructure 'Devices\\Laptops' -UnitType Computer -BusinessUnitName 'Default'

		Returns computer units in folder Devices\Laptops under business unit Default.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247582/Get+Units+in+Folder
#>
function Get-CapaUnitsInFolder {
	[CmdletBinding()]
	[OutputType([pscustomobject[]])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$FolderStructure,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$BusinessUnitName
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'GetUnitsInFolder')) {
		throw 'CapaSDK does not contain method GetUnitsInFolder.'
	}

	$aUnits = $CapaSDK.GetUnitsInFolder($FolderStructure, $UnitType, $BusinessUnitName)
	if ($null -eq $aUnits) {
		return @()
	}

	$oaUnits = foreach ($sItem in $aUnits) {
		if ([string]::IsNullOrWhiteSpace([string]$sItem)) {
			continue
		}

		$aItem = [string]$sItem -split ';', 12
		if ($aItem.Count -lt 12) {
			continue
		}

		[pscustomobject]@{
			Name           = $aItem[0];
			Created        = $aItem[1];
			LastExecuted   = $aItem[2];
			Status         = $aItem[3];
			Description    = $aItem[4];
			GUID           = $aItem[5];
			ID             = $aItem[7];
			TypeName       = $aItem[8];
			UUID           = $aItem[9];
			IsMobileDevice = $aItem[10];
			Location       = $aItem[11]
		}
	}

	return @($oaUnits)
}


<#
	.SYNOPSIS
		Gets WSUS group relation data for a unit.

	.DESCRIPTION
		Gets the WSUS group relation for the specified unit by calling
		the CapaSDK method GetUnitWSUSGroup.

	.PARAMETER CapaSDK
		The initialized CapaSDK instance from Initialize-CapaSDK.

	.PARAMETER UnitName
		Name of the unit to query.

	.PARAMETER UnitType
		Type of unit. Valid values are Computer and User.

	.EXAMPLE
		PS C:\> Get-CapaUnitWSUSGroup -CapaSDK $CapaSDK -UnitName 'PC-01' -UnitType Computer

		Returns WSUS group relation data for unit PC-01.

	.NOTES
		For more information, see:
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247564/Get+unit+WSUS+Group
#>
function Get-CapaUnitWSUSGroup {
	[CmdletBinding()]
	[OutputType([object])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'GetUnitWSUSGroup')) {
		throw 'CapaSDK does not contain method GetUnitWSUSGroup.'
	}

	$value = $CapaSDK.GetUnitWSUSGroup($UnitName, $UnitType)
	return $value
}


<#
	.SYNOPSIS
		Remove a unit by UUID.

	.DESCRIPTION
		Delete an existing unit by UUID in CapaInstaller.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER UUID
		The UUID of the unit to delete.

	.EXAMPLE
		PS C:\> Remove-CapaUnitByUUID -CapaSDK $CapaSDK -UUID '12345678-1234-1234-1234-123456789012'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247372/Delete+unit
#>
function Remove-CapaUnitByUUID {
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[ValidatePattern('^[{(]?[0-9a-fA-F]{8}[-]?[0-9a-fA-F]{4}[-]?[0-9a-fA-F]{4}[-]?[0-9a-fA-F]{4}[-]?[0-9a-fA-F]{12}[)}]?$')]
		[string]$UUID
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'DeleteUnitByUUID')) {
		throw 'CapaSDK does not contain method DeleteUnitByUUID.'
	}

	if ($PSCmdlet.ShouldProcess($UUID, 'Delete unit by UUID')) {
		$bool = $CapaSDK.DeleteUnitByUUID($UUID)
		return $bool
	}
}


<#
	.SYNOPSIS
		Remove a unit from a business unit.

	.DESCRIPTION
		Remove an existing unit from a business unit relation in CapaInstaller.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER UnitName
		The unit name.

	.PARAMETER UnitType
		The unit type.

	.EXAMPLE
		PS C:\> Remove-CapaUnitFromBusinessUnit -CapaSDK $CapaSDK -UnitName 'PC001' -UnitType Computer

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247648/Remove+unit+from+business+unit
#>
function Remove-CapaUnitFromBusinessUnit {
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'RemoveUnitFromBusinessUnit')) {
		throw 'CapaSDK does not contain method RemoveUnitFromBusinessUnit.'
	}

	$target = "$UnitType unit '$UnitName'"
	$action = 'Remove from business unit'
	if ($PSCmdlet.ShouldProcess($target, $action)) {
		$value = $CapaSDK.RemoveUnitFromBusinessUnit($UnitName, $UnitType)
		return $value
	}
}


<#
	.SYNOPSIS
		Remove a unit from a calendar group.

	.DESCRIPTION
		Remove an existing unit from a calendar group in CapaInstaller.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER UnitName
		The unit name.

	.PARAMETER UnitType
		The unit type.

	.PARAMETER CalendarGroupName
		The calendar group name.

	.EXAMPLE
		PS C:\> Remove-CapaUnitFromCalendarGroup -CapaSDK $CapaSDK -UnitName 'PC001' -UnitType Computer -CalendarGroupName 'Workstations - Nightly'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247656/Remove+unit+from+calendar+group
#>
function Remove-CapaUnitFromCalendarGroup {
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$CalendarGroupName
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'RemoveUnitFromCalendarGroup')) {
		throw 'CapaSDK does not contain method RemoveUnitFromCalendarGroup.'
	}

	$target = "$UnitType unit '$UnitName'"
	$action = "Remove from calendar group '$CalendarGroupName'"
	if ($PSCmdlet.ShouldProcess($target, $action)) {
		$value = $CapaSDK.RemoveUnitFromCalendarGroup($UnitName, $UnitType, $CalendarGroupName)
		return $value
	}
}


<#
	.SYNOPSIS
		Remove a unit from a group.

	.DESCRIPTION
		Remove an existing unit from a group in CapaInstaller.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER UnitName
		The unit name.

	.PARAMETER UnitType
		The unit type.

	.PARAMETER GroupName
		The group name.

	.PARAMETER GroupType
		The group type.

	.EXAMPLE
		PS C:\> Remove-CapaUnitFromGroup -CapaSDK $CapaSDK -UnitName 'PC001' -UnitType Computer -GroupName 'Test Group' -GroupType Static

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247664/Remove+unit+from+group
#>
function Remove-CapaUnitFromGroup {
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Dynamic_ADSI', 'Calendar', 'Department', 'Dynamic_SQL', 'Reinstall', 'Security', 'Static')]
		[string]$GroupType
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'RemoveUnitFromGroup')) {
		throw 'CapaSDK does not contain method RemoveUnitFromGroup.'
	}

	$target = "$UnitType unit '$UnitName'"
	$action = "Remove from group '$GroupName' ($GroupType)"
	if ($PSCmdlet.ShouldProcess($target, $action)) {
		$bool = $CapaSDK.RemoveUnitFromGroup($UnitName, $UnitType, $GroupName, $GroupType)
		return $bool
	}
}


<#
	.SYNOPSIS
		Remove a unit from a package.

	.DESCRIPTION
		Remove package relation from an existing unit in CapaInstaller.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER PackageName
		The package name.

	.PARAMETER PackageVersion
		The package version.

	.PARAMETER PackageType
		The package type.

	.PARAMETER UnitName
		The unit name.

	.PARAMETER UnitType
		The unit type.

	.EXAMPLE
		PS C:\> Remove-CapaUnitFromPackage -CapaSDK $CapaSDK -PackageName '7-Zip' -PackageVersion '24.09' -PackageType Computer -UnitName 'PC001' -UnitType Computer

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247672/Remove+unit+from+package
#>
function Remove-CapaUnitFromPackage {
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User', '1', '2')]
		[string]$PackageType,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'RemoveUnitFromPackage')) {
		throw 'CapaSDK does not contain method RemoveUnitFromPackage.'
	}

	switch ($PackageType) {
		'Computer' { $PackageType = '1' }
		'User' { $PackageType = '2' }
	}

	$target = "$UnitType unit '$UnitName'"
	$action = "Remove package '$PackageName' version '$PackageVersion'"
	if ($PSCmdlet.ShouldProcess($target, $action)) {
		$bool = $CapaSDK.RemoveUnitFromPackage($UnitName, $UnitType, $PackageName, $PackageVersion, $PackageType)
		return $bool
	}
}


<#
	.SYNOPSIS
		Remove a unit from reinstall.

	.DESCRIPTION
		Remove an existing computer from reinstall in CapaInstaller.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER ComputerName
		The name of the computer.

	.EXAMPLE
		PS C:\> Remove-CapaUnitFromReinstall -CapaSDK $CapaSDK -ComputerName 'PC001'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247680/Remove+unit+from+reinstall
#>
function Remove-CapaUnitFromReinstall {
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$ComputerName
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'RemoveUnitFromReinstall')) {
		throw 'CapaSDK does not contain method RemoveUnitFromReinstall.'
	}

	if ($PSCmdlet.ShouldProcess($ComputerName, 'Remove unit from reinstall')) {
		$value = $CapaSDK.RemoveUnitFromReinstall($ComputerName)
		return $value
	}
}


<#
	.SYNOPSIS
		Rename an existing unit.

	.DESCRIPTION
		Rename an existing unit in CapaInstaller.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER CurrentUnitName
		The current unit name.

	.PARAMETER UnitType
		The unit type.

	.PARAMETER NewUnitName
		The new unit name.

	.EXAMPLE
		PS C:\> Rename-CapaUnit -CapaSDK $CapaSDK -CurrentUnitName 'PC001' -UnitType Computer -NewUnitName 'PC001-RENAMED'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247688/Rename+unit
#>
function Rename-CapaUnit {
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]
		$CurrentUnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]
		$UnitType,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]
		$NewUnitName
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'RenameUnit')) {
		throw 'CapaSDK does not contain method RenameUnit.'
	}

	$target = "$UnitType unit '$CurrentUnitName'"
	$action = "Rename to '$NewUnitName'"
	if ($PSCmdlet.ShouldProcess($target, $action)) {
		$value = $CapaSDK.RenameUnit($CurrentUnitName, $UnitType, $NewUnitName)
		return $value
	}
}


<#
	.SYNOPSIS
		Send a command to a unit.

	.DESCRIPTION
		Send a unit command to an existing device in CapaInstaller.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER DeviceUUID
		The UUID of the device.

	.PARAMETER Command
		The command to send to the device.

	.PARAMETER ChangelogComment
		Changelog comment for the action.

	.EXAMPLE
		PS C:\> Send-CapaUnitCommand -CapaSDK $CapaSDK -DeviceUUID '12345678-1234-1234-1234-123456789012' -Command SWInventory -ChangelogComment 'Run inventory from PowerShell'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247704/Send+Unit+Command
#>
function Send-CapaUnitCommand {
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[ValidatePattern('^[{(]?[0-9a-fA-F]{8}[-]?[0-9a-fA-F]{4}[-]?[0-9a-fA-F]{4}[-]?[0-9a-fA-F]{4}[-]?[0-9a-fA-F]{12}[)}]?$')]
		[String]$DeviceUUID,
		[Parameter(Mandatory = $true)]
		[ValidateSet('SWInventory', 'HWInventory', 'SecInventory', 'ManagedSoftwareInventory', 'RestartDevice', 'ShutdownDevice', 'Lock', 'PasswordReset', 'Wipe')]
		[String]$Command,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$ChangelogComment
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'SendUnitCommand')) {
		throw 'CapaSDK does not contain method SendUnitCommand.'
	}

	$target = "Device '$DeviceUUID'"
	$action = "Send command '$Command'"
	if ($PSCmdlet.ShouldProcess($target, $action)) {
		$value = $CapaSDK.SendUnitCommand($DeviceUUID, $Command, $ChangelogComment)
		return $value
	}
}


<#
	.SYNOPSIS
		Set the description on a unit.

	.DESCRIPTION
		Set or update description for an existing unit in CapaInstaller.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER UnitName
		The name of the unit.

	.PARAMETER UnitType
		The unit type.

	.PARAMETER Description
		The description value to set. Leave empty string to clear description.

	.EXAMPLE
		PS C:\> Set-CapaUnitDescription -CapaSDK $CapaSDK -UnitName 'PC001' -UnitType Computer -Description 'Production workstation'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247724/Set+unit+description
#>
function Set-CapaUnitDescription {
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType,
		[String]$Description = ''
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'SetUnitDescription')) {
		throw 'CapaSDK does not contain method SetUnitDescription.'
	}

	$target = "$UnitType unit '$UnitName'"
	$action = "Set description"
	if ($PSCmdlet.ShouldProcess($target, $action)) {
		$value = $CapaSDK.SetUnitDescription($UnitName, $UnitType, $Description)
		return $value
	}
}


<#
	.SYNOPSIS
		Set the label on a unit.

	.DESCRIPTION
		Set or update the label for an existing unit in CapaInstaller.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER UnitName
		The name of the unit.

	.PARAMETER UnitType
		The unit type.

	.PARAMETER Label
		The label value to set.

	.EXAMPLE
		PS C:\> Set-CapaUnitLabel -CapaSDK $CapaSDK -UnitName 'PC001' -UnitType Computer -Label 'Production'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247732/Set+unit+label
#>
function Set-CapaUnitLabel {
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$Label
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'SetUnitLabel')) {
		throw 'CapaSDK does not contain method SetUnitLabel.'
	}

	$target = "$UnitType unit '$UnitName'"
	$action = "Set label to '$Label'"
	if ($PSCmdlet.ShouldProcess($target, $action)) {
		$value = $CapaSDK.SetUnitLabel($UnitName, $UnitType, $Label)
		return $value
	}
}


<#
	.SYNOPSIS
		Set the name of a unit.

	.DESCRIPTION
		Set a new name on an existing unit in CapaInstaller.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER UnitName
		The current unit name.

	.PARAMETER UnitType
		The unit type.

	.PARAMETER Name
		The new unit name.

	.EXAMPLE
		PS C:\> Set-CapaUnitName -CapaSDK $CapaSDK -UnitName 'PC001' -UnitType Computer -Name 'PC001-RENAMED'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247740/Set+unit+name
#>
function Set-CapaUnitName {
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$Name
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'SetUnitName')) {
		throw 'CapaSDK does not contain method SetUnitName.'
	}

	$target = "$UnitType unit '$UnitName'"
	$action = "Set name to '$Name'"
	if ($PSCmdlet.ShouldProcess($target, $action)) {
		$value = $CapaSDK.SetUnitName($UnitName, $UnitType, $Name)
		return $value
	}
}


<#
	.SYNOPSIS
		Set package status for a unit.

	.DESCRIPTION
		Set package status for a unit in CapaInstaller.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER UnitName
		The name of the unit.

	.PARAMETER UnitType
		The unit type.

	.PARAMETER PackageName
		The name of the package.

	.PARAMETER PackageVersion
		The package version.

	.PARAMETER Status
		The package status to set.

	.PARAMETER ChangelogComment
		Optional changelog comment.

	.EXAMPLE
		PS C:\> Set-CapaUnitPackageStatus -CapaSDK $CapaSDK -UnitName 'PC001' -UnitType Computer -PackageName '7-Zip' -PackageVersion '24.09' -Status Installed

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247748/Set+unit+package+status
#>
function Set-CapaUnitPackageStatus {
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$PackageName,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Waiting', 'Failed', 'Installed', 'Uninstall', 'Cancel')]
		[String]$Status,
		[String]$ChangelogComment = ''
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'SetUnitPackageStatus')) {
		throw 'CapaSDK does not contain method SetUnitPackageStatus.'
	}

	switch ($UnitType) {
		'Computer' { $PackageType = '1' }
		'User' { $PackageType = '2' }
		default { throw "Unsupported UnitType '$UnitType'." }
	}

	$target = "$UnitType unit '$UnitName'"
	$action = "Set package '$PackageName' version '$PackageVersion' status to '$Status'"
	if ($PSCmdlet.ShouldProcess($target, $action)) {
		$value = $CapaSDK.SetUnitPackageStatus($UnitName, $UnitType, $PackageName, $PackageVersion, $PackageType, $Status, $ChangelogComment)
		return $value
	}
}


<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247758/Set+unit+status

	.DESCRIPTION
		A detailed description of the Set-CapaUnitStatus function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName parameter.

	.PARAMETER Status
		A description of the Status parameter.

	.EXAMPLE
				PS C:\> Set-CapaUnitStatus -CapaSDK $value1 -UnitName "" -Status ""

	.NOTES
		Additional information about the function.
#>
function Set-CapaUnitStatus {
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
	[OutputType([object])]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$UnitName = '',
		[Parameter(Mandatory = $true)]
		[ValidateSet('Active', 'Inactive')]
		[string]$Status = ''
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'SetUnitStatus')) {
		throw 'CapaSDK does not contain method SetUnitStatus.'
	}

	if ($PSCmdlet.ShouldProcess($UnitName, "Set unit status to '$Status'")) {
		$aUnits = $CapaSDK.SetUnitStatus($UnitName, $Status)
		return $aUnits
	}
}



