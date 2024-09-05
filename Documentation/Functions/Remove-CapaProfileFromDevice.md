# Remove-CapaProfileFromDevice

Module: Capa.PowerShell.Module.SDK.MDM

## SYNOPSIS
This function will remove a profile from a device.

## SYNTAX

### NameType
```
Remove-CapaProfileFromDevice -CapaSDK <Object> -UnitName <String> -ProfileName <String>
 -ChangelogComment <String> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### Uuid
```
Remove-CapaProfileFromDevice -CapaSDK <Object> -UUID <String> -ProfileName <String> -ChangelogComment <String>
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
This function will remove a profile from a device, subsequently when the device reports successful removal of the profile, the relation is then removed from the database

## EXAMPLES

### EXAMPLE 1
```
Remove-CapaProfileFromDevice -CapaSDK $CapaSDK -UnitName 'Testdev01' -ProfileName 'Wi-Fi settings'
```

### EXAMPLE 2
```
Remove-CapaProfileFromDevice -CapaSDK $CapaSDK -Uuid '4eea2959-fb4c-4afe-b61f-810cb3019cd6' -ProfileName 'Wi-Fi settings'
```

### EXAMPLE 3
```
Remove-CapaProfileFromDevice -CapaSDK $CapaSDK -UnitName 'Testdev01' -ProfileName 'Wi-Fi settings' -ChangelogComment 'Removing profile from device'
```

## PARAMETERS

### -CapaSDK
The CapaSDK object.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ChangelogComment
The comment that will be added to the changelog.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProfileName
The name of the MDM profile.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
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

### -UnitName
The unit name of the unit.

```yaml
Type: String
Parameter Sets: NameType
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UUID
The UUID of the unit.

```yaml
Type: String
Parameter Sets: Uuid
Aliases:

Required: True
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
For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246487/Remove+profile+from+device

## RELATED LINKS
