# Clone-CapaDeviceApplication

## SYNOPSIS
Clone an existing Device Application and its payloads.

## SYNTAX

```
Clone-CapaDeviceApplication [-CapaSDK] <Object> [-DeviceApplicationID] <Int32> [-NewName] <String>
 [[-ChangelogComment] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Clone an existing Device Application and its payloads.

## EXAMPLES

### EXAMPLE 1
```
Clone-CapaDeviceApplication -CapaSDK $CapaSDK -DeviceApplicationID 1 -NewName 'My New Device Application' -ChangelogComment 'Cloning Device Application'
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
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DeviceApplicationID
The id of the Device Application you wish to clone.

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

### -NewName
The name of the new Device Application.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246561/Clone+Device+Application

## RELATED LINKS
