<#
	.SYNOPSIS
		Adds a user to a local group.

	.PARAMETER UserName
		The name of the user to add to the group.

	.PARAMETER GroupName
		The name of the group to add the user to.

	.PARAMETER SID
		The SID of the group to add the user to.

	.EXAMPLE
		PS C:\> UsrMgr_AddUserToLocalGroup -UserName "JohnDoe" -GroupName "Administrators"

	.EXAMPLE
		PS C:\> UsrMgr_AddUserToLocalGroup -UserName "JohnDoe" -GroupName "S-1-5-32-544"

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462456159/cs.UsrMgr+AddUserToLocalGroup
#>
function UsrMgr_AddUserToLocalGroup {
	param (
		[Parameter(Mandatory = $true)]
		[string]$UserName,
		[Parameter(Mandatory = $true)]
		[Alias('SID')]
		[string]$GroupName
	)
	
	$Global:cs.UsrMgr_AddUserToLocalGroup($UserName, $GroupName)
}

<#
	.SYNOPSIS
		Get group members of a local group.

	.PARAMETER GroupName
		The name of the group to get the members of.

	.EXAMPLE
		PS C:\> UsrMgr_EnumMembersOfLocalGroup -GroupName "Administrators"

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462456176/cs.UsrMgr+EnumMembersOfLocalGroup
#>
function UsrMgr_EnumMembersOfLocalGroup {
	param (
		[Parameter(Mandatory = $true)]
		[string]$GroupName
	)
	
	$Value = $Global:cs.UsrMgr_EnumMembersOfLocalGroup($GroupName)
	
	return $Value
}

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

<#
	.SYNOPSIS
		Check if a local user account exists.

	.PARAMETER UserName
		The name of the user to check for.

	.EXAMPLE
		PS C:\> UsrMgr_ExistLocalUserAccount -UserName "JohnDoe"

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462456227/cs.UsrMgr+ExistLocalUserAccount
#>
function UsrMgr_ExistLocalUserAccount {
	param (
		[Parameter(Mandatory = $true)]
		[string]$UserName
	)
	
	$Value = $Global:cs.UsrMgr_ExistLocalUserAccount($UserName)
	
	return $Value
}

<#
	.SYNOPSIS
		Remove a user from a local group.

	.PARAMETER UserName
		The name of the user to remove from the group.

	.PARAMETER GroupName
		The name of the group to remove the user from.

	.EXAMPLE
		PS C:\> UsrMgr_RemoveUserFromLocalGroup -UserName "JohnDoe" -GroupName "Administrators"

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462456244/cs.UsrMgr+RemoveUserFromLocalGroup
#>
function UsrMgr_RemoveUserFromLocalGroup {
	param (
		$Domain = '',
		[Parameter(Mandatory = $true)]
		[string]$UserName,
		[Parameter(Mandatory = $true)]
		[string]$GroupName
	)
	
	$Global:cs.UsrMgr_RemoveUserFromLocalGroup($Domain, $UserName, $GroupName)
}

<#
	.SYNOPSIS
		Delete a local user account.

	.PARAMETER UserName
		The name of the user to delete.

	.EXAMPLE
		PS C:\> UsrMgr_DeleteLocalUserAccount -UserName "JohnDoe"

	.NOTES
		For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462456261/cs.UsrMgr+DeleteLocalUserAccount
#>
function UsrMgr_DeleteLocalUserAccount {
	param (
		[Parameter(Mandatory = $true)]
		[string]$UserName
	)
	
	$Global:cs.UsrMgr_DeleteLocalUserAccount($UserName)
}