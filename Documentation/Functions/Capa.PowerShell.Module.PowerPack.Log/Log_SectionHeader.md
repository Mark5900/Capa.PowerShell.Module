---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.PowerPack.Log-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.PowerPack.Log
ms.date: 05/10/2025
PlatyPS schema version: 2024-05-01
title: Log_SectionHeader
---

# Log_SectionHeader

## SYNOPSIS

Creates a section header in the logfile.

## SYNTAX

### __AllParameterSets

```
Log_SectionHeader [-Name] <string> [[-FrameCharacter] <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

This function creates a section header in the logfile.

## EXAMPLES

### EXAMPLE 1

Log_SectionHeader -Name "Install"

### EXAMPLE 2

Log_SectionHeader -Name "Install" -FrameCharacter "="

## PARAMETERS

### -FrameCharacter

The character to use for the frame, default is 'o'.

```yaml
Type: System.String
DefaultValue: o
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 1
  IsRequired: false
  ValueFromPipeline: false
  ValueFromPipelineByPropertyName: false
  ValueFromRemainingArguments: false
DontShow: false
AcceptedValues: []
HelpMessage: ''
```

### -Name

The name of the section.

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
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

For more information, please visit https://capasystems.atlassian.net/wiki/spaces/CI65DOC/pages/19462455700/cs.Log+SectionHeader


## RELATED LINKS

{{ Fill in the related links here }}

