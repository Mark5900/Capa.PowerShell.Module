<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247078/Count+conscom+actions
	
	.DESCRIPTION
		A detailed description of the Count-CapaConscomActions function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER ManagementServerID
		A description of the ManagementServerID parameter.
	
	.EXAMPLE
				PS C:\> Count-CapaConscomActions -CapaSDK $value1 -ManagementServerID $value2
	
	.NOTES
		Additional information about the function.
#>
function Count-CapaConscomActions
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$ManagementServerID
	)
	
	$value = $CapaSDK.CountConscomActions($ManagementServerID)
	return $value
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247086/Get+Business+Units
	
	.DESCRIPTION
		A detailed description of the Get-CapaBusinessUnits function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaBusinessUnits -CapaSDK $value1
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaBusinessUnits
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetBusinessUnits()
	
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Name = $aItem[0];
			GUID = $aItem[1];
			Id   = $aItem[2]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247096/Get+external+tools
	
	.DESCRIPTION
		A detailed description of the Get-CapaExternalTools function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaExternalTools -CapaSDK $value1
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaExternalTools
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetExternalTools()
	
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			ID	      = $aItem[0];
			Name	  = $aItem[1];
			Path	  = $aItem[2];
			Arguments = $aItem[3]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247106/Get+management+point
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247116/Get+management+points
	
	.DESCRIPTION
		A detailed description of the Get-CapaManagementPoint function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER CmpId
		A description of the CmpId parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaManagementPoint -CapaSDK $value1 -CmpId $value2
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaManagementPoint
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[int]$CmpId = ''
	)
	
	$oaUnits = @()
	
	if ($CmpId -eq '')
	{
		$aUnits = $CapaSDK.GetManagementPoints()
	}
	else
	{
		$aUnits = $CapaSDK.GetManagementPoint($OSPointID)
	}
	
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Id		    = $aItem[0];
			Name	    = $aItem[1];
			Description = $aItem[2];
			Drive	    = $aItem[3];
			GUID	    = $aItem[4];
			LocalFolder = $aItem[5];
			Server	    = $aItem[7];
			Share	    = $aItem[8];
			ParentGUID  = $aItem[9]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247126/Get+management+servers
	
	.DESCRIPTION
		A detailed description of the Get-CapaManagementServers function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaManagementServers -CapaSDK $value1
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaManagementServers
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetManagementServers()
	
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Name		  = $aItem[0];
			Path		  = $aItem[1];
			Version	      = $aItem[2];
			Drive		  = $aItem[3];
			Server	      = $aItem[4];
			Share		  = $aItem[5];
			IsParentShare = $aItem[7];
			GUID		  = $aItem[8];
			ID		      = $aItem[9]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247136/Rebuild+kit+on+Management+Point
	
	.DESCRIPTION
		A detailed description of the Rebuild-CapaKitFileOnPoint function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER PackageName
		A description of the PackageName  parameter.
	
	.PARAMETER PackageVersion
		A description of the PackageVersion  parameter.
	
	.PARAMETER PackageType
		A description of the PackageType  parameter.
	
	.PARAMETER PointID
		A description of the PointID parameter.
	
	.EXAMPLE
				PS C:\> Rebuild-CapaKitFileOnPoint -CapaSDK $value1 -PackageName  'Value2' -PackageVersion  'Value3' -PackageType  'Value4' -PointID $value5
	
	.NOTES
		Additional information about the function.
#>
function Rebuild-CapaKitFileOnPoint
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$PackageName,
		[Parameter(Mandatory = $true)]
		[String]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('1', '2', 'Computer', 'User')]
		[String]$PackageType,
		[Parameter(Mandatory = $true)]
		[int]$PointID
	)
	
	if ($PackageType -eq 'Computer')
	{
		$PackageType = '1'
	}
	if ($PackageType -eq 'User')
	{
		$PackageType = '2'
	}
	
	$value = $CapaSDK.RebuildKitFileOnPoint($PackageName, $PackageVersion, $PackageType, $PointID)
	return $value
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247144/Rebuild+kit+on+Management+Server
	
	.DESCRIPTION
		A detailed description of the Rebuild-CapaKitFileOnServer function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER PackageName
		A description of the PackageName  parameter.
	
	.PARAMETER PackageVersion
		A description of the PackageVersion parameter.
	
	.PARAMETER PackageType
		A description of the PackageType  parameter.
	
	.PARAMETER ServerName
		A description of the ServerName  parameter.
	
	.EXAMPLE
				PS C:\> Rebuild-CapaKitFileOnServer -CapaSDK $value1 -PackageName  'Value2' -PackageVersion 'Value3' -PackageType  'Value4' -ServerName  'Value5'
	
	.NOTES
		Additional information about the function.
#>
function Rebuild-CapaKitFileOnManagementServer
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$PackageName,
		[Parameter(Mandatory = $true)]
		[String]$PackageVersion,
		[Parameter(Mandatory = $true)]
		[ValidateSet('1', '2', 'Computer', 'User')]
		[String]$PackageType,
		[Parameter(Mandatory = $true)]
		[String]$ServerName
	)
	
	if ($PackageType -eq 'Computer')
	{
		$PackageType = '1'
	}
	if ($PackageType -eq 'User')
	{
		$PackageType = '2'
	}
	
	$value = $CapaSDK.RebuildKitFileOnServer($PackageName, $PackageVersion, $PackageType, $ServerName)
	return $value
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247152/Reset+LastRun+Date+On+Global+Task
	
	.DESCRIPTION
		A detailed description of the Reset-CapaLastRunDateOnGlobalTask function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER TaskDisplayName
		A description of the TaskDisplayName parameter.
	
	.EXAMPLE
				PS C:\> Reset-CapaLastRunDateOnGlobalTask -CapaSDK $value1 -TaskDisplayName 'Auto Archive Changelog'
	
	.NOTES
		Additional information about the function.
#>
function Reset-CapaLastRunDateOnGlobalTask
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Auto Archive Changelog', 'Cleanup Performance Index Data', 'Clear Changeset', 'Clear Deleted Units', 'Group Health Check', 'Inventory Cleanup', 'Process Metering History', 'Process SQL groups', 'System Health', 'Update Active Directory Groups', 'Update Application Groups', 'Update OS Version', 'Update Unit Commands', 'Update Unlicensed Software Queries')]
		[string]$TaskDisplayName
	)
	
	$value = $CapaSDK.ResetLastRunOnGlobalTask($TaskDisplayName)
	return $value
}