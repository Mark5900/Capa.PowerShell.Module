<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246664/Get+OS+disk+configurations
	
	.DESCRIPTION
		A detailed description of the Get-CapaOSDiskConfigration function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER OSPointID
		A description of the OSPointID parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaOSDiskConfigration -CapaSDK $value1 -OSPointID $value2
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaOSDiskConfigration
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$OSPointID
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetOSDiskConfiguration($OSPointID)
	
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			ID		    = $aItem[0];
			Name	    = $aItem[1];
			Comment	    = $aItem[2];
			GUID	    = $aItem[3];
			Laptop	    = $aItem[4];
			LeaveDisk   = $aItem[5];
			WorkStation = $aItem[6]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246676/Get+OS+images
	
	.DESCRIPTION
		A detailed description of the Get-CapaOSImages function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER OSPointID
		A description of the OSPointID parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaOSImages -CapaSDK $value1 -OSPointID $value2
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaOSImages
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$OSPointID
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetOSImages($OSPointID)
	
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			ID		    = $aItem[0];
			Name	    = $aItem[1];
			Description = $aItem[2];
			Filename    = $aItem[3];
			GUID	    = $aItem[4];
			ImageFile   = $aItem[5];
			LocalFile   = $aItem[6];
			OSName	    = $aItem[7]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246688/Get+OS+installation+types
	
	.DESCRIPTION
		A detailed description of the Get-CapaOSInstallationTypes function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER OSPointID
		A description of the OSPointID  parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaOSInstallationTypes -CapaSDK $value1 -OSPointID  $value2
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaOSInstallationTypes
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$OSPointID
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetOSInstallationTypes($OSPointID)
	
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			ID   = $aItem[0];
			GUID = $aItem[1];
			Type = $aItem[2]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246700/Get+OS+points
	
	.DESCRIPTION
		A detailed description of the Get-CapaOSPoints function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaOSPoints -CapaSDK $value1
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaOSPoints
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetOSPoints($OSPointID)
	
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			ID			      = $aItem[0];
			Name			  = $aItem[1];
			Description	      = $aItem[2];
			GUID			  = $aItem[3];
			FileBoot		  = $aItem[4];
			FileDriverMapping = $aItem[5];
			FileOSDGui	      = $aItem[6];
			FolderCommonFiles = $aItem[7];
			FolderDrivers	  = $aItem[8];
			FolderImages	  = $aItem[9];
			FolderOSD		  = $aItem[10];
			FolderMediaMaster = $aItem[11];
			FolderScripts	  = $aItem[12];
			FolderWinPE	      = $aItem[13];
			OSDVersion	      = $aItem[14];
			Servername	      = $aItem[15];
			Sharename		  = $aItem[16];
			UncPath		      = $aItem[17]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246710/Get+OS+servers
	
	.DESCRIPTION
		A detailed description of the Get-CapaOSServers function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER OSPointID
		A description of the OSPointID parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaOSServers -CapaSDK $value1 -OSPointID $value2
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaOSServers
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$OSPointID
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetOSServers($OSPointID)
	
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			ID		   = $aItem[0];
			Name	   = $aItem[1];
			IP		   = $aItem[2];
			Servername = $aItem[3];
			Sharename  = $aItem[4];
			UncPath    = $aItem[5]
		}
	}
	
	Return $oaUnits
}