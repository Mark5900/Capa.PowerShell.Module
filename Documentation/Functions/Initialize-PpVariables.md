# Initialize-PpVariables

Module: Capa.PowerShell.Module.PowerPack

## SYNOPSIS
Initialize global variables

## SYNTAX

```
Initialize-PpVariables [[-DllPath] <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Initialize global variables

## EXAMPLES

### EXAMPLE 1
```
Initialize-PpVariables -DllPath 'C:\Program Files (x86)\CapaOne\Scripting Library\CapaOne.ScriptingLibrary.dll'
```

## PARAMETERS

### -DllPath
The path to the CapaOne.ScriptingLibrary.dll.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: $Global:DllPath
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
