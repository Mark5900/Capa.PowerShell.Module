# Exit-PpScript

Module: Capa.PowerShell.Module.PowerPack.Exit

## SYNOPSIS
Exit the script with a given exit code and message.

## SYNTAX

```
Exit-PpScript [-ExitCode] <Object> [[-ExitMessage] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Exit the script with a given exit code and message.

## EXAMPLES

### EXAMPLE 1
```
Exit-PpScript -ExitCode 0 -ExitMessage "Script ended successfully"
```

### EXAMPLE 2
```
Exit-PpScript -ExitCode 3305
```

## PARAMETERS

### -ExitCode
The exit code to exit the script with.

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

### -ExitMessage
The message to write to the log before exiting the script.

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
Command from PSlib.psm1

## RELATED LINKS
