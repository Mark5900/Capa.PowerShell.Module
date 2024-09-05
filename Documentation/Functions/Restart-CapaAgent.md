# Restart-CapaAgent

Module: Capa.PowerShell.Module.SDK.Utilities

## SYNOPSIS
Sets an action to restart an agent.

## SYNTAX

```
Restart-CapaAgent [-CapaSDK] <Object> [-UnitName] <String> [-UnitType] <String>
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Sets an action to restart an agent.
If a user is specified, the agent on the computers linked to the user will be restarted.

## EXAMPLES

### EXAMPLE 1
```
Restart-CapaAgent -CapaSDK $CapaSDK -UnitName 'TestComputer' -UnitType 'Computer'
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
The name of the unit.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UnitType
The type of the unit.
This can be either "Computer" or "User"

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
For more information, see https://capasystems.atlassian.net/wiki/spaces/CI64DOC/pages/19306247696/Restart+Agent+using+SDK

## RELATED LINKS
