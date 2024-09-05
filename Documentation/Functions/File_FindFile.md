# File_FindFile

Module: Capa.PowerShell.Module.PowerPack.File

## SYNOPSIS
Find a file.

## SYNTAX

```
File_FindFile [-FileName] <String> [-SearchRoot] <String> [[-Recursive] <Boolean>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```
File_FindFile -FileName "test.txt" -SearchRoot "C:\Temp"
```

## PARAMETERS

### -FileName
The file to find.

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

### -Recursive
Search in sub directories, relative to SearchRoot.
Default is true.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -SearchRoot
The root folder to start the search.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455547/cs.File+FindFile

## RELATED LINKS
