<#
	.SYNOPSIS
		Clone an existing Device Application and its payloads.
	
	.DESCRIPTION
		Clone an existing Device Application and its payloads.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER DeviceApplicationID
		The id of the Device Application you wish to clone.
	
	.PARAMETER NewName
		The name of the new Device Application.
	
	.PARAMETER ChangelogComment
		The comment you wish to be added to the changelog.
	
	.EXAMPLE
		PS C:\> Clone-CapaDeviceApplication -CapaSDK $CapaSDK -DeviceApplicationID 1 -NewName 'My New Device Application' -ChangelogComment 'Cloning Device Application'
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246561/Clone+Device+Application
#>
function Clone-CapaDeviceApplication {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$DeviceApplicationID,
		[Parameter(Mandatory = $true)]
		[string]$NewName,
		[string]$ChangelogComment = ''
	)
	
	$value = $CapaSDK.CloneDeviceApplication($DeviceApplicationID, $NewName, $ChangelogComment)
	return $value
}
