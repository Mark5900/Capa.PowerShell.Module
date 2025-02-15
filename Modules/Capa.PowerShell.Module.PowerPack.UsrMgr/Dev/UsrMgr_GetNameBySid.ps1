# TODO: #506 Create tests for UsrMgr_GetNameBySid

<#
	.SYNOPSIS
		Gets the name of a user by its SID.

	.DESCRIPTION
		Gets the name of a user by its SID.

	.PARAMETER SID
		The SID of the user.

	.EXAMPLE
		UsrMgr_GetNameBySid -SID "S-1-5-21-3623811015-3361044348-30300820-1013"
#>
function UsrMgr_GetNameBySid {
	param (
		[Parameter(Mandatory=$true)]
		[string]$SID
	)

	return $Global:cs.UsrMgr_GetNameBySid($SID)
}