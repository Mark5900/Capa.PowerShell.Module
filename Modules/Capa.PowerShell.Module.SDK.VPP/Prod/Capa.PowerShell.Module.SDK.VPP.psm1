
<#
	.SYNOPSIS
		Gets a list of devices linked to a VPP user.

	.DESCRIPTION
		Gets a list of devices linked to a VPP user.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER vppUserID
		The ID of the VPP user.

	.EXAMPLE
		Get-CapaDevicesLinkedToVppUser -CapaSDK $CapaSDK -vppUserID 1

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247426/Get+devices+linked+to+vpp+user
#>
function Get-CapaDevicesLinkedToVppUser {
	[CmdletBinding()]
	[OutputType([pscustomobject[]])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateRange(1, [int]::MaxValue)]
		[Int]$vppUserID
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'GetDevicesLinkedToVppUser')) {
		throw 'CapaSDK does not contain method GetDevicesLinkedToVppUser.'
	}

	$aUnits = $CapaSDK.GetDevicesLinkedToVppUser($vppUserID)
	if ($null -eq $aUnits) {
		return @()
	}

	$oaUnits = foreach ($sItem in $aUnits) {
		if ([string]::IsNullOrWhiteSpace([string]$sItem)) {
			continue
		}

		$aItem = [string]$sItem -split ';', 12
		if ($aItem.Count -lt 12) {
			continue
		}

		[pscustomobject]@{
			Name           = $aItem[0];
			Created        = $aItem[1];
			LastExecuted   = $aItem[2];
			Status         = $aItem[3];
			Description    = $aItem[4];
			GUID           = $aItem[5];
			ID             = $aItem[7];
			TypeName       = $aItem[8];
			UUID           = $aItem[9];
			IsMobileDevice = $aItem[10];
			Location       = $aItem[11]
		}
	}

	return @($oaUnits)
}


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
	[OutputType([pscustomobject[]])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateRange(1, [int]::MaxValue)]
		[int]$VppUserID
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'GetUsersLinkedToVppUser')) {
		throw 'CapaSDK does not contain method GetUsersLinkedToVppUser.'
	}

	$aUnits = $CapaSDK.GetUsersLinkedToVppUser($VppUserID)
	if ($null -eq $aUnits) {
		return @()
	}

	$oaUnits = foreach ($sItem in $aUnits) {
		if ([string]::IsNullOrWhiteSpace([string]$sItem)) {
			continue
		}

		$aItem = [string]$sItem -split ';', 15
		if ($aItem.Count -lt 15) {
			continue
		}

		[pscustomobject]@{
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

	return @($oaUnits)
}


<#
	.SYNOPSIS
		Gets a list of all VPP programs.

	.DESCRIPTION
		Gets a list of all VPP programs.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.EXAMPLE
		Get-CapaVppPrograms -CapaSDK $CapaSDK

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247798/Get+vpp+programs
#>
function Get-CapaVppPrograms {
	[CmdletBinding()]
	[OutputType([pscustomobject[]])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'GetVppPrograms')) {
		throw 'CapaSDK does not contain method GetVppPrograms.'
	}

	$aUnits = $CapaSDK.GetVppPrograms()
	if ($null -eq $aUnits) {
		return @()
	}

	$oaUnits = foreach ($sItem in $aUnits) {
		if ([string]::IsNullOrWhiteSpace([string]$sItem)) {
			continue
		}

		$aItem = [string]$sItem -split ';', 8
		if ($aItem.Count -lt 8) {
			continue
		}

		[pscustomobject]@{
			ID               = $aItem[0];
			Name             = $aItem[1];
			OrganisationName = $aItem[2];
			Email            = $aItem[3];
			ExpireDate       = $aItem[4];
			GUID             = $aItem[5];
			Description      = $aItem[7]
		}
	}

	return @($oaUnits)
}


<#
	.SYNOPSIS
		Gets a list of all VPP users.

	.DESCRIPTION
		Gets a list of all VPP users, if VppProgramID is specified, only VPP users for the specified program will be returned.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER VppProgramID
		A description of the VppProgramID parameter.

	.EXAMPLE
			Get-CapaVppUsers -CapaSDK $CapaSDK

	.EXAMPLE
			Get-CapaVppUsers -CapaSDK $CapaSDK -VppProgramID 1

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247808/Get+vpp+users
		And https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247818/Get+vpp+users+all
#>
function Get-CapaVppUsers {
	[CmdletBinding()]
	[OutputType([pscustomobject[]])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $false)]
		[ValidateRange(1, [int]::MaxValue)]
		[Nullable[int]]$VppProgramID = $null
	)

	if ($PSBoundParameters.ContainsKey('VppProgramID') -and -not ($CapaSDK.PSObject.Methods.Name -contains 'GetVppUsers')) {
		throw 'CapaSDK does not contain method GetVppUsers.'
	}

	if (-not $PSBoundParameters.ContainsKey('VppProgramID') -and -not ($CapaSDK.PSObject.Methods.Name -contains 'GetVppUsersAll')) {
		throw 'CapaSDK does not contain method GetVppUsersAll.'
	}

	if ($PSBoundParameters.ContainsKey('VppProgramID')) {
		$aUnits = $CapaSDK.GetVppUsers($VppProgramID)
	} else {
		$aUnits = $CapaSDK.GetVppUsersAll()
	}

	if ($null -eq $aUnits) {
		return @()
	}

	$oaUnits = foreach ($sItem in $aUnits) {
		if ([string]::IsNullOrWhiteSpace([string]$sItem)) {
			continue
		}

		$aItem = [string]$sItem -split ';', 14
		if ($aItem.Count -lt 14) {
			continue
		}

		[pscustomobject]@{
			ID              = $aItem[0];
			Status          = $aItem[1];
			Updated         = $aItem[2];
			UserID          = $aItem[3];
			ClientUserIDStr = $aItem[4];
			Name            = $aItem[5];
			Description     = $aItem[7];
			Email           = $aItem[8];
			ItsIdHash       = $aItem[9];
			InviteUrl       = $aItem[10];
			InviteCode      = $aItem[11];
			VPPAccountID    = $aItem[12];
			GUID            = $aItem[13]
		}
	}

	return @($oaUnits)
}


<#
	.SYNOPSIS
		Creates a VPP user at Apple where an invitation URL is generated. This invitation is then sent to the device where the user will have the option to accept or decline.

	.DESCRIPTION
		Creates a VPP user at Apple where an invitation URL is generated. This invitation is then sent to the device where the user will have the option to accept or decline.
		If the user accepts the invitation, its Apple ID will be linked to the VPP user at Apple, which can be seen in the system after the next synchronization cycle.

		There are a few requirements for the operation to succeed.
			The device must be running iOS8 or higher.
			The device should not already be enrolled in the Volume Purchase Program specified.
			If an invitation previously sent to the device was not accepted, a VPP user will already exist at Apple. In order to avoid creating multiple VPP users, the system will reuse that original invitation and send it to the device again.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER VppProgramID
		The VPP user will be created in the program with the specified id.

	.PARAMETER UnitID
		The id of the iOS device which should receive an invitation.

	.PARAMETER UserFullName
		The fullname of the vpp user being created.

	.PARAMETER UserEmailName
		The email of the vpp user being created.

	.PARAMETER UserDescription
		The description of the vpp user being created.

	.EXAMPLE
		Invite-CapaUnitToVppProgram -CapaSDK $CapaSDK -VppProgramID 1 -UnitID 1 -UserFullName 'Test User' -UserEmailName 'Test@test.com' -UserDescription 'Test User'

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247828/Invite+unit+to+vpp
#>
function Invite-CapaUnitToVppProgram {
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
	[OutputType([bool])]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateNotNull()]
		[pscustomobject]$CapaSDK,
		[Parameter(Mandatory = $true)]
		[ValidateRange(1, [int]::MaxValue)]
		[int]$VppProgramID,
		[Parameter(Mandatory = $true)]
		[ValidateRange(1, [int]::MaxValue)]
		[int]$UnitID,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$UserFullName,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$UserEmailName,
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$UserDescription
	)

	if (-not ($CapaSDK.PSObject.Methods.Name -contains 'InviteUnitToVppProgram')) {
		throw 'CapaSDK does not contain method InviteUnitToVppProgram.'
	}

	$target = "UnitID '$UnitID'"
	$action = "Invite unit to VPP program '$VppProgramID'"

	if (-not $PSCmdlet.ShouldProcess($target, $action)) {
		return $false
	}

	$value = $CapaSDK.InviteUnitToVppProgram($VppProgramID, $UnitID, $UserFullName, $UserEmailName, $UserDescription)
	return $value
}


