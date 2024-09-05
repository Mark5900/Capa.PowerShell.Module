# Log_SectionHeader

Module: Capa.PowerShell.Module.PowerPack.Log

## SYNOPSIS
Creates a section header in the logfile.

## SYNTAX

```
Log_SectionHeader [-Name] <String> [[-FrameCharacter] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```
Log_SectionHeader -Name "Install"
```

### EXAMPLE 2
```
Log_SectionHeader -Name "Install" -FrameCharacter "="
```

## PARAMETERS

### -FrameCharacter
The character to use for the frame, default is 'o'.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: O
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
The name of the section.

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
For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455700/cs.Log+SectionHeader

## RELATED LINKS
