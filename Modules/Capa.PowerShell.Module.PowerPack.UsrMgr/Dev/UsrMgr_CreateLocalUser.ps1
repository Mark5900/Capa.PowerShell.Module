# TODO: #388 Update Get-Help for UsrMgr_CreateLocalUser

<#
	.SYNOPSIS
		Create a local user account.

	.PARAMETER UserName
		The name of the user to create.

	.PARAMETER FullName
		The full name of the user to create.

	.PARAMETER Password
		The password of the user to create.

	.PARAMETER Description
		The description of the user to create.

	.PARAMETER PasswordNeverExpire
		Set password never expire, default is $true.

	.EXAMPLE
		PS C:\> UsrMgr_CreateLocalUser -UserName "JohnDoe" -FullName "John Doe" -Password "P@ssw0rd"

	.EXAMPLE
		PS C:\> UsrMgr_CreateLocalUser -UserName "JohnDoe" -FullName "John Doe" -Password "P@ssw0rd" -Description "This is a test user."

	.EXAMPLE
		PS C:\> UsrMgr_CreateLocalUser -UserName "JohnDoe" -FullName "John Doe" -Password "P@ssw0rd" -PasswordNeverExpire $false

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462456193/cs.UsrMgr+CreateLocalUser
#>
function UsrMgr_CreateLocalUser {
	param (
		[Parameter(Mandatory = $true)]
		[string]$UserName,
		[Parameter(Mandatory = $true)]
		[string]$FullName,
		[Parameter(Mandatory = $true)]
		[string]$Password,
		[string]$Description,
		[bool]$PasswordNeverExpire = $true
	)

	$Global:cs.UsrMgr_CreateLocalUser($UserName, $FullName, $Password, $Description, $PasswordNeverExpire)
}