# Job_WriteLog

Module: Capa.PowerShell.Module.PowerPack.Job

## SYNOPSIS
This function will write a log entry.

## SYNTAX

```
Job_WriteLog [-Text] <String> [[-FunctionName] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```
Job_WriteLog -FunctionName "Install" -Text "Installing application"
```

### EXAMPLE 2
```
Log_SectionHeader -Name "Install"
PS C:\> Job_WriteLog -Text "Installing application"
```

## PARAMETERS

### -FunctionName
Name of function to associate with log entry (default blank, Log_Sectionheader will override).

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

### -Text
The text to write to the log.

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
For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455683/cs.Job+WriteLog

## RELATED LINKS
