# Count-CapaConscomActions

## SYNOPSIS
Counts the number of conscom actions.

## SYNTAX

```
Count-CapaConscomActions [-CapaSDK] <Object> [-ManagementServerID] <Int32> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Counts the number of conscom actions.

## EXAMPLES

### EXAMPLE 1
```
Count-CapaConscomActions -CapaSDK $CapaSDK -ManagementServerID 1
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

### -ManagementServerID
The management server ID to check for.
If omitted, conscom actions for all servers are counted.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247078/Count+conscom+actions

## RELATED LINKS
