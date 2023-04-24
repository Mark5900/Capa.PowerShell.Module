# Add-CapaExchangePayloadToProfile
Module: Capa.PowerShell.Module.SDK.MDM

This will add a new Exchange payload to a profile.

## Syntax

```powershell
Add-CapaExchangePayloadToProfile
	-CapaSDK <Object>
	-ProfileID <Int32>
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
	-SyncCalendar <Boolean>
	-SyncContacts <Boolean>
	-SyncTasks <Boolean>
	-ChangelogComment <String>
```

## Description

This will add a new Exchange payload to a profile.

## Examples

### Example 1
```powershell
Add-CapaExchangePayloadToProfile -CapaSDK $CapaSDK @(
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

The ID of the profile you wish to add the Exchange payload to.
| Name | Value |
| ---- | ---- |
| Type: | Int32 |
| Position: | 2 | 
| Default value: | 0 | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**AccountName**

Name of the Exchange ActiveSync/Web Services account.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 3 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**DomainandUserName**

The domain and username of the Exchange account.
If missing, the devices prompts for it during profile installation.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 4 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Password**

The password of the Exchange account.
| Name | Value |
| ---- | ---- |
| Type: | SecureString |
| Position: | 5 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**EmailAddress**

Specifies the full email address for the account. The owners (primary user) email address must be injected upon delivery to the device.
If not present in the payload, the device prompts for this string during profile installation.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 6 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**ExchangeActiveSyncHost**

Specifies the Exchange server host name (or IP address).
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 7 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**UseSSL**

Specifies whether the Exchange server uses SSL for authentication.
| Name | Value |
| ---- | ---- |
| Type: | Boolean |
| Position: | 8 | 
| Default value: | False | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**PastDaysofMailtoSync**

The number of past days of mail to synchronize. No limit = 0. Allowed values: 0,1,3,7,14,31.
| Name | Value |
| ---- | ---- |
| Type: | Int32 |
| Position: | 9 | 
| Default value: | 0 | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**AllowMove**

Optional. Default false. If set to true, messages may not be moved out of this email account into another account.
Also prevents forwarding or replying from a different account than the message was originated from.
| Name | Value |
| ---- | ---- |
| Type: | Boolean |
| Position: | 10 | 
| Default value: | False | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**UseOnlyinMail**

Optional. Default false. If set to true, this account will not be available for sending mail in third party applications.
| Name | Value |
| ---- | ---- |
| Type: | Boolean |
| Position: | 11 | 
| Default value: | False | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**UseSMIME**

Optional. Default false. If set to true, this account supports S/MIME.
| Name | Value |
| ---- | ---- |
| Type: | Boolean |
| Position: | 12 | 
| Default value: | False | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**AllowRecentAddressSyncing**

If true, this account is excluded from address Recents syncing. This defaults to false.
| Name | Value |
| ---- | ---- |
| Type: | Boolean |
| Position: | 13 | 
| Default value: | False | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**Syncinterval**

How often the device will sync with the Exchange server. Allowed values: Automatic Push, Manually, 15 minutes, 30 minutes, 60 minutes.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 14 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**SyncEmail**

Whether to synchronize email between the device and the server.
| Name | Value |
| ---- | ---- |
| Type: | Boolean |
| Position: | 15 | 
| Default value: | False | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 

-**SyncCalendar**

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

Comment you wish to be added to the changelog.
| Name | Value |
| ---- | ---- |
| Type: | String |
| Position: | 19 | 
| Default value: | None | 
| Accept pipeline input: | false | 
| Accept wildcard characters: | false | 


## Notes

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246500/Add+Exchange+Payload+to+Profile
