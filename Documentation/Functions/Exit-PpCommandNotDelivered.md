# Exit-PpCommandNotDelivered

Module: Capa.PowerShell.Module.PowerPack.Exit

## SYNOPSIS
Set error code that the command was not delivered.

## SYNTAX

```
Exit-PpCommandNotDelivered [[-ExitMessage] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

## EXAMPLES

### EXAMPLE 1
```
Exit-PpCommandNotDelivered
```

### EXAMPLE 2
```
Exit-PpCommandNotDelivered -ExitMessage 'The command was not delivered.'
```

## PARAMETERS

### -ExitMessage
Exit message to be displayed.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Custom command.

## RELATED LINKS
