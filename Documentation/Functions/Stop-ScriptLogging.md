# Stop-ScriptLogging

Module: Capa.PowerShell.Module.Tools

## SYNOPSIS
Stops logging of a script.

## SYNTAX

```
Stop-ScriptLogging [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Stops all started logging sesion started by running ITCE-StartScriptLoggin.

## EXAMPLES

### EXAMPLE 1
```
Stop-ScriptLogging
```

## PARAMETERS

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
This is a custom function created to have a standard way of starting logging in SDK scripts.

## RELATED LINKS
