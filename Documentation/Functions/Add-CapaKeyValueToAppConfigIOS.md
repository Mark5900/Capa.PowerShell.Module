# Add-CapaKeyValueToAppConfigIOS

## SYNOPSIS
Add a new key/value setting to an existing AppConfig payload in the specified profile.

## SYNTAX

```
Add-CapaKeyValueToAppConfigIOS [-CapaSDK] <Object> [-DeviceApplicationID] <Int32> [-Key] <String>
 [-Value] <String> [-KeyValueType] <String> [[-ChangelogComment] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Add a new Key/Value setting to an existing AppConfig payload in the specified profile.
If a setting with the specified key and type already exists, its value will be overwritten with the new value instead of creating a new setting.

## EXAMPLES

### EXAMPLE 1
```
Add-CapaKeyValueToAppConfigIOS -CapaSDK $CapaSDK -DeviceApplicationID 1 -Key 'AllowSync' -Value 'True' -KeyValueType 'Boolean' -ChangelogComment 'Adding new key/value setting to AppConfig payload'
```

## PARAMETERS

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
The comment you wish to be added to the changelog.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DeviceApplicationID
The id of the Device Application you wish to edit.

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

### -Key
The Key of the new setting.

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

### -KeyValueType
The type of the new setting.
Valid types are: String, Boolean, Int, Float, DateTime.
(DateTime format: dd-MM-yyyy HH:mm:ss).

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

### -Value
The Value of the new setting.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246542/Add+edit+Key+Value+setting+to+iOS+AppConfig

## RELATED LINKS
