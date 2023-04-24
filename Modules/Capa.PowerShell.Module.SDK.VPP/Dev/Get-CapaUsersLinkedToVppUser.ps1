<#
	.SYNOPSIS
		Gets a list of users linked to a VPP user.
	
	.DESCRIPTION
		Gets a list of users linked to a vpp user, including inventory variables like full name and emails.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER VppUserID
		The ID of the VPP user.
	
	.EXAMPLE
		Get-CapaUsersLinkedToVppUser -CapaSDK $CapaSDK -VppUserID 1
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247612/Get+users+linked+to+vpp+user
#>
function Get-CapaUsersLinkedToVppUser {
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
	
	foreach ($sItem in $aUnits) {
		$aItem = $sItem.Split(';')
		$oaUnits += [pscustomobject]@{
			Name           = $aItem[0];
			Created        = $aItem[1];
			LastExecuted   = $aItem[2];
			Status         = $aItem[3];
			Description    = $aItem[4];
			GUID           = $aItem[5];
			ID             = $aItem[7];
			TypeName       = $aItem[8];
			UUID           = $aItem[9];
			Location       = $aItem[10];
			FullName       = $aItem[11];
			EmailPrimary   = $aItem[12];
			EmailSecondary = $aItem[13];
			EmailTertiary  = $aItem[14]
		}
	}
	
	Return $oaUnits
}
