<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246358/Get+custom+inventory+for+unit
	
	.DESCRIPTION
		A detailed description of the Get-CapaCustomInventoryForUnit function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER UnitName
		A description of the UnitName parameter.
	
	.PARAMETER UnitType
		A description of the UnitType parameter.
	
	.PARAMETER Uuid
		A description of the Uuid parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaCustomInventoryForUnit -Uuid 'Value1'
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaCustomInventoryForUnit
{
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
	
	if ($PSCmdlet.ParameterSetName -eq 'NameType')
	{
		$aUnits = $CapaSDK.GetCustomInventoryForUnit($UnitName, $UnitType)
	}
	else
	{
		$aUnits = $CapaSDK.GetCustomInventoryForUnitUUID($Uuid)
	}
	
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split(';')
		$DataType = Convert-CapaDataType -Datatype $aItem[3]
		$oaUnits += [pscustomobject]@{
			Category = $aItem[0];
			Entry    = $aItem[1];
			Value    = $aItem[2];
			Datatype = $DataType;
			GUID	 = $aItem[4];
			ID	     = $aItem[5]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246368/Get+hardware+inventory+for+unit
	
	.DESCRIPTION
		A detailed description of the Get-CapaHardwareInventoryForUnit function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER UnitName
		A description of the UnitName parameter.
	
	.PARAMETER UnitType
		A description of the UnitType parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaHardwareInventoryForUnit -CapaSDK $value1 -UnitName 'Value2' -UnitType Computer
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaHardwareInventoryForUnit
{
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
	
	$aUnits = $CapaSDK.GetHardwareInventoryForUnit($UnitName, $UnitType)
	
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split(';')
		$DataType = Convert-CapaDataType -Datatype $aItem[3]
		$oaUnits += [pscustomobject]@{
			Category = $aItem[0];
			Entry    = $aItem[1];
			Value    = $aItem[2];
			Datatype = $DataType;
			GUID	 = $aItem[4];
			ID	     = $aItem[5]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246378/Get+logon+history+for+unit
	
	.DESCRIPTION
		A detailed description of the Get-CapaLogonHistoryForUnit function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER UnitName
		A description of the UnitName parameter.
	
	.PARAMETER UnitType
		A description of the UnitType parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaLogonHistoryForUnit -CapaSDK $value1 -UnitName 'Value2' -UnitType Computer
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaLogonHistoryForUnit
{
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
	
	$aUnits = $CapaSDK.GetLogonHistoryForUnit($UnitName, $UnitType)
	
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split(';')
		$DataType = Convert-CapaDataType -Datatype $aItem[3]
		$oaUnits += [pscustomobject]@{
			Category = $aItem[0];
			Entry    = $aItem[1];
			Value    = $aItem[2];
			Datatype = $DataType;
			GUID	 = $aItem[4];
			ID	     = $aItem[5]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246388/Get+metering+groups
	
	.DESCRIPTION
		A detailed description of the Get-CapaMeteringGroups function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaMeteringGroups -CapaSDK $value1
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaMeteringGroups
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetMeteringGroups()
	
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Name		   = $aItem[0];
			Version	       = $aItem[1];
			Vendor		   = $aItem[2];
			AppCode	       = $aItem[3];
			Description    = $aItem[4];
			MeteringModule = $aItem[5];
			GUID		   = $aItem[6];
			ID			   = $aItem[7]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246398/Get+software+inventory+for+unit
	
	.DESCRIPTION
		A detailed description of the Get-CapaSoftwareInventoryForUnit function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER UnitName
		A description of the UnitName parameter.
	
	.PARAMETER UnitType
		A description of the UnitType parameter.
	
	.PARAMETER Uuid
		A description of the Uuid parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaSoftwareInventoryForUnit -UnitType Computer -Uuid 'Value2'
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaSoftwareInventoryForUnit
{
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
	
	if ($UnitType -eq 'Computer')
	{
		$UnitType = '1'
	}
	if ($UnitType -eq 'User')
	{
		$UnitType = '2'
	}
	
	$oaUnits = @()
	
	if ($PSCmdlet.ParameterSetName -eq 'NameType')
	{
		$aUnits = $CapaSDK.GetSoftwareInventoryForUnit($UnitName, $UnitType)
	}
	else
	{
		$aUnits = $CapaSDK.GetSoftwareInventoryForUnit($Uuid, $UnitType)
	}
	
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			SoftwareName		   = $aItem[0];
			SoftwareVersion	       = $aItem[1];
			InstallDate		       = $aItem[2];
			SoftwareMeteringModule = $aItem[3];
			SoftwareAppCode	       = $aItem[4];
			SoftwareDescription    = $aItem[5];
			SoftwareID			   = $aItem[6];
			SoftwareVendor		   = $aItem[7]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246408/Get+update+inventory+for+unit
	
	.DESCRIPTION
		A detailed description of the Get-CapaUpdateInventoryForUnit function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER UnitName
		A description of the UnitName parameter.
	
	.PARAMETER UnitType
		A description of the UnitType parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaUpdateInventoryForUnit -CapaSDK $value1 -UnitName 'Value2' -UnitType Computer
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaUpdateInventoryForUnit
{
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
	
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Qfename	     = $aItem[0];
			InstallDate  = $aItem[1];
			UpdateID	 = $aItem[2];
			UpdateName   = $aItem[3];
			Revision	 = $aItem[4];
			InstallCount = $aItem[5];
			Status	     = $aItem[6]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246418/Get+User+Inventory
	
	.DESCRIPTION
		A detailed description of the Get-CapaUserInventory function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER UserName
		A description of the UserName parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaUserInventory -CapaSDK $value1 -UserName $value2
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaUserInventory
{
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
	
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Category = $aItem[0];
			Entry    = $aItem[1];
			Value    = $aItem[2];
			Datatype = $aItem[3];
			GUID	 = $aItem[4];
			ID	     = $aItem[5]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246428/GetCustomInventoryCategoriesAndEntries
	
	.DESCRIPTION
		A detailed description of the Get-CapaCustomInventoryCategoriesAndEntries function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaCustomInventoryCategoriesAndEntries -CapaSDK $value1
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaCustomInventoryCategoriesAndEntries
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetCustomInventoryCategoriesAndEntrie($UserName)
	
	foreach ($sItem in $aUnits)
	{
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
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246438/Set+custom+inventory
	
	.DESCRIPTION
		A detailed description of the Set-CapaCustomInventory function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER UnitName
		A description of the UnitName parameter.
	
	.PARAMETER UnitType
		A description of the UnitType parameter.
	
	.PARAMETER Uuid
		A description of the Uuid  parameter.
	
	.PARAMETER Section
		A description of the Section parameter.
	
	.PARAMETER Name
		A description of the Name  parameter.
	
	.PARAMETER Value
		A description of the Value  parameter.
	
	.PARAMETER DataType
		A description of the DataType  parameter.
	
	.EXAMPLE
		PS C:\> Set-CapaCustomInventory
	
	.NOTES
		Additional information about the function.
#>
function Set-CapaCustomInventory
{
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
	
	switch ($UnitType)
	{
		'Computer' {
			$UnitType = '1'
		}
		'User' {
			$UnitType = '2'
		}
		default { }
	}
	
	switch ($DataType)
	{
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
	
	if ($PSCmdlet.ParameterSetName -eq 'NameType')
	{
		$value = $CapaSDK.SetCustomInventory($UnitName, $UnitType, $Section, $Name, $Value, $DataType)
	}
	Else
	{
		$value = $CapaSDK.SetCustomInventoryUUID($Uuid, $Section, $Name, $Value, $DataType)
	}
	
	return $value
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246438/Set+custom+inventory
	
	.DESCRIPTION
		A detailed description of the Set-CapaSetCustomInventory function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.EXAMPLE
				PS C:\> Set-CapaSetCustomInventory
	
	.NOTES
		Additional information about the function.
#>
function Set-CapaHardwareInventory
{
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
	
	switch ($UnitType)
	{
		'Computer' {
			$UnitType = '1'
		}
		'User' {
			$UnitType = '2'
		}
		default { }
	}
	
	switch ($DataType)
	{
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
	
	if ($PSCmdlet.ParameterSetName -eq 'NameType')
	{
		$value = $CapaSDK.SetHardwareInventory($UnitName, $UnitType, $Section, $Name, $Value, $DataType)
	}
	Else
	{
		$value = $CapaSDK.SetHardwareInventoryUUID($Uuid, $Section, $Name, $Value, $DataType)
	}
	
	return $value
}

<#
	.SYNOPSIS
		Used to convert DataType number to a string that makes sense
	
	.DESCRIPTION
		A detailed description of the Convert-CapaDataType function.
	
	.PARAMETER Datatype
		A description of the Datatype parameter.
	
	.EXAMPLE
				PS C:\> Convert-CapaDataType
	
	.NOTES
		Additional information about the function.
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