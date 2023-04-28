
<#
	.SYNOPSIS
		Create a group.
	
	.DESCRIPTION
		Create a group, either in global scope or in a business unit.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER GroupName
		The name of the group.
	
	.PARAMETER GroupType
		The type of the group, either Calendar, Department or Static.
	
	.PARAMETER UnitType
		The type of elements in the group, either Computer or User.

	.PARAMETER BusinessUnit
		The name of the business unit to create the group in, if not specified the group will be created in global scope.
	
	.EXAMPLE
		PS C:\> Create-CapaGroup -CapaSDK $CapaSDk -GroupName  'Jylland' -GroupType  Static -UnitType Computer

	.EXAMPLE
		PS C:\> Create-CapaGroup -CapaSDK $CapaSDk -GroupName  'Jylland' -GroupType  Static -UnitType Computer -BusinessUnit 'Denmark'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246224/Create+group
		And https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246232/Create+group+in+Business+Unit
#>
function Create-CapaGroup {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Calendar', 'Department', 'Static')]
		[string]$GroupType,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[String]$UnitType,
		[string]$BusinessUnit = ''
	)
	
	if ($BusinessUnit -eq '') {
		$value = $CapaSDK.CreateGroup($GroupName, $GroupType, $UnitType)
	} else {
		$value = $CapaSDK.CreateGroupInBusinessUnit($GroupName, $GroupType, $UnitType, $BusinessUnit)
	}
	
	return $value
}


<#
	.SYNOPSIS
		Get a list of all application groups.
	
	.DESCRIPTION
		Get a list of all application groups.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.EXAMPLE
				PS C:\> Get-CapaApplicationGroups -CapaSDK $CapaSDK
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246256/Get+application+groups
#>
function Get-CapaApplicationGroups {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetApplicationGroups()
	
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Id          = $aItem[0];
			Name        = $aItem[1];
			Version     = $aItem[2];
			Vendor      = $aItem[3];
			AppCode     = $aItem[4];
			Description = $aItem[5];
			GUID        = $aItem[6]
		}
	}
	
	Return $oaUnits
}


<#
	.SYNOPSIS
		Get a groups description.
	
	.DESCRIPTION
		Returns a string with the description of the group.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER GroupName
		The name of the group.
	
	.PARAMETER GroupType
		The type of the group, either Dynamic_ADSI, Calendar, Department, Dynamic_SQL, Reinstall, Security or Static.
	
	.EXAMPLE
				PS C:\> Get-CapaGroupDescription -CapaSDK $CapaSDK -GroupName 'Default' -GroupType Static
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246264/Get+Group+Description
#>
function Get-CapaGroupDescription {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Dynamic_ADSI', 'Calendar', 'Department', 'Dynamic_SQL', 'Reinstall', 'Security', 'Static')]
		[String]$GroupType
	)
	
	$value = $CapaSDK.GetGroupDescription($GroupName, $GroupType)
	return $value
}


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
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246272/Get+Group+Folder
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


<#
	.SYNOPSIS
		Returns packages linked to a group.
	
	.DESCRIPTION
		Returns array of packages linked to a group.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER GroupName
		The name of the group.
	
	.PARAMETER GroupType
		The type of the group, either Dynamic_ADSI, Calendar, Department, Dynamic_SQL, Reinstall, Security or Static.
	
	.EXAMPLE
		PS C:\> Get-CapaGroupPackages -CapaSDK $CapaSDK -GroupName $GroupName -Type Dynamic_ADSI
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246910/Get+group+packages
#>
function Get-CapaGroupPackages {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Dynamic_ADSI', 'Calendar', 'Department', 'Dynamic_SQL', 'Reinstall', 'Security', 'Static')]
		[string]$GroupType
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetGroupPackages($GroupName, $GroupType)
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Name               = $aItem[0];
			Version            = $aItem[1];
			Type               = $aItem[2];
			DisplayName        = $aItem[3];
			IsMandatory        = $aItem[4];
			ScheduleId         = $aItem[5];
			Description        = $aItem[6];
			GUID               = $aItem[7];
			ID                 = $aItem[8];
			IsInteractive      = $aItem[9];
			DependendPackageID = $aItem[10];
			IsInventoryPackage = $aItem[11];
			CollectMode        = $aItem[12];
			Priority           = $aItem[13];
			ServerDeploy       = $aItem[14]
		}
	}
	
	Return $oaUnits
}


<#
	.SYNOPSIS
		Returns printers linked to a group.
	
	.DESCRIPTION
		Returns array of printers linked to a group.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER GroupName
		The name of the group.
	
	.PARAMETER GroupType
		The type of the group, either Dynamic_ADSI, Calendar, Department, Dynamic_SQL, Reinstall, Security or Static.
	
	.EXAMPLE
				PS C:\> Get-CapaGroupPrinters -CapaSDK $value1 -GroupName 'Value2' -GroupType Dynamic_ADSI
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247436/Get+group+Printers
#>
function Get-CapaGroupPrinters {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Dynamic_ADSI', 'Calendar', 'Department', 'Dynamic_SQL', 'Reinstall', 'Static')]
		[String]$GroupType
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetGroupPrinters($GroupName, $GroupType)
	
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			DisplayName = $aItem[0];
			Created     = $aItem[1];
			Status      = $aItem[2];
			Description = $aItem[3];
			GUID        = $aItem[4];
			ID          = $aItem[5];
			TypeName    = $aItem[7];
			UUID        = $aItem[8]
		}
	}
	
	Return $oaUnits
}


<#
	.SYNOPSIS
		Get groups.
	
	.DESCRIPTION
		Get either all groups or from all groups from specific business unit.
	
	.PARAMETER CapaSDK
		CapaSDK object.
	
	.PARAMETER Type
		If specified, only groups of this type will be returned.
		Can be one of the following: Dynamic_ADSI, Calendar, Department, Dynamic_SQL, Reinstall, Security or Static.

	.PARAMETER BusinessUnit
		If specified, only groups from this business unit will be returned.
	
	.EXAMPLE
		PS C:\> Get-CapaGroups -CapaSDK $CapaSDK

	.EXAMPLE
		PS C:\> Get-CapaGroups -CapaSDK $CapaSDK -GroupType Dynamic_ADSI
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246280/Get+groups
		And https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246290/Get+groups+on+Business+Unit
#>
function Get-CapaGroups {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $false)]
		[ValidateSet('Dynamic_ADSI', 'Calendar', 'Department', 'Dynamic_SQL', 'Reinstall', 'Security', 'Static')]
		[string]$GroupType = '',
		[string]$BusinessUnit = ''
	)
	
	$oaUnits = @()
	
	if ($BusinessUnit -eq '') {
		$aUnits = $CapaSDK.GetGroups($GroupType)
	} Else {
		If ($GroupType -eq '') {
			$aUnits = $CapaSDK.GetGroupsInBusinessUnit($BusinessUnit)
		} Else {
			$aUnits = $CapaSDK.GetGroupsInBusinessUnit($BusinessUnit, $GroupType)
		}
	}
	
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		
		if ($aItem[2] -eq '1') {
			$UnitType = 'Computer'
		} else {
			$UnitType = 'User'
		}
		
		$oaUnits += [pscustomobject]@{
			Name         = $aItem[0];
			Type         = $aItem[1];
			UnitTypeID   = $aItem[2];
			UnitTypeName = $UnitType;
			Description  = $aItem[3];
			GUID         = $aItem[4];
			ID           = $aItem[5]
		}
	}
	
	Return $oaUnits
}


<#
	.SYNOPSIS
		Get units linked to a group.
	
	.DESCRIPTION
		Returns array of units linked to a group.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER GroupName
		The name of the group.
	
	.PARAMETER GroupType
		The type of the group, either Dynamic_ADSI, Calendar, Department, Dynamic_SQL, Reinstall, Security or Static.
	
	.EXAMPLE
				PS C:\> Get-CapaGroupUnits -CapaSDK $CapaSDK -GroupName 'Test' -GroupType Static
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247446/Get+group+units
#>
function Get-CapaGroupUnits {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Dynamic_ADSI', 'Calendar', 'Department', 'Dynamic_SQL', 'Reinstall', 'Security', 'Static')]
		[string]$GroupType
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetGroupUnits($GroupName, $GroupType)
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Name         = $aItem[0];
			Created      = $aItem[1];
			LastExecuted = $aItem[2];
			Status       = $aItem[3];
			Description  = $aItem[4];
			GUID         = $aItem[5];
			ID           = $aItem[6];
			TypeName     = $aItem[7]
		}
	}
	
	Return $oaUnits
}


<#
	.SYNOPSIS
		Removes a group.
	
	.DESCRIPTION
		Removes a group either from a business unit or from global.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER GroupName
		The name of the group.
	
	.PARAMETER GroupType
		The type of the group, either Dynamic_ADSI, Calendar, Department, Dynamic_SQL, Reinstall, Security or Static.
	
	.PARAMETER UnitType
		The type of the unit in the group, either Computer or User.

	.PARAMETER BusinessUnit
		If specified, the group will be removed in this business unit.
	
	.EXAMPLE
				PS C:\> Remove-CapaGroup -CapaSDK $CapaSDK -GroupName 'Lenovo' -GroupType Static -UnitType Computer

	.EXAMPLE
				PS C:\> Remove-CapaGroup -CapaSDK $CapaSDK -GroupName 'Lenovo' -GroupType Static -UnitType Computer -BusinessUnit 'Test'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246240/Delete+group
		And https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246248/Delete+Group+in+Business+Unit
#>
function Remove-CapaGroup {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Dynamic_ADSI', 'Calendar', 'Department', 'Dynamic_SQL', 'Reinstall', 'Security', 'Static')]
		[string]$GroupType,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType,
		[String]$BusinessUnit = ''
	)
	
	if ($BusinessUnit -eq '') {
		$value = $CapaSDK.DeleteGroup($GroupName, $GroupType, $UnitType)
	} else {
		$value = $CapaSDK.DeleteGroupInBusinessUnit($GroupName, $GroupType, $UnitType, $BusinessUnit)
	}
	
	Return $value
}


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


