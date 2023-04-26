# Edit-CapaExchangePayload
Module: Capa.PowerShell.Module.SDK.MDM

Editing an existing Exchange Payload.

## Syntax

```powershell
Edit-CapaExchangePayload
	-CapaSDK <Object>
	-ProfileID <Int32>
	-CurrentAccountName <String>
	-AccountName <String>
	-DomainandUserName <String>
	-Password <SecureString>
	-EmailAddress <String>
	-ExchangeActiveSyncHost <String>
	-UseSSL <Boolean>
	-PastDaysofMailtoSync <Int32>
	-AllowMove <Boolean>
	-UseOnlyinMail <Boolean>
	-UseSMIME <Boolean>
	-AllowRecentAddressSyncing <Boolean>
	-Syncinterval <String>
	-SyncEmail <Boolean>
	-SyncContacts <Boolean>
	-SyncTasks <Boolean>
	-ChangelogComment <String>
```

## Description

Editing an existing Exchange Payload in the specified profile.

## Examples

### Example 1
```powershell
Edit-CapaExchangePayload @(
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
```
    

## Parameters

-**CapaSDK**

The CapaSDK object.
| Name | Value |
| ---- | ---- |
| Type: | Object |
| Position: | 1 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ProfileID**

The ID of the profile you wish to add the exchange payload to.
| Name | Value |
| ---- | ---- |
| Type: | Int32 |
| Position: | 2 | 
| Default value: | 0 | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**CurrentAccountName**

The account name of the exchange payload you wish to edit.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 3 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**AccountName**

Name for the Exchange ActiveSync/Web Services Account.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 4 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**DomainandUserName**

This string specifies the user name for this Exchange account. If missing, the devices prompts for it during profile installation.
Format is  "<domain>\<username>"  e.g. "mydomain.com\$LoginName$"
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 5 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Password**

Optional. The password of the account. Use only with encrypted profiles.
| Name | Value |
| ---- | ---- |
| Type: | SecureString |
| Position: | 6 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**EmailAddress**

Specifies the full email address for the account. The owners (primary user) email address must be injected upon delivery to the device.
If not present in the payload, the device prompts for this string during profile installation. In OS X, this key is required.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 7 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ExchangeActiveSyncHost**

Specifies the Exchange server host name (or IP address). In OS X, this key is required.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 8 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**UseSSL**

Specifies whether the Exchange server uses SSL for authentication.
| Name | Value |
| ---- | ---- |
| Type: | Boolean |
| Position: | 9 | 
| Default value: | False | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**PastDaysofMailtoSync**

The number of past days of mail to syncronize. No limit = 0. Allowed values: 0,1,3,7,14,31.
| Name | Value |
| ---- | ---- |
| Type: | Int32 |
| Position: | 10 | 
| Default value: | 0 | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**AllowMove**

Optional. Default false. If set to true, messages may not be moved out of this email account into another account.
Also prevents forwarding or replying from a different account than the message was originated from.
| Name | Value |
| ---- | ---- |
| Type: | Boolean |
| Position: | 11 | 
| Default value: | False | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**UseOnlyinMail**

Optional. Default false. If set to true, this account will not be available for sending mail in third party applications.
| Name | Value |
| ---- | ---- |
| Type: | Boolean |
| Position: | 12 | 
| Default value: | False | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**UseSMIME**

Optional. Default false. If set to true, this account supports S/MIME.
| Name | Value |
| ---- | ---- |
| Type: | Boolean |
| Position: | 13 | 
| Default value: | False | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**AllowRecentAddressSyncing**

If true, this account is excluded from address Recents syncing. This defaults to false.
| Name | Value |
| ---- | ---- |
| Type: | Boolean |
| Position: | 14 | 
| Default value: | False | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Syncinterval**

How often the device will sync with the Exchange server. Allowed values: Automatic Push, Manually, 15 minutes, 30 minutes, 60 minutes.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 15 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**SyncEmail**

Whether to synchronize calendar between the device and the server.
| Name | Value |
| ---- | ---- |
| Type: | Boolean |
| Position: | 16 | 
| Default value: | False | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**SyncContacts**

Whether to synchronize contacts between the device and the server.
| Name | Value |
| ---- | ---- |
| Type: | Boolean |
| Position: | 17 | 
| Default value: | False | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**SyncTasks**

Whether to synchronize tasks between the device and the server.
| Name | Value |
| ---- | ---- |
| Type: | Boolean |
| Position: | 18 | 
| Default value: | False | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ChangelogComment**

Comment to add to the changelog when calling this function.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 19 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246594/Edit+Exchange+Payload
