
<#
	.SYNOPSIS
		Clear the primary user on a unit.

	.DESCRIPTION
		Clear the primary user on a unit.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER Uuid
		The UUID of the unit or device.

	.EXAMPLE
		PS C:\> Clear-CapaPrimaryUser -CapaSDK $CapaSDK -Uuid 'B16BAC7B-2975-431C-A380-B702B1A83AF4'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247356/Clear+Primary+User
#>
function Clear-CapaPrimaryUser {
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[ValidatePattern('^[{(]?[0-9a-fA-F]{8}[-]?[0-9a-fA-F]{4}[-]?[0-9a-fA-F]{4}[-]?[0-9a-fA-F]{4}[-]?[0-9a-fA-F]{12}[)}]?$')]
		[String]$Uuid
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'ClearPrimaryUser')) {
		throw 'CapaSDK does not contain method ClearPrimaryUser.'
	}

	if ($PSCmdlet.ShouldProcess($Uuid, 'Clear primary user')) {
		$value = $CapaSDK.ClearPrimaryUser($Uuid)
		return $value
	}
}


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


<#
	.SYNOPSIS
		Set the primary user on a unit.

	.DESCRIPTION
		Set the primary user on a unit.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER Uuid
		The UUID of the unit or device.

	.PARAMETER UserIdentifier
		The user that you want to set as primary on the unit, format accepted:
			SID: S-1-5-21-2955346805-1668228357-4012311724-500
			UPN: tbs@capasystems.com
			Name: tbs

	.EXAMPLE
		PS C:\> Set-CapaPrimaryUser -CapaSDK $CapaSDK -Uuid 'B16BAC7B-2975-431C-A380-B702B1A83AF4' -UserIdentifier 'tbs'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247714/Set+Primary+User
#>
function Set-CapaPrimaryUser {
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[ValidatePattern('^[{(]?[0-9a-fA-F]{8}[-]?[0-9a-fA-F]{4}[-]?[0-9a-fA-F]{4}[-]?[0-9a-fA-F]{4}[-]?[0-9a-fA-F]{12}[)}]?$')]
		[String]$Uuid,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$UserIdentifier
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'SetPrimaryUser')) {
		throw 'CapaSDK does not contain method SetPrimaryUser.'
	}

	if ($PSCmdlet.ShouldProcess($Uuid, "Set primary user '$UserIdentifier'")) {
		$value = $CapaSDK.SetPrimaryUser($Uuid, $UserIdentifier)
		return $value
	}
}


