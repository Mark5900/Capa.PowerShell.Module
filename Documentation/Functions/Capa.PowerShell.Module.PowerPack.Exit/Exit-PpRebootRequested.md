---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.PowerPack.Exit-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.PowerPack.Exit
ms.date: 12/02/2025
PlatyPS schema version: 2024-05-01
title: Exit-PpRebootRequested
---

# Exit-PpRebootRequested

## SYNOPSIS

Set error code that a reboot is requested.

## SYNTAX

### __AllParameterSets

```
Exit-PpRebootRequested [[-ExitMessage] <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

## EXAMPLES

### EXAMPLE 1

Exit-PpRebootRequested

### EXAMPLE 2

Exit-PpRebootRequested -ExitMessage 'Test where I set ExitMessage'

## PARAMETERS

### -ExitMessage

{{ Fill ExitMessage Description }}

```yaml
Type: System.String
DefaultValue: ''
SupportsWildcards: false
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

