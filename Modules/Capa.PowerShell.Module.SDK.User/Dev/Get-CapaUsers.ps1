<#
	.SYNOPSIS
		Get a list of all users.

	.DESCRIPTION
		Get a list of all users.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.EXAMPLE
		PS C:\> Get-CapaUsers -CapaSDK $CapaSDK

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247602/Get+Users
#>
function Get-CapaUsers {
	[CmdletBinding()]
	[OutputType([object[]])]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'GetUsers')) {
		throw 'CapaSDK does not contain method GetUsers.'
	}

	$aUnits = $CapaSDK.GetUsers()
	if ($null -eq $aUnits) {
		return @()
	}

	$oaUnits = foreach ($sItem in $aUnits) {
		if ([string]::IsNullOrWhiteSpace([string]$sItem)) {
			continue
		}

		$aItem = [string]$sItem -split ';'
		if ($aItem.Count -lt 15) {
			continue
		}

		[pscustomobject]@{
			Name           = $aItem[0]
			Created        = $aItem[1]
			LastExecuted   = $aItem[2]
			Status         = $aItem[3]
			Description    = $aItem[4]
			GUID           = $aItem[5]
			ID             = $aItem[7]
			TypeName       = $aItem[8]
			UUID           = $aItem[9]
			Location       = $aItem[10]
			FullName       = $aItem[11]
			EmailPrimary   = $aItem[12]
			EmailSecondary = $aItem[13]
			EmailTertiary  = $aItem[14]
		}
	}

	return @($oaUnits)
}
