
<#
	.SYNOPSIS
		Gets a list of OS Disk Configurations.
	
	.DESCRIPTION
		Gets a list of OS Disk Configurations.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER OSPointID
		The ID of the OS Point.
	
	.EXAMPLE
		PS C:\> Get-CapaOSDiskConfigration -CapaSDK $CapaSDK -OSPointID 1
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246664/Get+OS+disk+configurations
#>
function Get-CapaOSDiskConfigration {
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
	
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			ID          = $aItem[0];
			Name        = $aItem[1];
			Comment     = $aItem[2];
			GUID        = $aItem[3];
			Laptop      = $aItem[4];
			LeaveDisk   = $aItem[5];
			WorkStation = $aItem[6]
		}
	}
	
	Return $oaUnits
}


<#
	.SYNOPSIS
		Gets a list of OS Images.
	
	.DESCRIPTION
		Gets a list of OS Images.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER OSPointID
		The ID of the OS Point.
	
	.EXAMPLE
		PS C:\> Get-CapaOSImages -CapaSDK $CapaSDK -OSPointID 1
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246676/Get+OS+images
#>
function Get-CapaOSImages {
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
	
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			ID          = $aItem[0];
			Name        = $aItem[1];
			Description = $aItem[2];
			Filename    = $aItem[3];
			GUID        = $aItem[4];
			ImageFile   = $aItem[5];
			LocalFile   = $aItem[6];
			OSName      = $aItem[7]
		}
	}
	
	Return $oaUnits
}


<#
	.SYNOPSIS
		Get a list of OS Installation Types.
	
	.DESCRIPTION
		Get a list of OS Installation Types.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER OSPointID
		The ID of the OS Point.
	
	.EXAMPLE
		PS C:\> Get-CapaOSInstallationTypes -CapaSDK $CapaSDK -OSPointID 1
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246688/Get+OS+installation+types
#>
function Get-CapaOSInstallationTypes {
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
	
	foreach ($sItem in $aUnits) {
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
		Gets a list of OS Points.
	
	.DESCRIPTION
		Gets a list of OS Points.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.EXAMPLE
		PS C:\> Get-CapaOSPoints -CapaSDK $CapaSDK
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246700/Get+OS+points
#>
function Get-CapaOSPoints {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetOSPoints($OSPointID)
	
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			ID                = $aItem[0];
			Name              = $aItem[1];
			Description       = $aItem[2];
			GUID              = $aItem[3];
			FileBoot          = $aItem[4];
			FileDriverMapping = $aItem[5];
			FileOSDGui        = $aItem[6];
			FolderCommonFiles = $aItem[7];
			FolderDrivers     = $aItem[8];
			FolderImages      = $aItem[9];
			FolderOSD         = $aItem[10];
			FolderMediaMaster = $aItem[11];
			FolderScripts     = $aItem[12];
			FolderWinPE       = $aItem[13];
			OSDVersion        = $aItem[14];
			Servername        = $aItem[15];
			Sharename         = $aItem[16];
			UncPath           = $aItem[17]
		}
	}
	
	Return $oaUnits
}


<#
	.SYNOPSIS
		Gets a list of OS Servers including sub servers.
	
	.DESCRIPTION
		Gets a list of OS Servers including sub servers.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER OSPointID
		The ID of the OS Point.
	
	.EXAMPLE
		PS C:\> Get-CapaOSServers -CapaSDK $CapaSDK -OSPointID 1
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246710/Get+OS+servers
#>
function Get-CapaOSServers {
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
	
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			ID         = $aItem[0];
			Name       = $aItem[1];
			IP         = $aItem[2];
			Servername = $aItem[3];
			Sharename  = $aItem[4];
			UncPath    = $aItem[5]
		}
	}
	
	Return $oaUnits
}


