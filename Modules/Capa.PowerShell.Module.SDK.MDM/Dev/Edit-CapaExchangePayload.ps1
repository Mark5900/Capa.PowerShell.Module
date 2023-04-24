<#
	.SYNOPSIS
		Editing an existing Exchange Payload.
	
	.DESCRIPTION
		Editing an existing Exchange Payload in the specified profile.
	
	.PARAMETER CapaSDK
		The CapaSDK object.
	
	.PARAMETER ProfileID
		The ID of the profile you wish to add the exchange payload to.
	
	.PARAMETER CurrentAccountName
		The account name of the exchange payload you wish to edit.
	
	.PARAMETER AccountName
		Name for the Exchange ActiveSync/Web Services Account.
	
	.PARAMETER DomainandUserName
		This string specifies the user name for this Exchange account. If missing, the devices prompts for it during profile installation.
		Format is  "<domain>\<username>"  e.g. "mydomain.com\$LoginName$"
	
	.PARAMETER Password
		Optional. The password of the account. Use only with encrypted profiles.
	
	.PARAMETER EmailAddress
		Specifies the full email address for the account. The owners (primary user) email address must be injected upon delivery to the device.
		If not present in the payload, the device prompts for this string during profile installation. In OS X, this key is required.
	
	.PARAMETER ExchangeActiveSyncHost
		Specifies the Exchange server host name (or IP address). In OS X, this key is required.
	
	.PARAMETER UseSSL
		Specifies whether the Exchange server uses SSL for authentication.
	
	.PARAMETER PastDaysofMailtoSync
		The number of past days of mail to syncronize. No limit = 0. Allowed values: 0,1,3,7,14,31.
	
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
		Whether to synchronize calendar between the device and the server.
	
	.PARAMETER SyncContacts
		Whether to synchronize contacts between the device and the server.
	
	.PARAMETER SyncTasks
		Whether to synchronize tasks between the device and the server.
	
	.PARAMETER ChangelogComment
		Comment to add to the changelog when calling this function.
	
	.EXAMPLE
		PS C:\> Edit-CapaExchangePayload @(
			CapaSDK = $CapaSDK
			ProfileID = 1
			CurrentAccountName = "Test"
			AccountName = "Test"
			DomainandUserName = "Domain\Test"
			Password = "1234"
			EmailAddress = "Test@Test.com"
			ExchangeActiveSyncHost = "outlook.office365.com"
			UseSSL = $true
			PastDaysofMailtoSync = 7
			AllowMove = $true
			UseOnlyinMail = $false
			UseSMIME = $false
			AllowRecentAddressSyncing = $true
			syncinterval = "30 minutes"
			SyncEmail = $true
			SyncContacts = $true
			SyncTasks = $false
			ChangelogComment = "Editing Exchange Payload"
		)
	
	.NOTES
		For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246594/Edit+Exchange+Payload
#>
function Edit-CapaExchangePayload {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		$CapaSDK,
		[Parameter(Mandatory = $true)]
		[int]$ProfileID,
		[Parameter(Mandatory = $true)]
		[string]$CurrentAccountName,
		[Parameter(Mandatory = $true)]
		[string]$AccountName,
		[Parameter(Mandatory = $true)]
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
		[bool]$SyncContacts = $false,
		[ValidateSet('False', 'True')]
		[bool]$SyncTasks = $false,
		[string]$ChangelogComment = ''
	)
	
	$value = $CapaSDK.EditExchangePayload($ProfileID, $CurrentAccountName, $AccountName, $DomainandUserName, $Password, $EmailAddress, $ExchangeActiveSyncHost, $UseSSL, $PastDaysofMailtoSync, $AllowMove, $UseOnlyinMail, $UseSMIME, $AllowRecentAddressSyncing, $Syncinterval, $SyncEmail, $SyncContacts, $SyncTasks, $ChangelogComment)
	return $value
}
