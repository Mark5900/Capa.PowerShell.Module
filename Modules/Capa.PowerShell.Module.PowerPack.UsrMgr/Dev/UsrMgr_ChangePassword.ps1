# TODO: #387 Update Get-Help for UsrMgr_ChangePassword

<#
	.SYNOPSIS
		Change the password of a local user account.

	.PARAMETER UserName
		The name of the user to change the password of.

	.PARAMETER Password
		The new password of the user.

	.EXAMPLE
		PS C:\> UsrMgr_ChangePassword -UserName "JohnDoe" -Password "P@ssw0rd"

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462456210/cs.UsrMgr+ChangePassword
#>
function UsrMgr_ChangePassword {
	param (
		[Parameter(Mandatory = $true)]
		[string]$UserName,
		[Parameter(Mandatory = $true)]
		[string]$Password
	)

	$Global:cs.UsrMgr_ChangePassword($UserName, $Password)
}