# TODO: #135 Update and add tests

<#
	.SYNOPSIS
		This will add a new Exchange payload to a profile.

	.DESCRIPTION
		This will add a new Exchange payload to a profile.

	.PARAMETER CapaSDK
		The CapaSDK object.

	.PARAMETER ProfileID
		The ID of the profile you wish to add the Exchange payload to.

	.PARAMETER AccountName
		Name of the Exchange ActiveSync/Web Services account.

	.PARAMETER DomainandUserName
		The domain and username of the Exchange account.
		If missing, the devices prompts for it during profile installation.

	.PARAMETER Password
		The password of the Exchange account.

	.PARAMETER EmailAddress
		Specifies the full email address for the account. The owners (primary user) email address must be injected upon delivery to the device.
		If not present in the payload, the device prompts for this string during profile installation.

	.PARAMETER ExchangeActiveSyncHost
		Specifies the Exchange server host name (or IP address).

	.PARAMETER UseSSL
		Specifies whether the Exchange server uses SSL for authentication.

	.PARAMETER PastDaysofMailtoSync
		The number of past days of mail to synchronize. No limit = 0. Allowed values: 0,1,3,7,14,31.

	.PARAMETER AllowMove
		Optional. Default false. If set to true, messages may not be moved out of this email account into another account.
		Also prevents forwarding or replying from a different account than the message was originated from.

	.PARAMETER UseOnlyinMail
		Optional. Default false. If set to true, this account will not be available for sending mail in third party applications.

	.PARAMETER UseSMIME
		Optional. Default false. If set to true, this account supports S/MIME.

	.PARAMETER AllowRecentAddressSyncing
		If true, this account is excluded from address Recents syncing. This defaults to false.

	.PARAMETER Syncinterval
		How often the device will sync with the Exchange server. Allowed values: Automatic Push, Manually, 15 minutes, 30 minutes, 60 minutes.

	.PARAMETER SyncEmail
		Whether to synchronize email between the device and the server.

	.PARAMETER SyncCalendar
		Whether to synchronize calendar between the device and the server.

	.PARAMETER SyncContacts
		Whether to synchronize contacts between the device and the server.

	.PARAMETER SyncTasks
		Whether to synchronize tasks between the device and the server.

	.PARAMETER ChangelogComment
		Comment you wish to be added to the changelog.

	.EXAMPLE
		PS C:\> Add-CapaExchangePayloadToProfile -CapaSDK $CapaSDK @(
			ID = 1
			AccountName = 'Test'
			DomainandUserName = 'tre@myco.com'
			Password = '123456'
			EmailAddress = 'tre@myco.com'
			ExchangeActiveSyncHost = 'outlook.office365.com'
			UseSSL = 'True'
			PastDaysofMailtoSync = 14
			AllowMove = 'True'
			UseOnlyinMail = 'False'
			UseSMIME = 'False'
			AllowRecentAddressSyncing = 'True'
			Syncinterval = '30 minutes'
			SyncEmail = 'True'
			SyncCalendar = 'True'
			SyncContacts = 'True'
			SyncTasks = 'True'
			ChangelogComment = 'Adding Exchange payload to profile'
		)

	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246500/Add+Exchange+Payload+to+Profile
#>
function Add-CapaExchangePayloadToProfile {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$ProfileID,
		[Parameter(Mandatory = $true)]
		[string]$AccountName,
		[Parameter(Mandatory = $false)]
		[string]$DomainandUserName,
		[Parameter(Mandatory = $false)]
		[securestring]$Password = '',
		[Parameter(Mandatory = $true)]
		[string]$EmailAddress,
		[Parameter(Mandatory = $true)]
		[string]$ExchangeActiveSyncHost,
		[Parameter(Mandatory = $true)]
		[ValidateSet('True', 'False')]
		[bool]$UseSSL,
		[Parameter(Mandatory = $false)]
		[ValidateSet('0', '1', '3', '7', '14', '31')]
		[int]$PastDaysofMailtoSync = 0,
		[ValidateSet('True', 'False')]
		[bool]$AllowMove = $false,
		[ValidateSet('True', 'False')]
		[bool]$UseOnlyinMail = $false,
		[ValidateSet('True', 'False')]
		[bool]$UseSMIME = $false,
		[ValidateSet('False', 'True')]
		[bool]$AllowRecentAddressSyncing = $false,
		[Parameter(Mandatory = $true)]
		[ValidateSet('Automatic Push', 'Manually', '15 minutes', '30 minutes', '60 minutes')]
		[string]$Syncinterval,
		[ValidateSet('False', 'True')]
		[bool]$SyncEmail = $false,
		[ValidateSet('False', 'True')]
		[bool]$SyncCalendar = $false,
		[ValidateSet('False', 'True')]
		[bool]$SyncContacts = $false,
		[ValidateSet('False', 'True')]
		[bool]$SyncTasks = $false,
		[string]$ChangelogComment = ''
	)

	$value = $CapaSDK.AddExchangePayloadToProfile($ProfileID, $AccountName, $DomainandUserName, $Password, $EmailAddress, $ExchangeActiveSyncHost, $UseSSL, $PastDaysofMailtoSync, $AllowMove, $UseOnlyinMail, $UseSMIME, $AllowRecentAddressSyncing, $Syncinterval, $SyncEmail, $SyncCalendar, $SyncContacts, $SyncTasks, $ChangelogComment)
	return $value
}
