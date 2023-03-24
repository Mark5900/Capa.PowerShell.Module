<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247828/Invite+unit+to+vpp
	
	.DESCRIPTION
		A detailed description of the Invite-CapaUnitToVppProgram function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER VppProgramID
		A description of the VppProgramID  parameter.
	
	.PARAMETER UnitID
		A description of the UnitID  parameter.
	
	.PARAMETER UserFullName
		A description of the UserFullName  parameter.
	
	.PARAMETER UserEmailName
		A description of the UserEmailName  parameter.
	
	.PARAMETER UserDescription
		A description of the UserDescription  parameter.
	
	.EXAMPLE
				PS C:\> Invite-CapaUnitToVppProgram -CapaSDK $value1 -VppProgramID  $value2 -UnitID  $value3 -UserFullName  'Value4' -UserEmailName  'Value5' -UserDescription  'Value6'
	
	.NOTES
		Additional information about the function.
#>
function Invite-CapaUnitToVppProgram
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$VppProgramID,
		[Parameter(Mandatory = $true)]
		[int]$UnitID,
		[Parameter(Mandatory = $true)]
		[String]$UserFullName,
		[Parameter(Mandatory = $true)]
		[String]$UserEmailName,
		[Parameter(Mandatory = $true)]
		[String]$UserDescription
	)
	
	$value = $CapaSDK.InviteUnitToVppProgram($VppProgramID, $UnitID, $UserFullName, $UserEmailName, $UserDescription)
	return $value
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247808/Get+vpp+users
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247818/Get+vpp+users+all
	
	.DESCRIPTION
		A detailed description of the Get-CapaVppUsers function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER VppProgramID
		A description of the VppProgramID parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaVppUsers -CapaSDK $value1
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaVppUsers
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[int]$VppProgramID = ''
	)
	
	$oaUnits = @()
	
	if ($VppProgramID -eq '')
	{
		$aUnits = $CapaSDK.GetVppUsersAll()
	}
	Else
	{
		$aUnits = $CapaSDK.GetVppUsers($VppProgramID)
	}
	
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			ID			    = $aItem[0];
			Status		    = $aItem[1];
			Updated		    = $aItem[2];
			UserID		    = $aItem[3];
			ClientUserIDStr = $aItem[4];
			Name		    = $aItem[5];
			Description	    = $aItem[7];
			Email		    = $aItem[8];
			ItsIdHash	    = $aItem[9];
			InviteUrl	    = $aItem[10];
			InviteCode	    = $aItem[11];
			VPPAccountID    = $aItem[12];
			GUID		    = $aItem[13]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247798/Get+vpp+programs
	
	.DESCRIPTION
		A detailed description of the Get-CapaVppPrograms function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaVppPrograms -CapaSDK $value1
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaVppPrograms
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetVppPrograms()
	
	foreach ($sItem in $aUnits)
	{
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			ID			     = $aItem[0];
			Name			 = $aItem[1];
			OrganisationName = $aItem[2];
			Email		     = $aItem[3];
			ExpireDate	     = $aItem[4];
			GUID			 = $aItem[5];
			Description	     = $aItem[7]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247426/Get+devices+linked+to+vpp+user
	
	.DESCRIPTION
		A detailed description of the Get-CapaDevicesLinkedToVppUser function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER vppUserID
		A description of the vppUserID  parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaDevicesLinkedToVppUser -CapaSDK $value1 -vppUserID  $value2
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaDevicesLinkedToVppUser
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[Integer]$vppUserID
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetDevicesLinkedToVppUser($vppUserID)
	
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
			location	   = $aItem[11]
		}
	}
	
	Return $oaUnits
}

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247612/Get+users+linked+to+vpp+user
	
	.DESCRIPTION
		A detailed description of the Get-CapaUsersLinkedToVppUser function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER VppUserID
		A description of the VppUserID  parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaUsersLinkedToVppUser -CapaSDK $value1 -VppUserID  $value2
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaUsersLinkedToVppUser
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$VppUserID
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetUsersLinkedToVppUser($VppUserID)
	
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
			Location	   = $aItem[10];
			FullName	   = $aItem[11];
			EmailPrimary   = $aItem[12];
			EmailSecondary = $aItem[13];
			EmailTertiary  = $aItem[14]
		}
	}
	
	Return $oaUnits
}