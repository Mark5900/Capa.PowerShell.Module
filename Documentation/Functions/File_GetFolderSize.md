# File_GetFolderSize

Module: Capa.PowerShell.Module.PowerPack.File

## SYNOPSIS
Get the size of a folder.

## SYNTAX

```
File_GetFolderSize [-FilePath] <String> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Get the size of a folder and return the size in bytes.

## EXAMPLES

### EXAMPLE 1
```
File_GetFolderSize -FilePath "C:\Temp"
```

## PARAMETERS

### -FilePath
The folder to get the size from.

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
For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI66DOC/pages/20251410491/cs.File_GetFolderSize

## RELATED LINKS
