# TODO: Update and add tests

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
