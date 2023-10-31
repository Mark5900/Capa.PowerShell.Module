# TODO: Update and add tests

<#
	.SYNOPSIS
		Create a new CapaSDK object that is needed for all other functions.

	.DESCRIPTION
		Create a new CapaSDK object that is needed for all other functions, with the option to set the database settings and management points.

	.PARAMETER Server
		The name of the server where the database is located.

	.PARAMETER Database
		The name of the database.

	.PARAMETER UserName
		If set, the database will be accessed with the given username and password.
		Default is to use Windows Authentication.

	.PARAMETER Password
		If set, the database will be accessed with the given username and password.
		Default is to use Windows Authentication.

	.PARAMETER DefaultManagementPoint
		Id of the default management point.
		DO NOT USE. This will set the management point for all SDK objects, use InstanceManagementPoint instead.

	.PARAMETER InstanceManagementPoint
		Id of the instance management point.
		Sets the management point for the current SDK object. Use DefaultManagementPoint to set the management point for all SDK objects.

	.EXAMPLE
		PS C:\> Initialize-CapaSDK -Server 'CAPASQL01' -Database 'CapaInstaller' -DefaultManagementPoint 1

	.EXAMPLE
		PS C:\> Initialize-CapaSDK -Server 'CAPASQL01' -Database 'CapaInstaller' -InstanceManagementPoint 1

	.EXAMPLE
		PS C:\> Initialize-CapaSDK -Server 'CAPASQL01' -Database 'CapaInstaller' -UserName 'sa' -Password 'P@ssw0rd' -DefaultManagementPoint 1

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246140/Set+database+settings
		And https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246148/Set+default+management+point
		And https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246158/Set+instance+management+point
		And https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246174/Set+splitter
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