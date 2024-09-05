# Edit-CapaExchangePayload

## SYNOPSIS
Editing an existing Exchange Payload.

## SYNTAX

```
Edit-CapaExchangePayload [-CapaSDK] <Object> [-ProfileID] <Int32> [-CurrentAccountName] <String>
 [-AccountName] <String> [-DomainandUserName] <String> [[-Password] <SecureString>] [-EmailAddress] <String>
 [-ExchangeActiveSyncHost] <String> [-UseSSL] <Boolean> [[-PastDaysofMailtoSync] <Int32>]
 [[-AllowMove] <Boolean>] [[-UseOnlyinMail] <Boolean>] [[-UseSMIME] <Boolean>]
 [[-AllowRecentAddressSyncing] <Boolean>] [-Syncinterval] <String> [[-SyncEmail] <Boolean>]
 [[-SyncContacts] <Boolean>] [[-SyncTasks] <Boolean>] [[-ChangelogComment] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Editing an existing Exchange Payload in the specified profile.

## EXAMPLES

### EXAMPLE 1
```
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

## PARAMETERS

### -AccountName
Name for the Exchange ActiveSync/Web Services Account.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
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
Position: 11
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
Position: 14
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
Comment to add to the changelog when calling this function.

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

### -CurrentAccountName
The account name of the exchange payload you wish to edit.

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

### -DomainandUserName
This string specifies the user name for this Exchange account.
If missing, the devices prompts for it during profile installation.
Format is  "\<domain\>\\\<username\>"  e.g.
"mydomain.com\$LoginName$"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EmailAddress
Specifies the full email address for the account.
The owners (primary user) email address must be injected upon delivery to the device.
If not present in the payload, the device prompts for this string during profile installation.
In OS X, this key is required.

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

### -ExchangeActiveSyncHost
Specifies the Exchange server host name (or IP address).
In OS X, this key is required.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Password
Optional.
The password of the account.
Use only with encrypted profiles.

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PastDaysofMailtoSync
The number of past days of mail to syncronize.
No limit = 0.
Allowed values: 0,1,3,7,14,31.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProfileID
The ID of the profile you wish to add the exchange payload to.

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

### -Syncinterval
How often the device will sync with the Exchange server.
Allowed values: Automatic Push, Manually, 15 minutes, 30 minutes, 60 minutes.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 15
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
Position: 12
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
Position: 13
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
Position: 9
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246594/Edit+Exchange+Payload

## RELATED LINKS
