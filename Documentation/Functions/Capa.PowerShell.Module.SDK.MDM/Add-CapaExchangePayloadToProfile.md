---
document type: cmdlet
external help file: Capa.PowerShell.Module.SDK.MDM-Help.xml
HelpUri: ''
layout: single
Locale: en-DK
Module Name: Capa.PowerShell.Module.SDK.MDM
ms.date: 05/09/2025
PlatyPS schema version: 2024-05-01
title: Add-CapaExchangePayloadToProfile
---

# Add-CapaExchangePayloadToProfile

## SYNOPSIS

This will add a new Exchange payload to a profile.

## SYNTAX

### __AllParameterSets

```
Add-CapaExchangePayloadToProfile [-CapaSDK] <Object> [-ProfileID] <int> [-AccountName] <string>
 [[-DomainandUserName] <string>] [[-Password] <securestring>] [-EmailAddress] <string>
 [-ExchangeActiveSyncHost] <string> [-UseSSL] <bool> [[-PastDaysofMailtoSync] <int>]
 [[-AllowMove] <bool>] [[-UseOnlyinMail] <bool>] [[-UseSMIME] <bool>]
 [[-AllowRecentAddressSyncing] <bool>] [-Syncinterval] <string> [[-SyncEmail] <bool>]
 [[-SyncCalendar] <bool>] [[-SyncContacts] <bool>] [[-SyncTasks] <bool>]
 [[-ChangelogComment] <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

This will add a new Exchange payload to a profile.

## EXAMPLES

### EXAMPLE 1

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

## PARAMETERS

### -AccountName

Name of the Exchange ActiveSync/Web Services account.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 2
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -AllowMove

Optional.
Default false.
If set to true, messages may not be moved out of this email account into another account.
Also prevents forwarding or replying from a different account than the message was originated from.

```yaml
Type: System.Boolean
DefaultValue: False
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 9
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -AllowRecentAddressSyncing

If true, this account is excluded from address Recents syncing.
This defaults to false.

```yaml
Type: System.Boolean
DefaultValue: False
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 12
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -CapaSDK

The CapaSDK object.

```yaml
Type: System.Object
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 0
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ChangelogComment

Comment you wish to be added to the changelog.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 18
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -DomainandUserName

The domain and username of the Exchange account.
If missing, the devices prompts for it during profile installation.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 3
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -EmailAddress

Specifies the full email address for the account.
The owners (primary user) email address must be injected upon delivery to the device.
If not present in the payload, the device prompts for this string during profile installation.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 5
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ExchangeActiveSyncHost

Specifies the Exchange server host name (or IP address).

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 6
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Password

The password of the Exchange account.

```yaml
Type: System.Security.SecureString
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 4
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -PastDaysofMailtoSync

The number of past days of mail to synchronize.
No limit = 0.
Allowed values: 0,1,3,7,14,31.

```yaml
Type: System.Int32
DefaultValue: 0
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 8
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -ProfileID

The ID of the profile you wish to add the Exchange payload to.

```yaml
Type: System.Int32
DefaultValue: 0
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 1
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -SyncCalendar

Whether to synchronize calendar between the device and the server.

```yaml
Type: System.Boolean
DefaultValue: False
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 15
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -SyncContacts

Whether to synchronize contacts between the device and the server.

```yaml
Type: System.Boolean
DefaultValue: False
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 16
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -SyncEmail

Whether to synchronize email between the device and the server.

```yaml
Type: System.Boolean
DefaultValue: False
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 14
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Syncinterval

How often the device will sync with the Exchange server.
Allowed values: Automatic Push, Manually, 15 minutes, 30 minutes, 60 minutes.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 13
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -SyncTasks

Whether to synchronize tasks between the device and the server.

```yaml
Type: System.Boolean
DefaultValue: False
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 17
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -UseOnlyinMail

Optional.
Default false.
If set to true, this account will not be available for sending mail in third party applications.

```yaml
Type: System.Boolean
DefaultValue: False
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 10
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -UseSMIME

Optional.
Default false.
If set to true, this account supports S/MIME.

```yaml
Type: System.Boolean
DefaultValue: False
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 11
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -UseSSL

Specifies whether the Exchange server uses SSL for authentication.

```yaml
Type: System.Boolean
DefaultValue: False
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 7
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246500/Add+Exchange+Payload+to+Profile


## RELATED LINKS

{{ Fill in the related links here }}

