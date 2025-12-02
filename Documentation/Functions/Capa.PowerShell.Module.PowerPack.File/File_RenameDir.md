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
title: File_RenameDir
---

# File_RenameDir

## SYNOPSIS

Rename a folder.

## SYNTAX

### __AllParameterSets

```
File_RenameDir [-Source] <string> [-Destination] <string> [[-Overwrite] <bool>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

This function renames the specified folder.

## EXAMPLES

### EXAMPLE 1

File_RenameDir -Source "C:\Temp\test" -Destination "C:\Temp\test2"

## PARAMETERS

### -Destination

The new name of the folder.

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

### -Overwrite

Overwrite the destination folder if it already exists, default is true (equals copytree and delete source).

```yaml
Type: System.Boolean
DefaultValue: True
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

### -Source

The folder to rename.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable,
-ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455598/cs.File+RenameDir


## RELATED LINKS

{{ Fill in the related links here }}

