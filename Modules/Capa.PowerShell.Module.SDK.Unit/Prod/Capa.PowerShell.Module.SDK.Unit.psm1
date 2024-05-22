
# TODO: #197 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247286/Add+printer+to+unit

	.DESCRIPTION
		A detailed description of the Add-CapaPrinterToUnit function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName  parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.PARAMETER PrinterShareName
		A description of the PrinterShareName  parameter.

	.EXAMPLE
				PS C:\> Add-CapaPrinterToUnit -CapaSDK $value1 -UnitName  'Value2' -UnitType Computer -PrinterShareName  'Value4'

	.NOTES
		Additional information about the function.
#>
function Add-CapaPrinterToUnit {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType,
		[Parameter(Mandatory = $true)]
		[String]$PrinterShareName
	)

	$value = $CapaSDK.AddPrinterToUnit($UnitName, $UnitType, $PrinterShareName)
	return $value
}


# TODO: #198 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247294/Add+unit+to+business+unit

	.DESCRIPTION
		A detailed description of the Add-CapaUnitToBusinessUnit function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.PARAMETER BusinessUnit
		A description of the BusinessUnit parameter.

	.EXAMPLE
				PS C:\> Add-CapaUnitToBusinessUnit -CapaSDK $value1 -UnitName 'Value2' -UnitType Computer -BusinessUnit 'Value4'

	.NOTES
		Additional information about the function.
#>
function Add-CapaUnitToBusinessUnit {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType,
		[Parameter(Mandatory = $true)]
		[string]$BusinessUnit
	)

	$value = $CapaSDK.AddUnitToBusinessUnit($UnitName, $UnitType, $BusinessUnit)

	return $value
}


# TODO: #199 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247302/Add+unit+to+calendar+group

	.DESCRIPTION
		A detailed description of the Add-CapaUnitToCalendarGroup function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName  parameter.

	.PARAMETER UnitType
		A description of the UnitType  parameter.

	.PARAMETER CalendarGroupName
		A description of the CalendarGroupName parameter.

	.EXAMPLE
				PS C:\> Add-CapaUnitToCalendarGroup -CapaSDK $value1 -UnitName  'Value2' -UnitType  'Value3' -CalendarGroupName 'Value4'

	.NOTES
		Additional information about the function.
#>
function Add-CapaUnitToCalendarGroup {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[String]$UnitType,
		[Parameter(Mandatory = $true)]
		[String]$CalendarGroupName
	)

	$value = $CapaSDK.AddUnitToCalendarGroup($UnitName, $UnitType, $CalendarGroupName)
	return $value
}


# TODO: #200 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247310/Add+unit+to+folder

	.DESCRIPTION
		A detailed description of the Add-CapaUnitToFolder function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.PARAMETER FolderStructure
		A description of the FolderStructure parameter.

	.PARAMETER CreateFolder
		Default is false

	.EXAMPLE
				PS C:\> Add-CapaUnitToFolder -CapaSDK $value1 -UnitName "" -UnitType "" -FolderStructure ""

	.NOTES
		Additional information about the function.
#>
function Add-CapaUnitToFolder {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$UnitName = '',
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType = '',
		[Parameter(Mandatory = $true)]
		[string]$FolderStructure = '',
		[ValidateSet('true', 'false')]
		[string]$CreateFolder
	)

	$aUnits = $CapaSDK.AddUnitToFolder($UnitName, $UnitType, $FolderStructure, $CreateFolder)

	Return $aUnits
}


# TODO: #201 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247318/Add+unit+to+group
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247332/Add+unit+to+group+BU

	.DESCRIPTION
		A detailed description of the Add-CapaUnitToGroup function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.PARAMETER GroupName
		A description of the GroupName parameter.

	.PARAMETER GroupType
		A description of the GroupType parameter.

	.PARAMETER BusinessUnitName
		A description of the BusinessUnitName parameter.

	.EXAMPLE
		PS C:\> Add-CapaUnitToGroup -CapaSDK $value1 -UnitName 'Value2' -UnitType Computer -GroupName 'Value4' -GroupType Calendar

	.NOTES
		Additional information about the function.
#>
function Add-CapaUnitToGroup {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User', 'Printer')]
		[string]$UnitType,
		[Parameter(Mandatory = $true)]
		[string]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Calendar', 'Department', 'Reinstall', 'Security', 'Static', 'Dynamic_SQL', 'Dynamic_ADSI')]
		[string]$GroupType,
		[String]$BusinessUnitName
	)

	if (($GroupType -eq 'Dynamic_SQL' -or $GroupType -eq 'Dynamic_ADSI') -and $UnitType -ne 'Printer') {
		Write-Error "GroupType $GroupType only works for UnitType Printer"
		return 'False'
	} else {
		if ([string]::IsNullOrEmpty($BusinessUnitName) -eq $false) {
			$value = $CapaSDK.AddUnitToGroupBU($UnitName, $UnitType, $GroupName, $GroupType, $BusinessUnitName)
		} else {
			$value = $CapaSDK.AddUnitToGroup($UnitName, $UnitType, $GroupName, $GroupType)
		}

		return $value
	}
}


# TODO: #202 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247340/Add+unit+to+package

	.DESCRIPTION
		A detailed description of the Add-CapaUnitToPackage function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER PackageType
		A description of the PackageType parameter.

	.PARAMETER PackageName
		A description of the PackageName parameter.

	.PARAMETER PackageVersion
		A description of the PackageVersion parameter.

	.PARAMETER UnitName
		A description of the UnitName parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.EXAMPLE
		PS C:\> Add-CapaUnitToPackage -CapaSDK $CapaSDK -PackageType Computer -PackageName 'value3' -PackageVersion 'value4' -UnitName 'value5' -UnitType Computer

	.NOTES
		Additional information about the function.
#>
function Add-CapaUnitToPackage {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User', '1', '2')]
		[string]$PackageType,
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType
	)
	if ($PackageType -eq 'Computer') {
		$PackageType = '1'
	} elseif ($PackageType -eq 'User') {
		$PackageType = '2'
	}

	$bool = $CapaSDK.AddUnitToPackage($UnitName, $UnitType, $PackageName, $PackageVersion, $PackageType)

	Return $bool
}


# TODO: #203 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247348/Add+unit+to+reinstall

	.DESCRIPTION
		A detailed description of the Add-CapaUnitToReinstall function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER ComputerName
		A description of the ComputerName parameter.

	.PARAMETER OSpointID
		A description of the OSpointID parameter.

	.PARAMETER OSserverID
		A description of the OSserverID parameter.

	.PARAMETER OSImageID
		A description of the OSImageID parameter.

	.PARAMETER DiskConfigID
		A description of the DiskConfigID parameter.

	.PARAMETER InstallTypeID
		A description of the InstallTypeID parameter.

	.PARAMETER NewUnitName
		A description of the NewUnitName parameter.

	.PARAMETER ReinstallMode
		A description of the ReinstallMode parameter.

	.PARAMETER Active
		A description of the Active parameter.

	.PARAMETER UnlinkAllPackagesAndGroups
		A description of the UnlinkAllPackagesAndGroups parameter.

	.PARAMETER UnlinkAllAdvPackages
		A description of the UnlinkAllAdvPackages parameter.

	.PARAMETER ChangelogComment
		A description of the ChangelogComment parameter.

	.PARAMETER ReinstallStartDate
		A description of the ReinstallStartDate parameter.

	.PARAMETER CustomField1
		A description of the CustomField1 parameter.

	.PARAMETER CustomField2
		A description of the CustomField2 parameter.

	.EXAMPLE
				PS C:\> Add-CapaUnitToReinstall -CapaSDK $value1 -ComputerName 'Value2' -OSpointID $value3 -OSserverID $value4 -OSImageID $value5 -DiskConfigID $value6 -InstallTypeID $value7

	.NOTES
		Additional information about the function.
#>
function Add-CapaUnitToReinstall {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[Alias('UUID')]
		[String]$ComputerName,
		[Parameter(Mandatory = $true)]
		[int]$OSpointID,
		[Parameter(Mandatory = $true)]
		[int]$OSserverID,
		[Parameter(Mandatory = $true)]
		[int]$OSImageID,
		[Parameter(Mandatory = $true)]
		[int]$DiskConfigID,
		[Parameter(Mandatory = $true)]
		[int]$InstallTypeID,
		[String]$NewUnitName = '',
		[Parameter(Mandatory = $false)]
		[ValidateSet('Silent', 'AlwaysConfirm', 'ConfirmOnlyIfUserLoggedOn')]
		[String]$ReinstallMode = 'Silent',
		[ValidateSet('True', 'False')]
		[bool]$Active = $true,
		[ValidateSet('True', 'False')]
		[bool]$UnlinkAllPackagesAndGroups = $false,
		[ValidateSet('True', 'False')]
		[bool]$UnlinkAllAdvPackages = $false,
		[String]$ChangelogComment = '',
		[String]$ReinstallStartDate = '',
		[String]$CustomField1 = '',
		[String]$CustomField2 = ''
	)

	$value = $CapaSDK.AddUnitToReinstall($ComputerName, $OSpointID, $OSserverID, $OSImageID, $DiskConfigID, $InstallTypeID, $NewUnitName, $ReinstallMode, $Active, $UnlinkAllPackagesAndGroups, $ChangelogComment, $ReinstallStartDate, $CustomField1, $CustomField2)
	return $value
}


# TODO: #204 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247364/Create+unit

	.DESCRIPTION
		A detailed description of the Create-CapaUnit function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName  parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.PARAMETER LinkToManagementServerID
		A description of the LinkToManagementServerID  parameter.

	.PARAMETER Status
		A description of the Status parameter.

	.PARAMETER Uuid
		A description of the Uuid  parameter.

	.PARAMETER SerialNumber
		A description of the SerialNumber  parameter.

	.PARAMETER UnitDeviceType
		A description of the UnitDeviceType parameter.

	.EXAMPLE
				PS C:\> Create-CapaUnit -CapaSDK $value1 -UnitName  'Value2' -UnitType Computer -LinkToManagementServerID  $value4

	.NOTES
		Additional information about the function.
#>
function Create-CapaUnit {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType,
		[Parameter(Mandatory = $true)]
		[int]$LinkToManagementServerID,
		[Parameter(Mandatory = $false)]
		[ValidateSet('Active', 'Inactive')]
		[String]$Status = 'Active',
		[String]$Uuid = '',
		[String]$SerialNumber = '',
		[ValidateSet('Windows', 'OSX', 'iOS', 'Android', 'WindowsPhone')]
		[String]$UnitDeviceType = ''
	)

	if ($UnitDeviceType -eq '') {
		$value = $CapaSDK.CreateUnit($UnitName, $UnitType, $LinkToManagementServerID, $Status)
	} else {
		$value = $CapaSDK.CreateUnit($UnitName, $UnitType, $LinkToManagementServerID, $Status, $Uuid, $SerialNumber, $UnitDeviceType)
	}

	return $value
}


# TODO: #205 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247372/Delete+unit

	.DESCRIPTION
		A detailed description of the Delete-CapaUnit function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName  parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.EXAMPLE
				PS C:\> Delete-CapaUnit -CapaSDK $value1 -UnitName  'Value2' -UnitType Computer

	.NOTES
		Additional information about the function.
#>
function Delete-CapaUnit {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType
	)

	$value = $CapaSDK.DeleteUnit($UnitName, $UnitType)
	return $value
}


# TODO: #206 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247388/Exist+unit
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247418/Exist+uuid

	.DESCRIPTION
		A detailed description of the Exist-CapaUnit function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.PARAMETER Uuid
		A description of the Uuid  parameter.

	.EXAMPLE
		PS C:\> Exist-CapaUnit -CapaSDK $value1 -UnitName 'Value2' -UnitType Computer

	.NOTES
		Additional information about the function.
#>
function Exist-CapaUnit {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(ParameterSetName = 'NameType',
			Mandatory = $true)]
		[String]$UnitName,
		[Parameter(ParameterSetName = 'NameType',
			Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType,
		[Parameter(ParameterSetName = 'Uuid',
			Mandatory = $true)]
		[String]$Uuid
	)

	if ($PSCmdlet.ParameterSetName -eq 'NameType') {
		$value = $CapaSDK.ExistUnit($UnitName, $UnitType)
	} else {
		$value = $CapaSDK.ExistUUID($Uuid)
	}

	return $value
}


# TODO: #207 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247402/Exist+unit+location

	.DESCRIPTION
		A detailed description of the Exist-CapaUnitLocation function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.PARAMETER Location
		A description of the Location parameter.

	.EXAMPLE
				PS C:\> Exist-CapaUnitLocation -CapaSDK $value1 -UnitName 'Value2' -UnitType Computer -Location 'Value4'

	.NOTES
		Additional information about the function.
#>
function Exist-CapaUnitLocation {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType,
		[Parameter(Mandatory = $true)]
		[String]$Location
	)

	$value = $CapaSDK.ExistUnitLocation($UnitName, $UnitType, $Location)
	return $value
}


# TODO: #208 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247410/Exist+Unit+On+Management+Point

	.DESCRIPTION
		A detailed description of the Exist-CapaUnitOnManagementPoint function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName  parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.PARAMETER CMPID
		A description of the CMPID  parameter.

	.EXAMPLE
		PS C:\> Exist-CapaUnitOnManagementPoint -CapaSDK $value1 -UnitName  $value2 -UnitType Computer -CMPID  $value4

	.NOTES
		Additional information about the function.
#>
function Exist-CapaUnitOnManagementPoint {
	[CmdletBinding(DefaultParameterSetName = 'NameType')]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		$UnitType,
		[Parameter(Mandatory = $true)]
		$CMPID
	)

	$value = $CapaSDK.ExistUnitOnManagementPoint($UnitName, $UnitType, $CMPID)
	return $value
}


# TODO: #209 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247474/Get+unit+description

	.DESCRIPTION
		A detailed description of the Get-CapaUnitDescription function.

	.EXAMPLE
				PS C:\> Get-CapaUnitDescription

	.NOTES
		Additional information about the function.
#>
function Get-CapaUnitDescription {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		$UnitType
	)

	$value = $CapaSDK.GetUnitDescription($UnitName, $UnitType)
	return $value
}


# TODO: #210 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247632/GetUnitFolder

	.DESCRIPTION
		A detailed description of the Get-CapaUnitFolder function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.EXAMPLE
				PS C:\> Get-CapaUnitFolder -CapaSDK $value1 -UnitName 'Value2' -UnitType Computer

	.NOTES
		Additional information about the function.
#>
function Get-CapaUnitFolder {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType
	)

	$bool = $CapaSDK.GetUnitFolder($UnitName, $UnitType)

	Return $bool
}


# TODO: #211 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247482/Get+unit+groups

	.DESCRIPTION
		A detailed description of the Get-CapaUnitGroups function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.EXAMPLE
				PS C:\> Get-CapaUnitGroups -CapaSDK $value1 -UnitName 'Value2' -UnitType Computer

	.NOTES
		Additional information about the function.
#>
function Get-CapaUnitGroups {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType
	)

	$oaUnits = @()

	$aUnits = $CapaSDK.GetUnitGroups($UnitName, $UnitType)
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Name        = $aItem[0];
			Type        = $aItem[1];
			unitTypeID  = $aItem[2];
			Description = $aItem[3];
			GUID        = $aItem[4];
			ID          = $aItem[5]
		}
	}

	Return $oaUnits
}


# TODO: #212 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247492/Get+unit+last+runtime

	.DESCRIPTION
		A detailed description of the Get-CapaUnitLastRuntime function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.EXAMPLE
				PS C:\> Get-CapaUnitLastRuntime -CapaSDK $value1 -UnitName "" -UnitType ""

	.NOTES
		Additional information about the function.
#>
function Get-CapaUnitLastRuntime {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$UnitName = '',
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User', '1', '2')]
		[string]$UnitType = ''
	)

	if ($UnitType -eq 'Computer') {
		$UnitType = '1'
	} else {
		$UnitType = '2'
	}

	$aUnits = $CapaSDK.GetUnitLastRuntime($UnitName, $UnitType)

	Return $aUnits
}


# TODO: #213 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247500/Get+unit+linked+units

	.DESCRIPTION
		A detailed description of the Get-CapaUnitLinkedUnits function.

	.EXAMPLE
				PS C:\> Get-CapaUnitLinkedUnits

	.NOTES
		Additional information about the function.
#>
function Get-CapaUnitLinkedUnits {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		$UnitType
	)

	$oaUnits = @()

	$aUnits = $CapaSDK.GetUnitLinkedUnits($UnitName, $UnitType)

	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
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

	Return $oaUnits
}


# TODO: #214 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247510/Get+unit+linked+user

	.DESCRIPTION
		A detailed description of the Get-CapaUnitLinkedUser function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER ComputerName
		A description of the ComputerName  parameter.

	.EXAMPLE
				PS C:\> Get-CapaUnitLinkedUser -CapaSDK $value1 -ComputerName  'Value2'

	.NOTES
		Additional information about the function.
#>
function Get-CapaUnitLinkedUser {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$ComputerName
	)

	$oaUnits = @()

	$aUnits = $CapaSDK.GetUnitLinkedUser($ComputerName)

	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
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

	Return $oaUnits
}


# TODO: #215 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247520/Get+Unit+Management+Point

	.DESCRIPTION
		A detailed description of the Get-CapaUnitManagementPoint function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName  parameter.

	.PARAMETER UnitType
		A description of the UnitType  parameter.

	.EXAMPLE
		PS C:\> Get-CapaUnitManagementPoint

	.NOTES
		Additional information about the function.
#>
function Get-CapaUnitManagementPoint {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType
	)

	$value = $CapaSDK.GetUnitManagementPoint($UnitName, $UnitType)
	return $value
}


# TODO: #217 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247528/Get+unit+management+server+relation

	.DESCRIPTION
		A detailed description of the Get-CapaUnitManagementServerRelation function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName  parameter.

	.PARAMETER UnitType
		A description of the UnitType  parameter.

	.EXAMPLE
				PS C:\> Get-CapaUnitManagementServerRelation -CapaSDK $value1 -UnitName  'Value2' -UnitType  'Value3'

	.NOTES
		Additional information about the function.
#>
function Get-CapaUnitManagementServerRelation {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[String]$UnitType
	)

	$value = $CapaSDK.GetUnitManagementServerRelation($UnitName, $UnitType)
	return $value
}


# TODO: #219 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247544/Get+unit+packages

	.DESCRIPTION
		A detailed description of the Get-CapaUnitPackages function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.EXAMPLE
				PS C:\> Get-CapaUnitPackages -CapaSDK $value1 -UnitName $value2 -UnitType Computer

	.NOTES
		Additional information about the function.
#>
function Get-CapaUnitPackages {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		$UnitType
	)

	$oaUnits = @()

	$aUnits = $CapaSDK.GetUnitPackages($UnitName, $UnitType)

	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
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

	Return $oaUnits
}


<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247536/Get+unit+package+status

	.DESCRIPTION
		A detailed description of the Get-CapaUnitPackageStatus function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName  parameter.

	.PARAMETER UnitType
		A description of the UnitType  parameter.

	.PARAMETER PackageName
		A description of the PackageName  parameter.

	.PARAMETER PackageVersion
		A description of the PackageVersion  parameter.

	.EXAMPLE
		PS C:\> Get-CapaUnitPackageStatus -CapaSDK 'Value1' -UnitName  'Value2' -UnitType  'Value3' -PackageName  'Value4' -PackageVersion  'Value5' -PackageType  'Value6'

	.NOTES
		Additional information about the function.
#>
function Get-CapaUnitPackageStatus {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType,
		[Parameter(Mandatory = $true)]
		[String]$PackageName,
		[Parameter(Mandatory = $true)]
		[String]$PackageVersion
	)

	if ($UnitType -eq 'Computer') {
		$PackageType = '1'
	} else {
		$PackageType = '2'
	}

	$value = $CapaSDK.GetUnitPackageStatus($UnitName, $UnitType, $PackageName, $PackageVersion, $PackageType)
	return $value
}


# TODO: #220 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247554/Get+Unit+Relations

	.DESCRIPTION
		A detailed description of the Get-CapaUnitRelations function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.EXAMPLE
		PS C:\> Get-CapaUnitRelations -CapaSDK $value1 -UnitName $value2 -UnitType $value3

	.NOTES
		Additional information about the function.
#>
function Get-CapaUnitRelations {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		$UnitType
	)

	$oaUnits = @()

	$aUnits = $CapaSDK.GetUnitRelations($UnitName, $UnitType)

	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
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

	Return $oaUnit
}


# TODO: #222 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247572/Get+units

	.DESCRIPTION
		A detailed description of the Get-CapaUnits function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER Type
		A description of the Type parameter.

	.EXAMPLE
				PS C:\> Get-CapaUnits -CapaSDK $value1

	.NOTES
		Additional information about the function.
#>
function Get-CapaUnits {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $false)]
		[ValidateSet('Computer', 'User')]
		[string]$Type = '',
		[string]$BusinessUnit = ''
	)

	$oaUnits = @()

	if ($BusinessUnit -eq '') {
		$aUnits = $CapaSDK.GetUnits($Type)
	} else {
		if ($UnitType -eq '') {
			$aUnits = $CapaSDK.GetUnitsOnBusinessUnit($BusinessUnit)
		} Else {
			$aUnits = $CapaSDK.GetUnitsOnBusinessUnit($BusinessUnit, $UnitType)
		}
	}

	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
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

	Return $oaUnits
}


# TODO: #223 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247582/Get+Units+in+Folder

	.DESCRIPTION
		A detailed description of the Get-CapaUnitsInFolder function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER FolderStructure
		A description of the FolderStructure  parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.PARAMETER BusinessUnitName
		A description of the BusinessUnitName  parameter.

	.EXAMPLE
				PS C:\> Get-CapaUnitsInFolder -CapaSDK $value1 -FolderStructure  $value2 -UnitType Computer -BusinessUnitName  $value4

	.NOTES
		Additional information about the function.
#>
function Get-CapaUnitsInFolder {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		$FolderStructure,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		$UnitType,
		[Parameter(Mandatory = $true)]
		$BusinessUnitName
	)

	$oaUnits = @()

	$aUnits = $CapaSDK.GetUnitsInFolder($FolderStructure, $UnitType, $BusinessUnitName)

	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
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

	Return $oaUnits
}


# TODO: #221 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247564/Get+unit+WSUS+Group

	.DESCRIPTION
		A detailed description of the Get-CapaUnitWSUSGroup function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.EXAMPLE
				PS C:\> Get-CapaUnitWSUSGroup -CapaSDK $value1 -UnitName 'Value2' -UnitType Computer

	.NOTES
		Additional information about the function.
#>
function Get-CapaUnitWSUSGroup {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType
	)

	$value = $CapaSDK.GetUnitWSUSGroup($UnitName, $UnitType)
	return $value
}


# TODO: #224 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246240/Delete+group

	.DESCRIPTION
		A detailed description of the Remove-CapaUnitByUUID function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UUID
		A description of the UUID parameter.

	.EXAMPLE
				PS C:\> Remove-CapaUnitByUUID -CapaSDK $value1 -UUID 'Value2'

	.NOTES
		Additional information about the function.
#>
function Remove-CapaUnitByUUID {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$UUID
	)

	$bool = $CapaSDK.DeleteUnitByUUID($UUID)

	Return $bool
}


# TODO: #225 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247648/Remove+unit+from+business+unit

	.DESCRIPTION
		A detailed description of the Remove-CapaUnitFromBusinessUnit function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.EXAMPLE
		PS C:\> Remove-CapaUnitFromBusinessUnit -CapaSDK $value1 -UnitName 'Value2' -UnitType 'Value3'

	.NOTES
		Additional information about the function.
#>
function Remove-CapaUnitFromBusinessUnit {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType
	)

	$value = $CapaSDK.RemoveUnitFromBusinessUnit($UnitName, $UnitType)

	return $value
}


# TODO: #226 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247656/Remove+unit+from+calendar+group

	.DESCRIPTION
		A detailed description of the Remove-CapaUnitFromCalendarGroup function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.PARAMETER CalendarGroupName
		A description of the CalendarGroupName parameter.

	.EXAMPLE
				PS C:\> Remove-CapaUnitFromCalendarGroup -CapaSDK $value1 -UnitName 'Value2' -UnitType Computer -CalendarGroupName 'Value4'

	.NOTES
		Additional information about the function.
#>
function Remove-CapaUnitFromCalendarGroup {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType,
		[Parameter(Mandatory = $true)]
		[String]$CalendarGroupName
	)

	$value = $CapaSDK.RemoveUnitFromCalendarGroup($UnitName, $UnitType, $CalendarGroupName)
	return $value
}


# TODO: #227 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247664/Remove+unit+from+group

	.DESCRIPTION
		A detailed description of the Remove-CapaUnitFromGroup function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.PARAMETER GroupName
		A description of the GroupName parameter.

	.PARAMETER GroupType
		A description of the GroupType parameter.

	.EXAMPLE
		PS C:\> Remove-CapaUnitFromGroup -CapaSDK $value1 -UnitName 'Value2' -UnitType Computer -GroupName 'Value4' -GroupType ""

	.NOTES
		Additional information about the function.
#>
function Remove-CapaUnitFromGroup {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType,
		[Parameter(Mandatory = $true)]
		[string]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Dynamic_ADSI', 'Calendar', 'Department', 'Dynamic_SQL', 'Reinstall', 'Security', 'Static')]
		[string]$GroupType
	)

	$bool = $CapaSDK.RemoveUnitFromGroup($UnitName, $UnitType, $GroupName, $GroupType)

	Return $bool
}


# TODO: #228 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247672/Remove+unit+from+package

	.DESCRIPTION
		A detailed description of the Remove-CapaUnitFromPackage function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER PackageName
		A description of the PackageName parameter.

	.PARAMETER PackageVersion
		A description of the PackageVersion parameter.

	.PARAMETER PackageType
		A description of the PackageType parameter.

	.PARAMETER UnitName
		A description of the UnitName parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.EXAMPLE
				PS C:\> Remove-CapaUnitFromPackage -CapaSDK $value1 -PackageName 'Value2' -PackageVersion 'Value3' -PackageType Computer -UnitName 'Value5' -UnitType Computer

	.NOTES
		Additional information about the function.
#>
function Remove-CapaUnitFromPackage {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$PackageName,
		[Parameter(Mandatory = $true)]
		[string]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User', '1', '2')]
		[string]$PackageType,
		[Parameter(Mandatory = $true)]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType
	)

	if ($PackageType -eq 'Computer') {
		$PackageType = 1
	} else {
		$PackageType = 2
	}

	$bool = $CapaSDK.RemoveUnitFromPackage($UnitName, $UnitType, $PackageName, $PackageVersion, $PackageType)
	Return $bool
}


# TODO: #229 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247680/Remove+unit+from+reinstall

	.DESCRIPTION
		A detailed description of the Remove-CapaUnitFromReinstall function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER ComputerName
		A description of the ComputerName parameter.

	.EXAMPLE
				PS C:\> Remove-CapaUnitFromReinstall -CapaSDK $value1 -ComputerName 'Value2'

	.NOTES
		Additional information about the function.
#>
function Remove-CapaUnitFromReinstall {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$ComputerName
	)

	$value = $CapaSDK.RemoveUnitFromReinstall($ComputerName)
	return $value
}


# TODO: #230 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247688/Rename+unit

	.DESCRIPTION
		A detailed description of the Rename-CapaUnit function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER CurrentUnitName
		A description of the CurrentUnitName  parameter.

	.PARAMETER UnitType
		A description of the UnitType  parameter.

	.PARAMETER NewUnitName
		A description of the NewUnitName  parameter.

	.EXAMPLE
		PS C:\> Rename-CapaUnit -CapaSDK $value1 -CurrentUnitName  $value2 -UnitType  $value3 -NewUnitName  $value4

	.NOTES
		Additional information about the function.
#>
function Rename-CapaUnit {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		$CurrentUnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		$UnitType,
		[Parameter(Mandatory = $true)]
		$NewUnitName
	)

	$value = $CapaSDK.RenameUnit($CurrentUnitName, $UnitType, $NewUnitName)
	return $value
}


# TODO: #231 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247704/Send+Unit+Command

	.DESCRIPTION
		A detailed description of the Send-CapaUnitCommand function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER DeviceUUID
		A description of the DeviceUUID  parameter.

	.PARAMETER Command
		A description of the Command parameter.

	.PARAMETER ChangelogComment
		A description of the ChangelogComment  parameter.

	.EXAMPLE
				PS C:\> Send-CapaUnitCommand -CapaSDK $value1 -DeviceUUID  'Value2' -Command SWInventory -ChangelogComment  'Value4'

	.NOTES
		Additional information about the function.
#>
function Send-CapaUnitCommand {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$DeviceUUID,
		[Parameter(Mandatory = $true)]
		[ValidateSet('SWInventory', 'HWInventory', 'SecInventory', 'ManagedSoftwareInventory', 'RestartDevice', 'ShutdownDevice', 'Lock', 'PasswordReset', 'Wipe')]
		[String]$Command,
		[Parameter(Mandatory = $true)]
		[String]$ChangelogComment
	)

	$value = $CapaSDK.SendUnitCommand($DeviceUUID, $Command, $ChangelogComment)
	return $value
}


# TODO: #232 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247724/Set+unit+description

	.DESCRIPTION
		A detailed description of the Set-CapaUnitDescription function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName  parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.PARAMETER Description
		A description of the Description parameter.

	.EXAMPLE
				PS C:\> Set-CapaUnitDescription -CapaSDK $value1 -UnitName  'Value2' -UnitType Computer

	.NOTES
		Additional information about the function.
#>
function Set-CapaUnitDescription {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType,
		[String]$Description = ''
	)

	$value = $CapaSDK.SetUnitDescription($UnitName, $UnitType, $Description)
	return $value
}


# TODO: #233 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247732/Set+unit+label

	.DESCRIPTION
		A detailed description of the Set-CapaUnitLabel function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.PARAMETER Label
		A description of the Label parameter.

	.EXAMPLE
		PS C:\> Set-CapaUnitLabel -CapaSDK $value1 -UnitName 'Value2' -UnitType 'Value3' -Label 'Value4'

	.NOTES
		Additional information about the function.
#>
function Set-CapaUnitLabel {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType,
		[Parameter(Mandatory = $true)]
		[string]$Label
	)

	$value = $CapaSDK.SetUnitLabel($UnitName, $UnitType, $Label)

	return $value
}


# TODO: #234 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247740/Set+unit+name

	.DESCRIPTION
		A detailed description of the Set-CapaUnitName function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.PARAMETER Name
		A description of the Name parameter.

	.EXAMPLE
				PS C:\> Set-CapaUnitName -CapaSDK $value1 -UnitName 'Value2' -UnitType Computer -Name 'Value4'

	.NOTES
		Additional information about the function.
#>
function Set-CapaUnitName {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType,
		[Parameter(Mandatory = $true)]
		[String]$Name
	)

	$value = $CapaSDK.SetUnitName($UnitName, $UnitType, $Name)
	return $value
}


# TODO: #235 Update and add tests

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247748/Set+unit+package+status

	.DESCRIPTION
		A detailed description of the Set-CapaUnitPackageStatus function.

	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.

	.PARAMETER UnitName
		A description of the UnitName  parameter.

	.PARAMETER UnitType
		A description of the UnitType parameter.

	.PARAMETER PackageName
		A description of the PackageName  parameter.

	.PARAMETER PackageVersion
		A description of the PackageVersion  parameter.

	.PARAMETER Status
		A description of the Status  parameter.

	.PARAMETER ChangelogComment
		A description of the ChangelogComment parameter.

	.EXAMPLE
		PS C:\> Set-CapaUnitPackageStatus -CapaSDK $value1 -UnitName  $value2 -UnitType Computer -PackageName  $value4 -PackageVersion  $value5 -Status  $value6

	.NOTES
		Additional information about the function.
#>
function Set-CapaUnitPackageStatus {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType,
		[Parameter(Mandatory = $true)]
		[String]$PackageName,
		[Parameter(Mandatory = $true)]
		[String]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Waiting', 'Failed', 'Installed', 'Uninstall', 'Cancel')]
		[String]$Status,
		[String]$ChangelogComment = ''
	)

	if ($UnitType -eq 'Computer') {
		$PackageType = '1'
	} elseif ($UnitType -eq 'User') {
		$PackageType = '2'
	}

	$value = $CapaSDK.SetUnitPackageStatus($UnitName, $UnitType, $PackageName, $PackageVersion, $PackageType, $Status, $ChangelogComment)
	return $value
}


# TODO: #236 Update and add tests

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
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$UnitName = '',
		[Parameter(Mandatory = $true)]
		[ValidateSet('Active', 'Inactive')]
		[string]$Status = ''
	)

	$aUnits = $CapaSDK.SetUnitStatus($UnitName, $Status)

	Return $aUnits
}



