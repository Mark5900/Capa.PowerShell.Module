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

function UsrMgr_EnumMembersOfLocalGroup {
	param (
		[Parameter(Mandatory = $true)]
		[string]$GroupName
	)
	
	$Value = $Global:cs.UsrMgr_EnumMembersOfLocalGroup($GroupName)
	
	return $Value
}

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

function UsrMgr_ChangePassword {
	param (
		[Parameter(Mandatory = $true)]
		[string]$UserName,
		[Parameter(Mandatory = $true)]
		[string]$Password
	)
	
	$Global:cs.UsrMgr_ChangePassword($UserName, $Password)
}

function UsrMgr_ExistLocalUserAccount {
	param (
		[Parameter(Mandatory = $true)]
		[string]$UserName
	)
	
	$Value = $Global:cs.UsrMgr_ExistLocalUserAccount($UserName)
	
	return $Value
}

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

function UsrMgr_DeleteLocalUserAccount {
	param (
		[Parameter(Mandatory = $true)]
		[string]$UserName
	)
	
	$Global:cs.UsrMgr_DeleteLocalUserAccount($UserName)
}