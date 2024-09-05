# Get-CapaGroups

Module: Capa.PowerShell.Module.SDK.Group

## SYNOPSIS
Get groups.

## SYNTAX

```
Get-CapaGroups [-CapaSDK] <Object> [[-GroupType] <String>] [[-BusinessUnit] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Get either all groups or from all groups from specific business unit.

## EXAMPLES

### EXAMPLE 1
```
Get-CapaGroups -CapaSDK $CapaSDK
```

### EXAMPLE 2
```
Get-CapaGroups -CapaSDK $CapaSDK -GroupType Dynamic_ADSI
```

## PARAMETERS

### -BusinessUnit
If specified, only groups from this business unit will be returned.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CapaSDK
CapaSDK object.

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

### -GroupType
{{ Fill GroupType Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
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
For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246280/Get+groups
And https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306246290/Get+groups+on+Business+Unit

## RELATED LINKS
