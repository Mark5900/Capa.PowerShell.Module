<#
	.SYNOPSIS
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246140/Set+database+settings
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246148/Set+default+management+point
		https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246158/Set+instance+management+point
	
	.DESCRIPTION
		A detailed description of the Initialize-CapaSDK function.
	
	.PARAMETER CapaSdkDllPath
		A description of the CapaSdkDllPath parameter.
	
	.PARAMETER Server
		A description of the Server parameter.
	
	.PARAMETER Database
		A description of the Database parameter.
	
	.PARAMETER UserName
		A description of the UserName parameter.
	
	.PARAMETER Password
		A description of the Password parameter.
	
	.PARAMETER DefaultManagementPoint
		A description of the DefaultManagementPoint parameter.
	
	.PARAMETER InstanceManagementPoint
		A description of the InstanceManagementPoint parameter.
	
	.EXAMPLE
		PS C:\> Initialize-CapaSDK -Server 'value1' -Database 'value2' -DefaultManagementPoint Dev
	
	.NOTES
		Additional information about the function.
#>
function Initialize-CapaSDK {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		[string]$Server,
		[Parameter(Mandatory = $true)]
		[string]$Database = '',
		[string]$UserName = '',
		[string]$Password = '',
		[Parameter(Mandatory = $false)]
		[string]$DefaultManagementPoint,
		[string]$InstanceManagementPoint
	)
	$oCMS = New-Object -ComObject CapaInstaller.SDK
	
	If ($UserName -ne '' -or $Password -ne '') {
		$oCMS.SetDatabaseSettings($Server, $Database, $true, $UserName, $Password) | Out-Null
	} else {
		$oCMS.SetDatabaseSettings($Server, $Database, $false) | Out-Null
	}
	
	if ($DefaultManagementPoint -ne '') {
		$oCMS.SetDefaultManagementPoint($DefaultManagementPoint) | Out-Null
	}
	
	if ($InstanceManagementPoint -ne '') {
		$oCMS.SetInstanceManagementPoint($InstanceManagementPoint) | Out-Null
	}
	
	$oCMS.SetSplitter(';') | Out-Null
	
	return $oCMS
}