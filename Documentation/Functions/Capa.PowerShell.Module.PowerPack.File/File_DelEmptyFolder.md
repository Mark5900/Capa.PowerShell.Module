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
title: File_DelEmptyFolder
---

# File_DelEmptyFolder

## SYNOPSIS

Delete path if it is empty.

## SYNTAX

### __AllParameterSets

```
File_DelEmptyFolder [-Path] <string> [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

This function deletes the specified path if it is empty.

## EXAMPLES

### EXAMPLE 1

File_DelEmptyFolder -Path "C:\Temp\test"

## PARAMETERS

### -Path

The path to delete.

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

https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455445/cs.File+DelEmptyFolder


## RELATED LINKS

{{ Fill in the related links here }}

