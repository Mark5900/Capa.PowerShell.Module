<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246224/Create+group
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246232/Create+group+in+Business+Unit
	
	.DESCRIPTION
		A detailed description of the Create-CapaGroup function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER GroupName
		A description of the GroupName  parameter.
	
	.PARAMETER GroupType
		A description of the GroupType  parameter.
	
	.PARAMETER UnitType
		A description of the UnitType parameter.
	
	.EXAMPLE
				PS C:\> Create-CapaGroup -CapaSDK $value1 -GroupName  'Value2' -GroupType  Calendar -UnitType Computer
	
	.NOTES
		Additional information about the function.
#>
function Create-CapaGroup
{
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
	
	if ($BusinessUnit -eq '')
	{
		$value = $CapaSDK.CreateGroup($GroupName, $GroupType, $UnitType)
	}
	else
	{
		$value = $CapaSDK.CreateGroupInBusinessUnit($GroupName, $GroupType, $UnitType, $BusinessUnit)
	}
	
	return $value
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246264/Get+Group+Description
	
	.DESCRIPTION
		A detailed description of the Get-CapaGroupDescription function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER GroupName
		A description of the GroupName parameter.
	
	.PARAMETER GroupType
		A description of the GroupType parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaGroupDescription -CapaSDK $value1 -GroupName 'Value2' -GroupType Dynamic_ADSI
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaGroupDescription
{
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
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246272/Get+Group+Folder
	
	.DESCRIPTION
		A detailed description of the Get-CapaGroupFolder function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER GroupName
		A description of the GroupName parameter.
	
	.PARAMETER GroupType
		A description of the GroupType parameter.
	
	.PARAMETER UnitType
		A description of the UnitType parameter.
	
	.EXAMPLE
		PS C:\> Get-CapaGroupFolder -CapaSDK $value1 -GroupName 'Value2' -GroupType Dynamic_ADSI
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaGroupFolder
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$GroupName,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Dynamic_ADSI', 'Department', 'Dynamic_SQL', 'Static')]
		[String]$GroupType,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Computer', 'User')]
		[string]$UnitType
	)
	
	$value = $CapaSDK.GetGroupFolder($GroupName, $GroupType, $UnitType)
	return $value
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246910/Get+group+packages
	
	.DESCRIPTION
		A detailed description of the Get-CapaGroupPackages function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER GroupName
		A description of the GroupName parameter.
	
	.PARAMETER GroupType
		A description of the Type parameter.
	
	.EXAMPLE
		PS C:\> Get-CapaGroupPackages -CapaSDK $CapaSDK -GroupName $GroupName -Type Dynamic_ADSI
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaGroupPackages
{
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
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Name			   = $aItem[0];
			Version		       = $aItem[1];
			Type			   = $aItem[2];
			DisplayName	       = $aItem[3];
			IsMandatory	       = $aItem[4];
			ScheduleId		   = $aItem[5];
			Description	       = $aItem[6];
			GUID			   = $aItem[7];
			ID				   = $aItem[8];
			IsInteractive	   = $aItem[9];
			DependendPackageID = $aItem[10];
			IsInventoryPackage = $aItem[11];
			CollectMode	       = $aItem[12];
			Priority		   = $aItem[13];
			ServerDeploy	   = $aItem[14]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247436/Get+group+Printers
	
	.DESCRIPTION
		A detailed description of the Get-CapaGroupPrinters function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER GroupName
		A description of the GroupName parameter.
	
	.PARAMETER GroupType
		A description of the GroupType parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaGroupPrinters -CapaSDK $value1 -GroupName 'Value2' -GroupType Dynamic_ADSI
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaGroupPrinters
{
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
	
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			DisplayName = $aItem[0];
			Created	    = $aItem[1];
			Status	    = $aItem[2];
			Description = $aItem[3];
			GUID	    = $aItem[4];
			ID		    = $aItem[5];
			TypeName    = $aItem[7];
			UUID	    = $aItem[8]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246280/Get+groups
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246290/Get+groups+on+Business+Unit
	
	.DESCRIPTION
		A detailed description of the Get-CapaGroups function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER Type
		A description of the Type parameter.
	
	.EXAMPLE
		PS C:\> Get-CapaGroups -CapaSDK $CapaSDK
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaGroups
{
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
	
	if ($BusinessUnit -eq '')
	{
		$aUnits = $CapaSDK.GetGroups($GroupType)
	}
	Else
	{
		If ($GroupType -eq '')
		{
			$aUnits = $CapaSDK.GetGroupsInBusinessUnit($BusinessUnit)
		}
		Else
		{
			$aUnits = $CapaSDK.GetGroupsInBusinessUnit($BusinessUnit, $GroupType)
		}
	}
	
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split(';')
		
		if ($aItem[2] -eq '1')
		{
			$UnitType = 'Computer'
		}
		else
		{
			$UnitType = 'User'
		}
		
		$oaUnits += [pscustomobject]@{
			Name		 = $aItem[0];
			Type		 = $aItem[1];
			UnitTypeID   = $aItem[2];
			UnitTypeName = $UnitType;
			Description  = $aItem[3];
			GUID		 = $aItem[4];
			ID		     = $aItem[5]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247446/Get+group+units
	
	.DESCRIPTION
		A detailed description of the Get-CapaGroupUnits function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER GroupName
		A description of the GroupName parameter.
	
	.PARAMETER GroupType
		A description of the GroupType parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaGroupUnits -CapaSDK $value1 -GroupName 'Value2' -GroupType Dynamic_ADSI
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaGroupUnits
{
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
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Name		 = $aItem[0];
			Created	     = $aItem[1];
			LastExecuted = $aItem[2];
			Status	     = $aItem[3];
			Description  = $aItem[4];
			GUID		 = $aItem[5];
			ID		     = $aItem[6];
			TypeName	 = $aItem[7]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246240/Delete+group
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246248/Delete+Group+in+Business+Unit
	
	.DESCRIPTION
		A detailed description of the Remove-CapaGroup function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER GroupName
		A description of the GroupName parameter.
	
	.PARAMETER GroupType
		A description of the GroupType parameter.
	
	.PARAMETER UnitType
		A description of the UnitType parameter.
	
	.EXAMPLE
				PS C:\> Remove-CapaGroup -CapaSDK $value1 -GroupName 'Value2' -GroupType Dynamic_ADSI -UnitType Computer
	
	.NOTES
		Additional information about the function.
#>
function Remove-CapaGroup
{
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
	
	if ($BusinessUnit -eq '')
	{
		$value = $CapaSDK.DeleteGroup($GroupName, $GroupType, $UnitType)
	}
	else
	{
		$value = $CapaSDK.DeleteGroupInBusinessUnit($GroupName, $GroupType, $UnitType, $BusinessUnit)
	}
	
	Return $value
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246310/Set+Group+Description
	
	.DESCRIPTION
		A detailed description of the Set-CapaGroupDescription function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER GroupName
		A description of the GroupName parameter.
	
	.PARAMETER GroupType
		A description of the GroupType parameter.
	
	.PARAMETER Description
		A description of the Description parameter.
	
	.EXAMPLE
				PS C:\> Set-CapaGroupDescription -CapaSDK $value1 -GroupName 'Value2' -GroupType Dynamic_ADSI
	
	.NOTES
		Additional information about the function.
#>
function Set-CapaGroupDescription
{
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
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246318/Set+Group+Folder
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246326/Set+Group+folder+in+a+Business+Unit
	
	.DESCRIPTION
		A detailed description of the Set-CapaGroupFolder function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER GroupName
		A description of the GroupName parameter.
	
	.PARAMETER GroupType
		A description of the GroupType parameter.
	
	.PARAMETER FolderStructure
		A description of the FolderStructure  parameter.
	
	.EXAMPLE
				PS C:\> Set-CapaGroupFolder -CapaSDK $value1 -GroupName $value2 -GroupType Dynamic_ADSI -FolderStructure  $value4
	
	.NOTES
		Additional information about the function.
#>
function Set-CapaGroupFolder
{
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
	
	if ($BusinessunitName -eq '')
	{
		$value = $CapaSDK.SetGroupFolder($GroupName, $GroupType, $FolderStructure)
	}
	else
	{
		$value = $CapaSDK.SetGroupFolderBU($GroupName, $GroupType, $FolderStructure, $BusinessunitName)
	}
	
	return $value
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246256/Get+application+groups
	
	.DESCRIPTION
		A detailed description of the Get-CapaApplicationGroups function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaApplicationGroups -CapaSDK $value1
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaApplicationGroups
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetApplicationGroups()
	
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Id		    = $aItem[0];
			Name	    = $aItem[1];
			Version	    = $aItem[2];
			Vendor	    = $aItem[3];
			AppCode	    = $aItem[4];
			Description = $aItem[5];
			GUID	    = $aItem[6]
		}
	}
	
	Return $oaUnits
}