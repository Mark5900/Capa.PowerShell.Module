
<#
	.SYNOPSIS
		A function to convert Capa data types.
	
	.DESCRIPTION
		A function to convert Capa data types to a more readable format.
	
	.PARAMETER Datatype
		The data type to convert.
	
	.EXAMPLE
		PS C:\> Convert-CapaDataType -Datatype 1
	
	.NOTES
		A custom function to convert Capa data types to a more readable format.
#>
function Convert-CapaDataType {
	param
	(
		$Datatype
	)
	
	switch ($DataType) {
		1 { $Datatype = 'String' }
		2 { $Datatype = 'Time' }
		3 { $Datatype = 'Integer' }
		'I' { $Datatype = 'Integer' }
		'T' { $Datatype = 'Time' }
		'S' { $Datatype = 'String' }
		'N' { $Datatype = 'Text' }
		Default { $Datatype = $Datatype }
	}
	
	return $Datatype
}


<#
	.SYNOPSIS
		Get custom inventory categories and entries.
	
	.DESCRIPTION
		Get custom inventory categories and entries.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.EXAMPLE
				PS C:\> Get-CapaCustomInventoryCategoriesAndEntries -CapaSDK $CapaSDK
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246428/GetCustomInventoryCategoriesAndEntries
#>
function Get-CapaCustomInventoryCategoriesAndEntries {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetCustomInventoryCategoriesAndEntrie($UserName)
	
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		
		$Datatype = Convert-CapaDataType -Datatype $aItem [2]
		
		$oaUnits += [pscustomobject]@{
			Category = $aItem[0];
			Entry    = $aItem[1];
			Datatype = $Datatype
		}
	}
	
	Return $oaUnits
}


<#
	.SYNOPSIS
		Get the custom inventory for a unit.
	
	.DESCRIPTION
		Get the custom inventory for a unit, with the option to get the inventory by name and type or by UUID.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER UnitName
		The name of the unit.
	
	.PARAMETER UnitType
		The type of the unit.
	
	.PARAMETER Uuid
		The UUID of the unit.
	
	.EXAMPLE
				PS C:\> Get-CapaCustomInventoryForUnit -Uuid 'E3FBEC1E-32AC-4E51-AB9F-A644CD9F0A6B'

	.EXAMPLE
				PS C:\> Get-CapaCustomInventoryForUnit -UnitName 'CAPA-TEST-01' -UnitType 'Computer'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246358/Get+custom+inventory+for+unit
#>
function Get-CapaCustomInventoryForUnit {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(ParameterSetName = 'NameType',
			Mandatory = $true)]
		[string]$UnitName,
		[Parameter(ParameterSetName = 'NameType',
			Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType,
		[Parameter(ParameterSetName = 'Uuid',
			Mandatory = $true)]
		[string]$Uuid
	)
	
	$oaUnits = @()
	
	if ($PSCmdlet.ParameterSetName -eq 'NameType') {
		$aUnits = $CapaSDK.GetCustomInventoryForUnit($UnitName, $UnitType)
	} else {
		$aUnits = $CapaSDK.GetCustomInventoryForUnitUUID($Uuid)
	}
	
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$DataType = Convert-CapaDataType -Datatype $aItem[3]
		$oaUnits += [pscustomobject]@{
			Category = $aItem[0];
			Entry    = $aItem[1];
			Value    = $aItem[2];
			Datatype = $DataType;
			GUID     = $aItem[4];
			ID       = $aItem[5]
		}
	}
	
	Return $oaUnits
}


<#
	.SYNOPSIS
		Get the hardware inventory for a unit.
	
	.DESCRIPTION
		Get the hardware inventory for a unit.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER UnitName
		Can be the name of a unit or the UUID.
	
	.PARAMETER UnitType
		The type of the unit, can be Computer or User.
	
	.EXAMPLE
				PS C:\> Get-CapaHardwareInventoryForUnit -CapaSDK $CapaSDK -UnitName 'Klient' -UnitType Computer

	.EXAMPLE
				PS C:\> Get-CapaHardwareInventoryForUnit -CapaSDK $CapaSDK -UnitName 'E3FBEC1E-32AC-4E51-AB9F-A644CD9F0A6B' -UnitType Computer
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246368/Get+hardware+inventory+for+unit
#>
function Get-CapaHardwareInventoryForUnit {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User', '1', '2')]
		[string]$UnitType
	)
	
	if ($UnitType -eq 'Computer') {
		$UnitType = '1'
	}
	if ($UnitType -eq 'User') {
		$UnitType = '2'
	}

	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetHardwareInventoryForUnit($UnitName, $UnitType)
	
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$DataType = Convert-CapaDataType -Datatype $aItem[3]
		$oaUnits += [pscustomobject]@{
			Category = $aItem[0];
			Entry    = $aItem[1];
			Value    = $aItem[2];
			Datatype = $DataType;
			GUID     = $aItem[4];
			ID       = $aItem[5]
		}
	}
	
	Return $oaUnits
}


<#
	.SYNOPSIS
		Get logon history for a unit.
	
	.DESCRIPTION
		Get logon history for a unit.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER UnitName
		Can be the name of a unit or the UUID.
	
	.PARAMETER UnitType
		The type of the unit, can be Computer or User.
	
	.EXAMPLE
				PS C:\> Get-CapaLogonHistoryForUnit -CapaSDK $CapaSDK -UnitName 'Klient' -UnitType Computer

	.EXAMPLE
				PS C:\> Get-CapaLogonHistoryForUnit -CapaSDK $CapaSDK -UnitName 'E3FBEC1E-32AC-4E51-AB9F-A644CD9F0A6B' -UnitType Computer
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246378/Get+logon+history+for+unit
#>
function Get-CapaLogonHistoryForUnit {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[string]$UnitName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User', '1', '2')]
		[string]$UnitType
	)
	
	if ($UnitType -eq 'Computer') {
		$UnitType = '1'
	}
	if ($UnitType -eq 'User') {
		$UnitType = '2'
	}

	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetLogonHistoryForUnit($UnitName, $UnitType)
	
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$DataType = Convert-CapaDataType -Datatype $aItem[3]
		$oaUnits += [pscustomobject]@{
			Category = $aItem[0];
			Entry    = $aItem[1];
			Value    = $aItem[2];
			Datatype = $DataType;
			GUID     = $aItem[4];
			ID       = $aItem[5]
		}
	}
	
	Return $oaUnits
}


<#
	.SYNOPSIS
		Get metering groups.
	
	.DESCRIPTION
		Gets a list of metering groups.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.EXAMPLE
				PS C:\> Get-CapaMeteringGroups -CapaSDK $CapaSDK
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246388/Get+metering+groups
#>
function Get-CapaMeteringGroups {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetMeteringGroups()
	
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Name           = $aItem[0];
			Version        = $aItem[1];
			Vendor         = $aItem[2];
			AppCode        = $aItem[3];
			Description    = $aItem[4];
			MeteringModule = $aItem[5];
			GUID           = $aItem[6];
			ID             = $aItem[7]
		}
	}
	
	Return $oaUnits
}


<#
	.SYNOPSIS
		Get software inventory for a unit.
	
	.DESCRIPTION
		Get software inventory for a unit.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER UnitName
		The name of the unit.
	
	.PARAMETER UnitType
		The type of the unit, can be Computer or User.
	
	.PARAMETER Uuid
		The UUID of the unit.
	
	.EXAMPLE
				PS C:\> Get-CapaSoftwareInventoryForUnit -CapaSDK $CapaSDK -UnitName 'Klient' -UnitType Computer

	.EXAMPLE
				PS C:\> Get-CapaSoftwareInventoryForUnit -CapaSDK $CapaSDK -UnitName 'E3FBEC1E-32AC-4E51-AB9F-A644CD9F0A6B' -UnitType Computer
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246398/Get+software+inventory+for+unit
#>
function Get-CapaSoftwareInventoryForUnit {
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(ParameterSetName = 'NameType',
			Mandatory = $true)]
		[string]$UnitName,
		[Parameter(ParameterSetName = 'NameType',
			Mandatory = $true)]
		[Parameter(ParameterSetName = 'Uuid',
			Mandatory = $true)]
		[ValidateSet('Computer', 'User', '1', '2')]
		[string]$UnitType,
		[Parameter(ParameterSetName = 'Uuid',
			Mandatory = $true)]
		[string]$Uuid
	)
	
	if ($UnitType -eq 'Computer') {
		$UnitType = '1'
	}
	if ($UnitType -eq 'User') {
		$UnitType = '2'
	}
	
	$oaUnits = @()
	
	if ($PSCmdlet.ParameterSetName -eq 'NameType') {
		$aUnits = $CapaSDK.GetSoftwareInventoryForUnit($UnitName, $UnitType)
	} else {
		$aUnits = $CapaSDK.GetSoftwareInventoryForUnit($Uuid, $UnitType)
	}
	
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			SoftwareName           = $aItem[0];
			SoftwareVersion        = $aItem[1];
			InstallDate            = $aItem[2];
			SoftwareMeteringModule = $aItem[3];
			SoftwareAppCode        = $aItem[4];
			SoftwareDescription    = $aItem[5];
			SoftwareID             = $aItem[6];
			SoftwareVendor         = $aItem[7]
		}
	}
	
	Return $oaUnits
}


<#
	.SYNOPSIS
		Get update inventory for a unit.
	
	.DESCRIPTION
		Get a list of update inventory for a unit.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER UnitName
		The name of the unit.
	
	.PARAMETER UnitType
		The type of the unit, can be Computer or User.
	
	.EXAMPLE
				PS C:\> Get-CapaUpdateInventoryForUnit -CapaSDK $CapaSDK -UnitName 'Klient' -UnitType Computer
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246408/Get+update+inventory+for+unit
#>
function Get-CapaUpdateInventoryForUnit {
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
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetUpdateInventoryForUnit($UnitName, $UnitType)
	
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Qfename      = $aItem[0];
			InstallDate  = $aItem[1];
			UpdateID     = $aItem[2];
			UpdateName   = $aItem[3];
			Revision     = $aItem[4];
			InstallCount = $aItem[5];
			Status       = $aItem[6]
		}
	}
	
	Return $oaUnits
}


<#
	.SYNOPSIS
		Get software inventory for a user.
	
	.DESCRIPTION
		Get software inventory for a user.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER UserName
		The username of the user.
	
	.EXAMPLE
				PS C:\> Get-CapaSoftwareInventoryForUser -CapaSDK $CapaSDK -UserName 'Klient'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246418/Get+User+Inventory
#>
function Get-CapaUserInventory {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		$UserName
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetUserInventory($UserName)
	
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Category = $aItem[0];
			Entry    = $aItem[1];
			Value    = $aItem[2];
			Datatype = $aItem[3];
			GUID     = $aItem[4];
			ID       = $aItem[5]
		}
	}
	
	Return $oaUnits
}


<#
	.SYNOPSIS
		Set custom inventory for a unit.
	
	.DESCRIPTION
		Set custom inventory for a unit, either by name and type or by UUID.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER UnitName
		The name of the unit.
	
	.PARAMETER UnitType
		The type of the unit, can be Computer or User.
	
	.PARAMETER Uuid
		The UUID of the unit.
	
	.PARAMETER Section
		The inventory section.
	
	.PARAMETER Name
		The name of the value.
	
	.PARAMETER Value
		The value.
	
	.PARAMETER DataType
		The data type of the value, can be String, Integer, Text or Time.
	
	.EXAMPLE
				PS C:\> Set-CapaCustomInventory -CapaSDK $CapaSDK -UnitName 'Klient' -UnitType Computer -Section 'Antivirus' -Name 'Version' -Value '4' -DataType Integer
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246438/Set+custom+inventory
#>
function Set-CapaCustomInventory {
	[CmdletBinding(DefaultParameterSetName = 'NameType')]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(ParameterSetName = 'NameType',
			Mandatory = $true)]
		[String]$UnitName,
		[Parameter(ParameterSetName = 'NameType',
			Mandatory = $true)]
		[ValidateSet('1', '2', 'Computer', 'User')]
		[String]$UnitType,
		[Parameter(ParameterSetName = 'Uuid',
			Mandatory = $true)]
		[String]$Uuid,
		[Parameter(Mandatory = $true)]
		[String]$Section,
		[Parameter(Mandatory = $true)]
		[String]$Name,
		[Parameter(Mandatory = $true)]
		[String]$Value,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Integer', 'Time', 'String', 'Text', 'I', 'T', 'S', 'N')]
		[String]$DataType
	)
	
	switch ($UnitType) {
		'Computer' {
			$UnitType = '1'
		}
		'User' {
			$UnitType = '2'
		}
		default { }
	}
	
	switch ($DataType) {
		'Integer' {
			$DataType = 'I'
		}
		'Time' {
			$DataType = 'T'
		}
		'String' {
			$DataType = 'S'
		}
		'Text' {
			$DataType = 'N'
		}
		default { }
	}
	
	if ($PSCmdlet.ParameterSetName -eq 'NameType') {
		$value = $CapaSDK.SetCustomInventory($UnitName, $UnitType, $Section, $Name, $Value, $DataType)
	} Else {
		$value = $CapaSDK.SetCustomInventoryUUID($Uuid, $Section, $Name, $Value, $DataType)
	}
	
	return $value
}


<#
	.SYNOPSIS
		Set hardware inventory for a unit.
	
	.DESCRIPTION
		Set hardware inventory for a unit, either by name and type or by UUID.
	
	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER UnitName
		The name of the unit.

	.PARAMETER UnitType
		The type of the unit, can be Computer or User.

	.PARAMETER Uuid
		The UUID of the unit.

	.PARAMETER Section
		The inventory section.

	.PARAMETER Name
		The name of the value.

	.PARAMETER Value
		The value.

	.PARAMETER DataType
		The data type of the value, can be String, Integer, Text or Time.
	
	.EXAMPLE
				PS C:\> Set-CapaSetCustomInventory
	
	.NOTES
		When inventory from the unit is collected by the CapaInstaller Backend, these settings will be deleted if not present in the inventory data collected.
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246446/Set+hardware+inventory
#>
function Set-CapaHardwareInventory {
	[CmdletBinding(DefaultParameterSetName = 'NameType')]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(ParameterSetName = 'NameType',
			Mandatory = $true)]
		[String]$UnitName,
		[Parameter(ParameterSetName = 'NameType',
			Mandatory = $true)]
		[ValidateSet('1', '2', 'Computer', 'User')]
		[String]$UnitType,
		[Parameter(ParameterSetName = 'Uuid',
			Mandatory = $true)]
		[String]$Uuid,
		[Parameter(Mandatory = $true)]
		[String]$Section,
		[Parameter(Mandatory = $true)]
		[String]$Name,
		[Parameter(Mandatory = $true)]
		[String]$Value,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Integer', 'Time', 'String', 'Text', 'I', 'T', 'S', 'N')]
		[String]$DataType
	)
	
	switch ($UnitType) {
		'Computer' {
			$UnitType = '1'
		}
		'User' {
			$UnitType = '2'
		}
		default { }
	}
	
	switch ($DataType) {
		'Integer' {
			$DataType = 'I'
		}
		'Time' {
			$DataType = 'T'
		}
		'String' {
			$DataType = 'S'
		}
		'Text' {
			$DataType = 'N'
		}
		default { }
	}
	
	if ($PSCmdlet.ParameterSetName -eq 'NameType') {
		$value = $CapaSDK.SetHardwareInventory($UnitName, $UnitType, $Section, $Name, $Value, $DataType)
	} Else {
		$value = $CapaSDK.SetHardwareInventoryUUID($Uuid, $Section, $Name, $Value, $DataType)
	}
	
	return $value
}


