---
document type: cmdlet
external help file: Capa.PowerShell.Module.PowerPack.Exit-Help.xml
HelpUri: ''
layout: single
Locale: en-DK
Module Name: Capa.PowerShell.Module.PowerPack.Exit
ms.date: 05/09/2025
PlatyPS schema version: 2024-05-01
title: Exit-PpCommandFailed
---

# Exit-PpCommandFailed

## SYNOPSIS

Set error code that the command failed.

## SYNTAX

### __AllParameterSets

```
Exit-PpCommandFailed [[-ExitMessage] <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

## EXAMPLES

### EXAMPLE 1

Exit-PpCommandFailed

### EXAMPLE 2

Exit-PpCommandFailed -ExitMessage 'Test where I set ExitMessage'

## PARAMETERS

### -ExitMessage

{{ Fill ExitMessage Description }}

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
ParameterValue: []
Aliases: []
ParameterSets:
- Name: (All)
  Position: 0
  IsRequired: false
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

Custom command.


## RELATED LINKS

{{ Fill in the related links here }}

