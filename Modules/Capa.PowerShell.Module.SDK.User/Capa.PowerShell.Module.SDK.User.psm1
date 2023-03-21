<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247602/Get+Users
	
	.DESCRIPTION
		A detailed description of the Get-CapaUsers function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.EXAMPLE
				PS C:\> Get-CapaUsers -CapaSDK $value1
	
	.NOTES
		Additional information about the function.
#>
function Get-CapaUsers
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK
	)
	
	$oaUnits = @()
	
	$aUnits = $CapaSDK.GetUsers()
	
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

<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247356/Clear+Primary+User
	
	.DESCRIPTION
		A detailed description of the Clear-CapaPrimaryUser function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER Uuid
		A description of the Uuid parameter.
	
	.EXAMPLE
				PS C:\> Clear-CapaPrimaryUser -CapaSDK $value1 -Uuid 'Value2'
	
	.NOTES
		Additional information about the function.
#>
function Clear-CapaPrimaryUser
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$Uuid
	)
	
	$value = $CapaSDK.ClearPrimaryUser($Uuid)
	return $value
}


<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247714/Set+Primary+User
	
	.DESCRIPTION
		A detailed description of the Set-CapaPrimaryUser function.
	
	.PARAMETER CapaSDK
		A description of the CapaSDK parameter.
	
	.PARAMETER Uuid
		A description of the Uuid parameter.
	
	.PARAMETER UserIdentifier
		A description of the UserIdentifier parameter.
	
	.EXAMPLE
				PS C:\> Set-CapaPrimaryUser -CapaSDK $value1 -Uuid 'Value2' -UserIdentifier 'Value3'
	
	.NOTES
		Additional information about the function.
#>
function Set-CapaPrimaryUser
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[String]$Uuid,
		[Parameter(Mandatory = $true)]
		[String]$UserIdentifier
	)
	
	$value = $CapaSDK.SetPrimaryUser($Uuid, $UserIdentifier)
	return $value
}