# TODO: Update and add tests

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
