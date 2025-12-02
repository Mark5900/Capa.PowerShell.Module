---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.PowerPack.File-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.PowerPack.File
ms.date: 12/02/2025
PlatyPS schema version: 2024-05-01
title: File_DeleteLineInFile
---

# File_DeleteLineInFile

## SYNOPSIS

Delete a line in a file.

## SYNTAX

### __AllParameterSets

```
File_DeleteLineInFile [-File] <string> [-Text] <string> [[-OnlyFirstMatch] <bool>]
 [[-IgnoreCase] <bool>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

This function deletes a line in a file that contains the specified text.

## EXAMPLES

### EXAMPLE 1

File_DeleteLineInFile -File "C:\Temp\test.txt" -Text "Hello World"

## PARAMETERS

### -File

The file to delete the line from.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 0
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -IgnoreCase

Ignore case, default is false.

```yaml
Type: System.Boolean
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 3
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -OnlyFirstMatch

Delete only the first match, default is false.

```yaml
Type: System.Boolean
DefaultValue: False
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 2
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Text

The text to delete from the file.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
Aliases: []
ParameterSets:
- Name: (All)
  Position: 1
  IsRequired: true
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455462/cs.File+DeleteLineInFile


## RELATED LINKS

{{ Fill in the related links here }}

