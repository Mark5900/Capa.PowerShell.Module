# Write-LogLine

## SYNOPSIS
Use to write a line to the log file.

## SYNTAX

```
Write-LogLine [-Text] <String> [[-ScriptPart] <String>] [[-ForegroundColor] <Object>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Used to write a  pretty line to the log file indstead of using Write-Host or Write-Output.

## EXAMPLES

### EXAMPLE 1
```
Write-LogLine -Text 'value1'
```

### EXAMPLE 2
```
Write-LogLine -Text 'value1' -ScriptPart 'Function1'
```

### EXAMPLE 3
```
Write-LogLine -Text 'value1' -ScriptPart 'Function1' -ForegroundColor 'Red'
```

## PARAMETERS

### -ForegroundColor
The color of the text.
Only usable to see in the console.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: (Get-Host).ui.rawui.ForegroundColor
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

### -ScriptPart
The part of the script that is writing to the log file.
Default value is 'Main'.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: Main
Accept pipeline input: False
Accept wildcard characters: False
```

### -Text
The text to write to the log file.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
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
