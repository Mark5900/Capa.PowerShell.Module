# Add-CapaExchangePayloadToProfile

Module: Capa.PowerShell.Module.SDK.MDM

## SYNOPSIS
This will add a new Exchange payload to a profile.

## SYNTAX

```
Add-CapaExchangePayloadToProfile [-CapaSDK] <Object> [-ProfileID] <Int32> [-AccountName] <String>
 [[-DomainandUserName] <String>] [[-Password] <SecureString>] [-EmailAddress] <String>
 [-ExchangeActiveSyncHost] <String> [-UseSSL] <Boolean> [[-PastDaysofMailtoSync] <Int32>]
 [[-AllowMove] <Boolean>] [[-UseOnlyinMail] <Boolean>] [[-UseSMIME] <Boolean>]
 [[-AllowRecentAddressSyncing] <Boolean>] [-Syncinterval] <String> [[-SyncEmail] <Boolean>]
 [[-SyncCalendar] <Boolean>] [[-SyncContacts] <Boolean>] [[-SyncTasks] <Boolean>]
 [[-ChangelogComment] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This will add a new Exchange payload to a profile.

## EXAMPLES

### EXAMPLE 1
```
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

## PARAMETERS

### -AccountName
Name of the Exchange ActiveSync/Web Services account.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllowMove
Optional.
Default false.
If set to true, messages may not be moved out of this email account into another account.
Also prevents forwarding or replying from a different account than the message was originated from.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllowRecentAddressSyncing
If true, this account is excluded from address Recents syncing.
This defaults to false.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -CapaSDK
The CapaSDK object.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ChangelogComment
Comment you wish to be added to the changelog.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 19
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DomainandUserName
The domain and username of the Exchange account.
If missing, the devices prompts for it during profile installation.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EmailAddress
Specifies the full email address for the account.
The owners (primary user) email address must be injected upon delivery to the device.
If not present in the payload, the device prompts for this string during profile installation.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExchangeActiveSyncHost
Specifies the Exchange server host name (or IP address).

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Password
The password of the Exchange account.

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PastDaysofMailtoSync
The number of past days of mail to synchronize.
No limit = 0.
Allowed values: 0,1,3,7,14,31.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProfileID
The ID of the profile you wish to add the Exchange payload to.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProgressAction
{{ Fill ProgressAction Description }}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SyncCalendar
Whether to synchronize calendar between the device and the server.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SyncContacts
Whether to synchronize contacts between the device and the server.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SyncEmail
Whether to synchronize email between the device and the server.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Syncinterval
How often the device will sync with the Exchange server.
Allowed values: Automatic Push, Manually, 15 minutes, 30 minutes, 60 minutes.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 14
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SyncTasks
Whether to synchronize tasks between the device and the server.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 18
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseOnlyinMail
Optional.
Default false.
If set to true, this account will not be available for sending mail in third party applications.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseSMIME
Optional.
Default false.
If set to true, this account supports S/MIME.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseSSL
Specifies whether the Exchange server uses SSL for authentication.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: True
Position: 8
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246500/Add+Exchange+Payload+to+Profile

## RELATED LINKS
