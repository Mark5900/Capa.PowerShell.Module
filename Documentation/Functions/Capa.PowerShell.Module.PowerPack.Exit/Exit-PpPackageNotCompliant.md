---
author_profile: true
document type: cmdlet
external help file: Capa.PowerShell.Module.PowerPack.Exit-Help.xml
HelpUri: ''
layout: single
Locale: en-US
Module Name: Capa.PowerShell.Module.PowerPack.Exit
ms.date: 07/16/2025
PlatyPS schema version: 2024-05-01
title: Exit-PpPackageNotCompliant
---

# Exit-PpPackageNotCompliant

## SYNOPSIS

Set error code that the package is not compliant.

## SYNTAX

### __AllParameterSets

```
Exit-PpPackageNotCompliant [[-ExitMessage] <string>] [<CommonParameters>]
```

## ALIASES

This cmdlet has the following aliases,
  {{Insert list of aliases}}

## DESCRIPTION

Uses the Exit-PpScript that comes from PSlib.psm1, to set the package error.

## EXAMPLES

### EXAMPLE 1

Exit-PpPackageNotCompliant

### EXAMPLE 2

Exit-PpPackageNotCompliant -ExitMessage 'Test where I set ExitMessage'

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

