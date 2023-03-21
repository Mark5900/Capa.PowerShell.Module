<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247844/Get+WSUS+Groups
	
	.DESCRIPTION
		A detailed description of the Get-CapaWSUSGroups function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER PointID
		A description of the PointID  parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaWSUSGroups -CapaSDK $value1 -PointID  $value2
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaWSUSGroups
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$PointID
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetWSUSGroups($PointID)
	
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			ID   = $aItem[0];
			Name = $aItem[1];
			GUID = $aItem[2]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247854/Get+WSUS+points
	
	.DESCRIPTION
		A detailed description of the Get-CapaWSUSPoints function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaWSUSPoints -CapaSDK $value1
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaWSUSPoints
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetWSUSPoints()
	
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			ID   = $aItem[0];
			Name = $aItem[1];
			GUID = $aItem[2]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247622/Get+WSUS+Group+units
	
	.DESCRIPTION
		A detailed description of the Get-CapaWSUSGroupUnits function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER WSUSGroupName
		A description of the WSUSGroupName parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaWSUSGroupUnits -CapaSDK $value1 -WSUSGroupName 'Value2'
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaWSUSGroupUnits
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$WSUSGroupName
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetOSDiskConfiguration($OSPointID)
	
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Name		   = $aItem[0];
			Created	       = $aItem[1];
			LastExecuted   = $aItem[2];
			Status		   = $aItem[3];
			Description    = $aItem[4];
			GUID		   = $aItem[5];
			ID			   = $aItem[7];
			TypeName	   = $aItem[8];
			UUID		   = $aItem[9];
			IsMobileDevice = $aItem[10];
			Location	   = $aItem[11]
		}
	}
	
	Return $oaUnits
}